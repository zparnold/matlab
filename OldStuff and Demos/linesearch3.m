function tk = linesearch3(x,f,p)

alpha = 10^(-4); beta = .9;

syms t1 x1 y1 xt yt phi dphi

xt = x(1) + t1*p(1);
yt = x(2) + t1*p(2);

phi = subs(f,[x1,y1],[xt,yt]);
phi0 = double(subs(f,[x1,y1],[x(1),x(2)])); %phi(t=0)

    if f == (1-x1)^2+(y1-x1^2)^2
        gradf0 = gradcheck1(f,x(1),x(2));
    elseif f == (1-x1)^2+abs(y1-x1^2)
        gradf0 = gradcheck2(x(1),x(2));
    else
        gradf0 = gradcheck3(x(1),x(2));
    end

dphi0 = dot(gradf0,p);

i=1; t=1; mu=0; nu=10;

while i > 0
    phit = double(subs(phi,t1,t));
    xt1 = x(1) + t*p(1);
    yt1 = x(2) + t*p(2);
    
    if f == (1-x1).^2+(y1-x1^2).^2
        dphit = dot(p,gradcheck1(f,xt1,yt1));
    elseif f == (1-x1)^2+abs(y1-x1^2)
        dphit = dot(p,gradcheck2(xt1,yt1));
    else
        dphit = dot(p,gradcheck3(xt1,yt1));
    end

    if phit > phi0 + alpha*t*dphi0
        nu = t;
    elseif dphit < beta*dphi0
        mu = t;
    else
        break
    end
    
    if nu < 10
        t = (mu + nu)/2;
    else
        t = 2*t;
    end
    i = i+1;
end
tk = t;