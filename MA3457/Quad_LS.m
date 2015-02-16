function z = Quad_LS(x, y)
%
% Quadratic Regression Function
%
% Input x and y as row or column vectors
%
n = length(x); x = x(:); y = y(:);
%
sx = sum(x); sx2 = sum(x.^2);
sx3 = sum(x.^3); sx4 = sum(x.^4);
sy = sum(y); sxy = sum(x.*y);
sx2y = sum(x.*x.*y);
A = [ sx4 sx3 sx2, 
      sx3 sx2 sx,
      sx2 sx n]
r = [sx2y sxy sy]'
z = A\r;
%
a = z(1), b = z(2), c = z(3)
%
table = [x y (a*x.^2+b*x+c) (y-(a*x.^2+b*x+c))];
disp('pi=a*x.^2+b*x+c') 
disp('    x         y         pi        y-pi')
disp(table)
err = sum(table( : , 4) .^ 2)

