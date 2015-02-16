% Taylor's method for an IVP
%
function [x, y] = Taylor_2(f, df, tspan, y0, n)
%
% The procedure solves d.e. y' = f(x,y) with initial 
% condition y(a) = y0 using n steps of 2nd Order Taylor's method.
%
% Step size: h = (b-a)/n
%
a = tspan(1); b = tspan(2); h = (b-a)/n;
x = (a+h : h : b);
y(1) = y0 + h*feval(f, a, y0) + 0.5*h.^2*feval(df,a,y0);
%
for i = 1 : n-1
    y(i+1) = y(i) + h*feval(f, x(i), y(i)) + 0.5*h.^2*feval(df,x(i),y(i));
end
%
x = [a x];
y = [y0 y];