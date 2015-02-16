% This file is from pmtk3.googlecode.com
xstart = [0,0];

% now plot function values on top of contour plot
[xc,yc] = meshgrid(-2:.05:2);
zc = reshape(myObjective([xc(:),yc(:)]), size(xc));
figure;
contour(xc,yc,zc,[.1 1 4 16 64 256 1024 4096])
hold on
opts = optimset(opts, 'OutputFcn', @optimplot2d, 'Display', 'iter');
[x fval] = fminunc(@myObjective, xstart, opts)