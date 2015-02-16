%@author Zach Arnold
%@contributors Ryan McKenna, Ethan Moon 

%Here is a loop that will call all of the functions for me
function BFGS()

%[xk1, fxk1, Gfxk1] = BFGSIter(@(x, y) (1-x).^2 + (y - x.^2).^2,[0.5;0.5])
%[xk2, fxk2, Gfxk2] = BFGSIter(@(x, y) (1-x).^2 + abs(y-x.^2),[0.5;0.5])
[xk3, fxk3, Gfxk3] = BFGSIter(@(x, y) (1/4)*abs(1-x)+ abs(y - 2*abs(x) + 1),[0.5;0.5])

end

%function BFGSIter
%@param func the function to be optimized
%@param x0 the initial guess
%@return [xk,fkx,Gfxk] the vector, answer, and gradient
%
%the function is described in class
function [xk, fxk, Gfxk] = BFGSIter (func,x0)

I = eye(2);
domain = [2,-2]';

ezcontour(func,domain)
title('f')
hold on 
xk = x0;
fxk = fun(xk);
Gfxk = gradf(xk);
Ck = I;
delta = 10^(-12);
xold = x0;
count = 0;
while true 
	count =count + 1;
    plot ([xk(1);xold(1)],[xk(2);xold(2)],'bo-')
    hold on
    Pk = -Ck*Gfxk;
    tk = linesearch(xk, Pk);
    xk1 = xk + tk*Pk; 
    Gfxk1 = double(gradf(xk1));
    yk = Gfxk1 - Gfxk;
    dk = xk1 - xk;
    %this is the break condition to handle NAN case
    if dot(yk, dk) == 0
        break
    end

    C0 = (I-(dk*yk')/dot(yk,dk))*Ck*(I-(dk*yk')/dot(yk,dk))'+(dk*dk')/dot(yk,dk);
    Ck = C0;
    xold = xk;
    xk = xk1;
    Gfxk = Gfxk1;
    fxk = double(fun(xk));
    nFxk = norm(fxk);
    if (nFxk) < delta
        break
    end
end
    count
	final_error = abs(xk - [1;1])
end

%function linesearch
%@param xk the vector
%@param Pk
%@return t the linesearch result
%
%the function is described in class
function [t] = linesearch (xk, Pk)
alpha = 10^-4;
beta = 0.9;  
t = 1;
mu = 0;
gamma = 10;
armijo = 0;
weak_wolfe = 0;
fx = fun(xk);
Gx = gradf(xk);
while true 
    line = xk + t*Pk;
    grad = double(gradf(line));
    phi = double(fun(line));
    phi0 = fx;
    phiPrime = dot(grad,Pk);
    phiP0 = dot(Gx, Pk);
    if phi > phi0 + alpha*t*phiP0 % Armijo Fails
        gamma = t;
    else
        armijo = 1;
    end
    if phiPrime < beta*phiP0 % Weak Wolfe fails
        mu = t;
    else
        weak_wolfe = 1;
    end
    if armijo == 1 && weak_wolfe == 1;
        break;
    end
    if gamma < 10
        t = (mu + gamma)/2;
    else t = 2*t;
    end
end
end

%SECTION ADDED BELOW FOR FUNCTIONALITY AND SPEED
%rather than have this implicitly solved for in the above function
%it is explicitly defined below for direct referencing purposes.

% %function 1
% function fxk = fun(xk) 
% x = xk(1);
% y = xk(2);
% fxk = (1-x).^2 + (y - x.^2).^2;
% end
% 
% %gradient 1
% function gfxk = gradf(xk)
% x = xk(1);
% y = xk(2);
% gfxk = [2*(2*x^3-2*x*y+x-1),2*(y-x.^2)]';
% end 

% %function2
% function fxk = fun(xk) 
% x = xk(1);
% y = xk(2);
% fxk = (1-x.^2)^2 + abs(y - x.^2);
% end
% 
% %grad 2
% function gfxk = gradf(xk)
% x = xk(1);
% y = xk(2);
% gfx = -2*(1-x);
% if (y-x^2) > 0
%     gfx = gfx -2*x;
% else
%     gfx = gfx + 2*x; 
% end
% if (y-x.^2) > 0
%     gfy = 1;
% else 
%     gfy = -1;
% end
% gfxk = [gfx, gfy]';
% end 


% function 3
function fxk = fun(xk) 
x = xk(1);
y = xk(2);
fxk = (0.25)*abs(1-x) + abs(y-2*abs(x)+1);
end

% gradient 3
function gfxk = gradf(xk) 
x = xk(1);
y = xk(2);
if 1-x > 0
    gfx = -(0.25);
else gfx = 0.25;
end
if x > 0
    if  (y - 2*x + 1) > 0
        gfx = gfx - 2;
        gfy = 1;
    else
        gfx = gfx + 2;
        gfy = -1;
    end
else
    if (y + 2*x + 1) > 0
        gfx = gfx + 2;
        gfy = 1;
    else
        gfx = gfx - 2;
        gfy = -1;
    end
end
gfxk = [gfx, gfy]';
end
