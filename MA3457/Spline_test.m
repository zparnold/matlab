% Testing cubic spline interpolation by MATLAB's "spline" function 
%
% ppval is the function evaluting piecewise polynomials 
%
% Interpolation of the Runge Function
%
xR = -1 : 0.01 : 1;
yR = 1./(1 + 25*xR.*xR);
%
% Nine data points
%
x = [-1 -0.75 -0.5 -0.25 0.0 0.25 0.5 0.75 1.0];
y = [ 0.0385 0.0664 0.1379 0.3902 1.0 0.3902 0.1379 0.0664 0.0385 ];
%
cs = spline(x, [0 y 0]);
xx = linspace(-1, 1, 101);
plot(x, y, 'o', xx, ppval(cs, xx), '-', xR, yR, 'k-'); 

