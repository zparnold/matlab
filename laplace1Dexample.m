format long

% Example parameters
f = @(x) x.^2-x+2;
n = 100;
lambda = 1;
u = laplace1D(f,lambda,n);

% Here is what the solution should be:
x = 0:1/n:1;
u_solution = x.*(x-1);

% Plot numerical and theoretical solutions:
figure()
plot(x,u,x,u_solution,':r','linewidth',3)
legend('Numerical','Theoretical','Location','best')