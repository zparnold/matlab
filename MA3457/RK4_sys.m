function [x, u] = RK4_sys(f, tspan, u0, n)
%
% The procedure solves a system of ODE-IVP using the Runge-Kutta 
% method of order 4.  In function f(x, u): 
%   input:  column vector x and row vector u
%   output: column vector of values for u'
% 
% Interval of interest: tspan = [a, b]
%
a = tspan(1); b = tspan(2); h = (b-a)/n;
x = (a+h : h : b)';
k1 = h*feval(f, a, u0)';
k2 = h*feval(f, a+h/2, u0+k1/2)';
k3 = h*feval(f, a+h/2, u0+k2/2)';
k4 = h*feval(f, a+h, u0+k3)';
u(1, :) = u0 + k1/6 + k2/3 + k3/3 + k4/6;
%
for i = 1 : n-1
    k1 = h*feval(f, x(i), u(i, :))';
    k2 = h*feval(f, x(i)+h/2, u(i, :)+k1/2)';
    k3 = h*feval(f, x(i)+h/2, u(i, :)+k2/2)';
    k4 = h*feval(f, x(i)+h, u(i, :)+k3)';
    u(i+1, :) = u(i, :) + k1/6 +k2/3 +k3/3 +k4/6;
end
%
x = [a
     x];
u = [u0 
     u];