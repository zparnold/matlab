function [lambda, vects] = wielandt ( A, num_pairs, TOL, Nmax )

%WIELANDT       apply Wielandt deflation to an arbitrary matrix to 
%               approximate a specified number of eigenpairs associated
%               with the either largest or the smallest eigenvalues of 
%               the matrix - the routine POWER_METHOD is used to approximate
%               eigenpairs associated with the largest eigenvalues, the
%               routine INV_POWER is used to approximate eigenpairs
%               associated with the smallest eigenvalues
%
%     calling sequences:
%             [lambda, vects] = wielandt ( A, num_pairs, TOL, Nmax )
%             lambda = wielandt ( A, num_pairs, TOL, Nmax )
%             wielandt ( A, num_pairs, TOL, Nmax )
%
%     inputs:
%             A       square symmetric matrix whose eigenpairs are to be 
%                     approximated
%             num_pairs
%                     number of eigenpairs to approximate
%                     if num_pairs > 0 then approximate largest eigenvalues
%                     if num_pairs < 0 then approximate smallest eigenvalues
%             TOL     absolute error convergence tolerance applied during
%                     each call to either POWER_METHOD or INV_POWER
%                     (convergence is measured in terms of the maximum
%                     norm of the difference between successive terms 
%                     in the eigenvector seqeunce)
%             Nmax    maximum number of iterations to be performed during
%                     each call to either POWER_METHOD or INV_POWER
%
%     outputs:
%             lambda  vector containing the largest/smallest 'num_pairs' 
%                     eigenvalues of the matrix A
%             vects   matrix containing eigenvectors corresponding to the 
%                     entries in the output vector 'lambda'
%                     - the i-th column of this matrix is an eigenvector,
%                       normalized to unit length in the maximum norm,
%                       corresponding to the i-th entry in the vector
%                       'lambda'
%
%     dependencies:
%             this routine makes use of the routines POWER_METHOD and
%             INV_POWER
%
%     NOTE:
%             if the maximum number of iterations is exceeded during any
%             call to either POWER_METHOD or INV_POWER, a message to this 
%             effect will be displayed 
%

[r, c] = size ( A );
if ( r ~= c )
   disp ( 'wielandt error: matrix must be square' );
   return;
end;
n = r;

if ( num_pairs < 0 )
   num_pairs = abs(num_pairs);
   small = 1;
else
   small = 0;
end;

l = zeros ( 1, num_pairs );
v = zeros ( n, num_pairs );
j = zeros ( 1, num_pairs );
x = zeros ( num_pairs, n );

if ( small == 0 )
   [l(1), v(:,1)] = power_method ( A, rand(n,1), TOL, Nmax );
else
   [l(1), v(:,1)] = inv_power ( A, 0, rand(1,n), TOL, Nmax );
end;

for i = 2:num_pairs
    j(i) = min ( find ( abs(v(:,i-1))  == max(abs(v(:,i-1))) ) );
	x(i,1:n+2-i) = A(j(i),:);
    A = wd ( A, n+2-i, j(i), v(:,i-1) );
	if ( small == 0 )
	   [l(i), v(1:n-i+1,i)] = power_method ( A, rand(n-i+1,1), TOL, Nmax );
	else
	   [l(i), v(1:n-i+1,i)] = inv_power ( A, 0, rand(1,n-i+1), TOL, Nmax );
	end;
end;

for i=num_pairs:-1:2
    for k=i:-1:2
	    temp = [v(1:j(k)-1, i); 0; v(j(k):n-k+1, i)];
		v(1:n-k+2,i) = (l(i) - l(k-1))*temp +(x(k,1:n+2-k)*temp)*v(1:n-k+2,k-1)/v(j(k),k-1);
	end;
    p = min ( find ( abs(v(:,i))  == max(abs(v(:,i))) ) );
    v(:,i) = v(:,i) / v(p,i);
end;

lambda = l;
vects = v;

return

function [lambda, v] = power_method ( A, x, TOL, Nmax )

%POWER_METHOD   approximate the dominant eigenvalue and an associated 
%               eigenvector for an arbitrary matrix using the power
%               method
%
%     calling sequences:
%             [lambda, v] = power_method ( A, x, TOL, Nmax )
%             lambda = power_method ( A, x, TOL, Nmax )
%             power_method ( A, x, TOL, Nmax )
%
%     inputs:
%             A       square matrix whose dominant eigenvalue is to be 
%                     approximated
%             x       initial approximation to eigenvector corresponding
%                     to the dominant eigenvalue
%             TOL     absolute error convergence tolerance
%                     (convergence is measured in terms of the maximum
%                     norm of the difference between successive terms 
%                     in the eigenvector seqeunce)
%             Nmax    maximum number of iterations to be performed
%
%     outputs:
%             lambda  approximation to dominant eigenvalue of A
%             v       an eigenvector of A corresponding to the eigenvalue
%                     lambda - vector will be normalized to unit length
%                     in the maximum norm
%
%     NOTE:
%             if POWER_METHOD is called with no output arguments, the 
%             iteration number, the current eigenvector approximation, 
%             the current eigenvalue approximation and an estimate of 
%             the rate of convergence of the eigenvalue sequence will
%             be displayed
%
%             if the maximum number of iterations is exceeded, a message
%             to this effect will be displayed and the most recent
%             approximations to the dominant eigenvalue and its corresponding
%             eigenvector will be returned in the output values
%

