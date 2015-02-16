%BFGS Method for Function 1
% f(x,y)=(1-x)^2+(y-x^2)^2
syms x y;
f(x,y)=(1-x)^2+(y-x^2)^2;
Gradf(x,y)= [2*x-4*x*(-x^2 + y)-2; -2*(x^2)+2*y];
x0=-.5;
y0=-.7;
I=eye(2);
C0=I;
delta=10^(-6);
alpha=10^(-4);
beta=.9;
z=1;
ezcontour(f(x,y),[-2,2])
hold on;
whatx=x0;
whaty=y0;
while z>0
    z=z+1;
    plot([x0;whatx],[y0;whaty],'bo-')
    hold on;
    P=-C0*(double(Gradf(x0,y0)));
    t=1;
    mu=0;
    A=100000000000;
    k=1;
    while k>0
        k=k+1;
        wowx0=double(x0+t*P(1));
        wowy0=double(y0+t*P(2));
        phi=double(f(wowx0,wowy0));
        G=Gradf(wowx0,wowy0);
        phiPrime=double(dot(G,P));
        phi0=double(f(x0,y0));
        G1=Gradf(x0,y0);
        phiPrime0=double(dot(G1,P));
        if phi>phi0+alpha*t*phiPrime0
            A=t;
        elseif phiPrime<beta*phiPrime0
            mu=t;
        else
            break
        end
        if A<100000000000
            t=(mu+A)/2;
        else 
            t=2*t;    
        end
    end   
x1=double(x0+t*P(1));
y1=double(y0+t*P(2));
dkx0=double(x1-x0);
dky0=double(y1-y0);
dkcomb=[dkx0;dky0];
yk=double(Gradf(x1,y1)-Gradf(x0,y0));
%C1=(I-((dot(dkcomb,yk))/(yk'*dkcomb)))*C0*((I-((dot(dkcomb,yk))/(yk'*dkcomb)))'+((dot(dkcomb,dkcomb))/(yk'*dkcomb)));
%C1=double((I-(dkcomb*yk')/dot(yk,dkcomb)*C0*(I-((dkcomb*yk')/(dot(yk,dkcomb))))'+((dkcomb*dkcomb')/(dot(yk,dkcomb)))));
%C1=(I-(dot(dkcomb,yk)/yk'*dkcomb))*C0*(I-(dot(dkcomb,yk)/yk'*dkcomb))'+(dot(dkcomb,dkcomb)/yk'*dkcomb);
C1=(I-(dkcomb*yk')/dot(yk,dkcomb))*C0*(I-(dkcomb*yk')/dot(yk,dkcomb))'+(dkcomb*dkcomb')/dot(yk,dkcomb);
C0=double(C1);
whatx=x0;
whaty=y0;
x0=x1;
y0=y1;
if norm(Gradf(x0,y0))<=delta
    break
end
end
xfin=[x0,y0];
xfin
f(x,y)
Gradf(x,y)
        
        
        