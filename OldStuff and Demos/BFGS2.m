function [xk,F,GF] = BFGS2(x, delta, C,f)
%delta = 10^(-6)
[s1,s2] = size(C);
I = eye(s1);
k = 1;

syms x1 y1
% f = sym('f');
% f = symfun((1-x1).^2+(y1-x1^2).^2, [x1 y1]);
%gradf = @(x1,y1) gradient(f);

%[X,Y] = meshgrid(-2:.1:2);
%Z = (1-X).^2+(Y-X^2).^2;

ezcontour(f,[-2,2]')
hold on;

x_old = x;
while k > 0
    plot([x(1);x_old(1)],[x(2);x_old(2)],'bo-')
    hold on;
    
    %gradf_old = double(subs(gradf,[x1,y1],[x(1),x(2)]));
    if f == (1-x1).^2+(y1-x1^2).^2
        gradf_old = gradcheck1(f,x(1),x(2));
    elseif f == (1-x1)^2+abs(y1-x1^2)
        gradf_old = gradcheck2(x(1),x(2));
    else
        gradf_old = gradcheck3(x(1),x(2));
    end
    p = -1*C*gradf_old;
    t = linesearch3(x,f,p);
    x_new = x + t*p;
    d = x_new - x;
    %gradf_new = double(subs(gradf,[x1,y1],[x_new(1),x_new(2)]));
    if f == (1-x1).^2+(y1-x1^2).^2
        gradf_new = gradcheck1(f,x_new(1),x_new(2));
    elseif f == (1-x1)^2+abs(y1-x1^2)
        gradf_new = gradcheck2(x_new(1),x_new(2));
    else
        gradf_new = gradcheck3(x_new(1),x_new(2));
    end
    %gradf_new = gradcheck(f,x_new(1),x_new(2));
    
    y = double(gradf_new - gradf_old);
    if dot(y,d) == 0
        break
    end
    C_new = (I - (d*y')/dot(y,d))*C*(I-(d*y')/dot(y,d))'+(d*d')/dot(y,d);
    k = k+1;
    ng = norm(gradf_old);
    if norm(gradf_old) < delta
        break
    end
    C = C_new;
    x_old = x;
    x = x_new;
    
end

%BFGS([-.5,-.7]',.00001,eye(2))

xk = x;
F = subs(f,[x1,y1],[x(1),x(2)]);
GF = gradf_new;