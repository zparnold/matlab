function s = Lin_LS(x, y)
%
% Linear Regression Function
%
% Input x and y as row or column vectors
% (they are converted to column form is necessary) 
%
m = length(x); x = x(:); y = y(:);
sx = sum(x); sy = sum(y);
sxx = sum(x.*x); sxy = sum(x.*y);
%
a = (m*sxy - sx*sy) / (m*sxx - sx^2)
b = (sxx*sy - sxy*sx) / (m*sxx - sx^2)
%
table = [x y (a*x+b) (y-(a*x+b))];
disp('    x         y         a*x+b     y-(a*x+b)')
disp(table), err = sum(table( : , 4) .^ 2)
s(1) = a; s(2) = b;

