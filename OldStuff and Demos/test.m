% InvPowerMethod.m - Inverse Power Method for iterative approximation of dominant eigenvalue of inv(A)
% 
% INPUT:
%   A       - coefficient matrix
%   x       - initial guess
%   tol     - tolerance for estimated relative error
%   maxiter - maximum number of Inverse Power Method iterations to perform
%
% OUTPUT:
%   lambda  - final estimate of dominant eigenvalue
%   v       - final estimate of corresponding eigenvector
%   relerr  - estimated relative error in infinity norm
%   niter   - number of iterations executed
%
% Notes:
%  - If A has many zero components, pass A in sparse format.
%  - Cannot use Power as this is a built-in MATLAB command.
%
% Written by Douglas Meade
% Created 16 November 2005

function [lambda,v,relerr,niter] = power(A,x,tol,maxiter)

relerr = inf;
niter = 1;

while relerr >= tol & niter < maxiter,
   z = x/norm(x,2);
   x = A\z;
   alpha1 = z'*x;
   if niter>1,
      relerr = abs( alpha1-alpha0 )/abs( alpha0 );
   end
   alpha0 = alpha1;
   niter = niter+1;
end

lambda = 1/alpha1;
v = z;