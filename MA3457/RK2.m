function [x, y] = RK2(f, tspan, y0, n)
%
% The procedure solves y' = f(x,y) with initial condition y(a) = y0
% using n steps of the 1st order Runge-Kutta (or the Midpoint) method
%
a = tspan(1); b = tspan(2); h = (b-a)/n;
x = (a+h : h : b);
k1 = h*feval(f, a, y0); 
k2 = h*feval(f, a + h/2, y0 + k1/2);
y(1) = y0 + k2;
%
for i = 1 : n-1
    k1 = h*feval(f, x(i), y(i)); 
    k2 = h*feval(f, x(i) + h/2, y(i) + k1/2);
    y(i+1) = y(i) + k2;
end
%
x = [a x];
y = [y0 y ];