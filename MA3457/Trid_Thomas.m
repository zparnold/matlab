function x = Trid_Thomas(a, d, b, r)
%
% The procedure solves matrix equation Ax = b 
% where A is atridiagonal matrix
%
% Input: 
%   a - upper diagonal of matrix A, a(n) = 0
%   d - diagonal of matrix A
%   b - lower diagonal of matrix A, b(1) = 0
%   r - right-hand side of equation
%
n = length(d);
a(1) = a(1)/d(1);
r(1) = r(1)/d(1);
%
for i = 2 : n-1
  denom = d(i) - b(i)*a(i-1);
  if (denom == 0), error ('Zero in denominator'), end
  a(i) = a(i)/denom;
  r(i) = (r(i) - b(i)*r(i-1))/denom;
end
%
r(n) = (r(n) - b(n)*r(n-1))/(d(n) - b(n)*a(n-1));
x(n) = r(n);
for i = n-1: -1 : 1
  x(i) = r(i) - a(i)*x(i+1);
end