[r, c] = size ( A );
[rx, rc] = size ( x );
if ( rx == 1 ) x = x'; rx = rc; end;

if ( r ~= c )
   disp ( 'power_method error: matrix must be square' );
   return;
elseif ( r ~= rx )
   disp ( 'power_method error: dimensions of matrix and vector are not compatible' );
   return;
end;

p = min ( find ( abs(x)  == max(abs(x)) ) );
x = x / x(p);
mu_old = 0;

if ( nargout == 0 )
   s = sprintf ( '%3d \t %10f ', 0, x(1) );
   for j = 2 : rx 
	   s = sprintf ( '%s%10f ', s, x(j) );
   end;
   disp ( s );
end;

for i = 1 : Nmax
    xnew = A * x;
	mu = xnew(p);
	p = min ( find ( abs(xnew)  == max(abs(xnew)) ) );
    xnew = xnew / xnew(p);
	
	if ( nargout == 0 )
	   s = sprintf ( '%3d \t %10f ', i, xnew(1) );
	   for j = 2 : rx 
	       s = sprintf ( '%s%10f ', s, xnew(j) );
	   end;
	   s = sprintf ( '%s \t %10f', s, mu );
	   if ( i >= 2 ) s = sprintf ( '%s \t \t %10f', s, abs((mu-mu_old)/(mu_old-mu_older)) ); end;
	   disp ( s );
	end;
	
	err = max ( abs ( x - xnew ) );
	if ( err < TOL )
	   if ( nargout >= 1 ) lambda = mu; end;
	   if ( nargout >= 2 ) v = xnew; end;
	   return;
	else   
 	   x = xnew;
	   mu_older = mu_old;
	   mu_old = mu;
	end;
	
end

disp ( 'power_method error: Maximum number of iteration exceeded' );
if ( nargout >= 1 ) lambda = mu; end;
if ( nargout >= 2 ) v = xnew; end;

function [lambda, v] = inv_power ( A, q, x, TOL, Nmax )

%INV_POWER      approximate the eigenvalue nearest to the number q, 
%               and an associated eigenvector, for an arbitrary matrix 
%               using the inverse power method
%
%     calling sequences:
%             [lambda, v] = inv_power ( A, q, x, TOL, Nmax )
%             lambda = inv_power ( A, q, x, TOL, Nmax )
%             inv_power ( A, q, x, TOL, Nmax )
%
%     inputs:
%             A       square matrix whose eigenvalue nearest to the value 
%                     q is to be approximated
%             q       approximation to an eigenvalue of A
%             x       initial approximation to eigenvector corresponding
%                     to the eigenvalue nearest to q
%             TOL     absolute error convergence tolerance
%                     (convergence is measured in terms of the maximum
%                     norm of the difference between successive terms 
%                     in the eigenvector seqeunce)
%             Nmax    maximum number of iterations to be performed
%
%     outputs:
%             lambda  approximation to dominant eigenvalue of A
%             v       an eigenvector of A corresponding to the eigenvalue
%                     lambda - vector will be normalized to unit length
%                     in the maximum norm
%
%     dependencies:
%             this routine makes use of both LUfactor and LUsolve from 
%             "Systems of Equations" library
%
%     NOTE:
%             if INV_POWER is called with no output arguments, the 
%             iteration number, the current eigenvector approximation, 
%             the current eigenvalue approximation and an estimate of 
%             the rate of convergence of the eigenvalue sequence will
%             be displayed
%
%             if the maximum number of iterations is exceeded, a message
%             to this effect will be displayed and the most recent
%             approximations to the eigenvalue nearest to q and its 
%             corresponding eigenvector will be returned in the output values
%

[r, c] = size ( A );
[rx, rc] = size ( x );
if ( rc == 1 ) x = x'; rc = rx; end;

if ( r ~= c )
   disp ( 'inv_power error: matrix must be square' );
   return;
elseif ( r ~= rc )
   disp ( 'inv_power error: dimensions of matrix and vector are not compatible' );
   return;
end;


p = min ( find ( abs(x)  == max(abs(x)) ) );
x = x / x(p);
mu_old = 0;

if ( nargout == 0 )
   s = sprintf ( '%3d \t %10f ', 0, x(1) );
   for j = 2 : rc
	   s = sprintf ( '%s%10f ', s, x(j) );
   end;
   disp ( s );
end;

[lu, pvt] = LUfactor ( A - q*eye(rc) );

