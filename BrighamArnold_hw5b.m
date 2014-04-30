function [v,lambdas] = Brigham_Arnold_hw5b(A)
%This is the attempted solution to homework 5b for Joe Brigham (jcbrigham) and Zach Arnold (zparnold)
format long;

%there were too many loops and confusing things in this function, so a revision has changed 
%everything so that I can use multiple functions (and in the same file!)

%initialize variables
n = length(A);

%initialize returns
%I've discovered that I don't actually have to do this,
%but since I've learned the hard way that un-initialized
%variables are disastrous...I will do so anyway
lambdas = zeros(n,1);
v = zeros(n);

%issue directives to sub-functions
%business logic explained in encapsulated functions below


%inv power method (comment out below 3 lines to see only deflation
deflate = false;
[v,lambdas] = shifted_inverse_power_method(A,n);
[lambdas(n),v(1:n,n)]=power_method(A);

%deflation (comment out below 2 lines to see only inv power results
[v,lambdas]=weilandt_deflation_method(A,n);
deflate = true;

%again I can't explain why, but the lambdas and V's are out of order, but I can attempt to sort them
if (deflate)
	if (lambdas(n-1) < lambdas(n))
		%the while loop tolerance of 1e-16 didn't work...(see below) I will sort manually
		lambdas([n-1 n])=lambdas([n n-1]);
		v(:,[n-1 n]) = v(:,[n n-1]);
	end
end

end

%this function performs a simple power method on A returning the largest eigenpair from A
function [lambda, v] =  power_method(A)

%I attempted to use the tolerance of 1e-16, however, the  program looped infinitely and crashed.
%again this goes back to the limits of 64-bit signed double floating point variables, which I 
%explained in detail in the last homework submitted...you know if you want to see.

tol = 1e-15;

%this is a calculation based on the vector v and oldv relative to each other
%for whatever reason, using a boolean here fails...and I'm out of time to figure out why
converged = 0;

%finalize initilization
n = length(A);
v = ones(n,1); 
v = v / norm(v);

%the while loop, (thanks to Kyle's email!)
while ~converged 
	%for the converged, set oldv = to current v
  oldv = v;
  
  %deflation method below replicated from page ~590 from textbook
  v = A*v;
  v = v / norm(v);
  lambda = v'*A*v;
  
  %finally, we update converge so that 
  converged = (norm(v - oldv) < tol);
  
end

 
end

%this function performs the weilandt deflation for n vectors 
%given matrix A. As described on page 594 of the text
function [V,lambda] = weilandt_deflation_method(A, n)

%initialize vars
d = length(A);
V = zeros(d,n);

%do the loop for n eigenpairs
for j=1:n
  [lambda(j), V(:,j)] = power_method(A);
  A = A - lambda(j)*V(1:n,j)*V(1:n,j)'; % deflation
end

end

%inv power method for matrix based on algorithm on page 588 of the text
%Given matrix A and loop limit n
function [v, e] = inverse_power_method(A,n)
	
	[L, U, P] = lu(A); % LU decomposition of A with pivoting
	m = length(A);
	v = ones(m,1); % make an initial vector with ones
	%loop n times. Chose for loop here because we think that
	%the while loop is difficult to compare old values with
	%and a sizeable for loop limit allows for this to not be an issue
	for i = 1:n
		pv = P*v;
		y = L\pv;
		v = U\y;
		M = max(v);
		m = min(v);
		if abs(M) >= abs(m)
			el = M;
		else
			el = m;
		end
		v = v/el;
	end
	e = 1/el;
end

%much in the same way as the deflation method, we needed a way to inflate the matrix
%so that the inv power method would return the right thing and give independent new 
%vectors, hence the shifted_inverse_power_method
function [V,lambda] = shifted_inverse_power_method(A, n)

%literally the same thing as deflation here.
d = length(A);
V = zeros(d,n);

for j=1:n
 [V(:,j),lambda(j)] = inverse_power_method(A,10000);
  A = A + lambda(j)*V(:,j)*V(:,j)'; % deflation
end

end