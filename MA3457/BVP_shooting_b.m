% Linear shooting example 
%
clear all
ya = 2; yb = 5/3; z0 = [ ya 0 0 1 ];
a = 0; b = 1; tspan = [ 0 1 ];
[ x z ] = RK4_sys('fivp_sys', tspan, z0, 10)
[ n m ] = size(z)
y(1:n,1) = z(1:n,1) + (yb - z(n,1))*z(1:n,3)./z(n,3)
plot(x, y)

hold on;

xe = 0:.01:1;
ye = xe.^4./6 - 3.*xe.^2./2 + xe + 2;
plot(xe, ye);