for i = 1 : Nmax
    xnew = LUsolve ( lu, x, pvt );
	mu = xnew(p);
	p = min ( find ( abs(xnew)  == max(abs(xnew)) ) );
    xnew = xnew / xnew(p);
	
	if ( nargout == 0 )
	   s = sprintf ( '%3d \t %10f ', i, xnew(1) );
	   for j = 2 : rc 
	       s = sprintf ( '%s%10f ', s, xnew(j) );
	   end;
	   s = sprintf ( '%s \t %10f', s, 1/mu+q );
	   if ( i >= 2 ) s = sprintf ( '%s \t \t %10f', s, abs((mu-mu_old)/(mu_old-mu_older)) ); end;
	   disp ( s );
	end;
	
	err = max ( abs ( x - xnew ) );
	if ( err < TOL )
	   if ( nargout >= 1 ) lambda = 1/mu+q; end;
	   if ( nargout >= 2 ) v = xnew'; end;
	   return;
	else   
 	   x = xnew;
	   mu_older = mu_old;
	   mu_old = mu;
	end;
	
end

disp ( 'inv_power error: Maximum number of iteration exceeded' );
if ( nargout >= 1 ) lambda = 1/mu+q; end;
if ( nargout >= 2 ) v = xnew; end;

function B = wd ( A, n, j, v )

temp = ( v / v(j) ) * A(j,:);
B = [A(1:j-1,1:j-1)-temp(1:j-1,1:j-1) A(1:j-1,j+1:n) - temp(1:j-1,j+1:n); ...
     A(j+1:n,1:j-1)-temp(j+1:n,1:j-1) A(j+1:n,j+1:n) - temp(j+1:n,j+1:n)];
return

function [lu, pvt] = LUfactor ( A )

%LUFACTOR     compute the LU decomposition for the matrix A
%
%     calling sequence:
%             [lu, pvt] = LUfactor ( A )
%
%     input:
%             A       coefficient matrix for linear system
%                     (matrix must be square)
%
%     outputs:
%             lu      matrix containing LU decomposition of input matrix
%                     A - the L matrix in the decomposition consists of
%                     1's along the main diagonal together with the 
%                     strictly lower triangular portion of the matrix lu;
%                     the U matrix in the decomposition is the upper
%                     triangular portion of the matrix lu
%             pvt     vector which indicates the permutation of the rows
%                     performed during the decomposition process
%
%     NOTE:
%             this routine performs partial pivoting during the 
%             decomposition process
%
%             the system Ax = b can be solved by first applying LUfactor
%             to the coefficient matrix A and then applying the companion
%             routine, LUsolve, for each right-hand side vector b
%

[nrow ncol] = size ( A );
if ( nrow ~= ncol )
   disp ( 'LUfactor error: Square coefficient matrix required' );
   return;
end;

%
%   initialize row pointers
%

for i=1:nrow
    pvt(i) = i;
end;

for i = 1 : nrow - 1

%
%   partial pivoting
%

	t =  min ( find ( abs(A(pvt(i:nrow),i)) == max(abs(A(pvt(i:nrow),i))) ) + i-1 );
    if ( t ~= i )
	   temp = pvt(i);
	   pvt(i) = pvt(t);
	   pvt(t) = temp;
	end;

%
%   terminate if matrix is singular
%

	if ( A(pvt(i),i) == 0 ) 
	   disp ( 'LUfactor error: coefficient matrix is singular' );
	   lu = A;
	   return
	end;
	
%
%   elimination steps
%

    for j = i+1 : nrow
	    m = -A(pvt(j),i) / A(pvt(i),i);
		A(pvt(j),i) = -m;
		A(pvt(j), i+1:nrow) = A(pvt(j), i+1:nrow) + m * A(pvt(i), i+1:nrow);
    end;
end;

lu = A;

function x = LUsolve ( lu, b, pvt )

%LUSOLVE      perform forward and backward substitution to obtain the
%             solution to the linear system Ax = b, where the LU
%             decomposition of the coefficient matrix has previously
%             been determined
%
%     calling sequence:
%             x = LUsolve ( lu, b, pvt )
%             LUsolve ( lu, b, pvt )
%
%     inputs:
%             lu      matrix containing LU decomposition of coefficient
%                     matrix for the linear system - the L matrix in the 
%                     decomposition must consists of 1's along the main  
%                     diagonal together with the strictly lower triangular 
%                     portion of the matrix lu; the U matrix in the 
%                     decomposition must be the upper triangular portion 
%                     of the matrix lu
%             b       right-hand side vector for linear system
%             pvt     vector which indicates the permutation of the rows
%                     performed during the LU decomposition of the 
%                     coefficient matrix
%
%     output:
%             x       solution vector
%
%     NOTE:
%             the system Ax = b can be solved by first applying LUfactor
%             to the coefficient matrix A and then applying LUsolve once
%             for each right-hand side vector b
%

[nrow ncol] = size ( lu );

%
%   forward substitution
%

z(1) = b(pvt(1));
for i = 2 : nrow
    z(i) = b(pvt(i)) - sum ( z(1:i-1) .* lu(pvt(i), 1:i-1) );
end;

%
%   back substitution
%

x(nrow) = z(nrow) / lu(pvt(nrow), nrow);
for i = nrow - 1 : -1 : 1
    x(i) = ( z(i) - sum ( x(i+1:nrow) .* lu(pvt(i), i+1:nrow) ) ) / lu(pvt(i),i);
end;

