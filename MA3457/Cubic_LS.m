function z = Cubic_LS(x, y)
%
% Quadratic Regression Function
%
% Input x and y as row or column vectors
%
n = length(x); x = x(:); y = y(:);
%
sx = sum(x); sx2 = sum(x.^2);
sx3 = sum(x.^3); sx4 = sum(x.^4);
sx5 = sum(x.^5); sx6 = sum(x.^6);
sy = sum(y); sxy = sum(x.*y);
sx2y = sum(x.*x.*y);
sx3y = sum(x.*x.*x.*y);
A = [ sx6 sx5 sx4 sx3, 
      sx5 sx4 sx3 sx2,
      sx4 sx3 sx2 sx,
	  sx3 sx2 sx n ]
r = [sx3y sx2y sxy sy]'
z = A\r;
%
a = z(1), b = z(2), c = z(3), d=z(4)
%
table = [x y (a*x.^3+b*x.^2+c*x+d) (y-(a*x.^3+b*x.^2+c*x+d))];
disp('pi=a*x.^3+b*x.^2+c*x+d') 
disp('    x         y         pi        y-pi')
disp(table)
err = sum(table( : , 4) .^ 2)

