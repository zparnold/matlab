% Numerical solution of a linear ODE-BVP by the FD method. 
% Equation:  y_xx = p(x) y_x + q(x) y + r(x)
% Interval:  aa <= x <= bb
% Boundary conditions:  y(aa) = ya, y(bb) = yb
%
% ******* Problem definition 
% No 1: DE: y_xx = 2y_x - 2y + 0
% aa = 0; bb = 3; n = 300;
% Define p(x), q(x), r(x)
% p = 2*ones(1, n-1); q = -2*ones(1, n-1); r = zeros(1, n-1);
% Boundary conditions
% ya = 0.1; yb = 0.1*exp(3)*cos(3);  
%
% No 2: DE: y_xx = 10^(-7) + 10^(-8)*x.*(x-100)
% aa = 0;  bb = 100;  n = 20; h = (bb - aa)/n; 
% x = h:h:bb;
% Define p(x), q(x), r(x)
% p = zeros(1, n-1); q = 10^(-7)*ones(1,n-1);
% r = 10^(-8)*x.*(x-100);
% Boundary conditions
% ya = 0; yb = 0;
%
% No 3: 
aa = 0; bb = 10; n = 1000; h = (bb - aa)/n;
x = h:h:bb;
% Define p(x), q(x), r(x)
p = (-4)*ones(1, n-1); q = (-1)*ones(1, n-1); r = 2*cos(x).*cos(x);
% Boundary conditions
ya = 1; yb = 1.2;

% ******* End of problem definition
%
% Parameters and gridpoints x(1), ..., x(n-1)
h = (bb - aa)/n; h2 = h/2; hh = h*h;
x = linspace(aa+h, bb, n); 
%
% Upper diagonal (a), diagonal (d), lower diagonal (b)
a = zeros(1, n-1); b = a;
a(1:n-2) = 1 - p(1,1:n-2)*h2; d = -(2 + hh*q);
b(2:n-1) = 1 + p(1,2:n-1)*h2;
%
% Right hand side (c)
c(1) = hh*r(1) - (1 + p(1)*h2)*ya; 
c(2:n-2) = hh*r(2:n-2);
c(n-1) = hh*r(n-1) - (1 - p(n-1)*h2)*yb;
%
% Solution of tridiagonal system
y = Trid_Thomas(a, d, b, c);
xx = [aa x]; yy = [ya y yb];
out = [xx' yy']; disp(out)
%
plot(xx, yy, '-'), grid on, hold on
%
% Graph exact solution (if known) 
% plot(xx, 0.1*exp(xx).*cos(xx))
% hold off