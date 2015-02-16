%BFGS Method for Function 1
% f(x,y)=(1-x)^2+(y-x^2)^2
syms x y;
f(x,y)=(1-x)^2+abs(y-x^2);
x0=-.5;
y0=-.7;
I=eye(2);
C0=I;
delta=10^(-10);
alpha=10^(-4);
beta=.9;
z=1;
ezcontour(f(x,y),[-2,2])
hold on;
whatx=x0;
whaty=y0;
%INsertion of Gradcheck
checkg(x,y)=(y-x^2);
gfx(x) = -2*(1-x);
Gradf1=[x;y];
Gradf2=[x;y];
Gradf3=[x;y];
Gradf4=[x;y];
Gradf5=[x;y];
while z>0
    z=z+1;
    plot([x0;whatx],[y0;whaty],'bo-')
    hold on;
    %inserted Gradcheck1
    if checkg(x0,y0)>=0
        Gradf1=[gfx(x0)-2*x0;1];
    else
        Gradf1=[gfx(x0)+2*x0;-1];
    end
    P=-C0*(double(Gradf1));
    %P becomes nan why?
    t=1;
    mu=0;
    A=100000000000;
    k=1;
    while k>0
        k=k+1;
        wowx0=double(x0+t*P(1));
        wowy0=double(y0+t*P(2));
        phi=double(f(wowx0,wowy0));
        %inserted Gradcheck2
        if checkg(wowx0,wowy0)>=0
            Gradf2=[gfx(wowx0)-2*wowx0;1];
        else
            Gradf2=[gfx(wowx0)+2*wowx0;-1];
        end  
        G=Gradf2;
        phiPrime=double(dot(G,P));
        phi0=double(f(x0,y0));
        %reuse gradcheck1
        G1=Gradf1;
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
%Gradcheck3/reuse gradcheck1
if checkg(x1,y1)>=0
    Gradf3=[gfx(x1)-2*x1;1];
else
    Gradf3=[gfx(x1)+2*x1;-1];
end  
yk=double(Gradf3-Gradf1);
%C1=(I-((dot(dkcomb,yk))/(yk'*dkcomb)))*C0*((I-((dot(dkcomb,yk))/(yk'*dkcomb)))'+((dot(dkcomb,dkcomb))/(yk'*dkcomb)));
%C1=double((I-(dkcomb*yk')/dot(yk,dkcomb)*C0*(I-((dkcomb*yk')/(dot(yk,dkcomb))))'+((dkcomb*dkcomb')/(dot(yk,dkcomb)))));
%C1=(I-(dot(dkcomb,yk)/yk'*dkcomb))*C0*(I-(dot(dkcomb,yk)/yk'*dkcomb))'+(dot(dkcomb,dkcomb)/yk'*dkcomb);
C1=(I-(dkcomb*yk')/dot(yk,dkcomb))*C0*(I-(dkcomb*yk')/dot(yk,dkcomb))'+(dkcomb*dkcomb')/dot(yk,dkcomb);
C0=double(C1);
whatx=x0;
whaty=y0;
x0=x1;
y0=y1;
%gradcheck4
if checkg(x0,y0)>=0
    Gradf4=[gfx(x0)-2*x0;1];
else
    Gradf4=[gfx(x0)+2*x0;-1];
end  
if norm(Gradf4)<=delta
    break
elseif dot(yk,dkcomb)<=delta
    break
end
end
xfin=[x0,y0];
xfin
f(x,y)
%lastgradcheck5
if checkg(xfin(1),xfin(2))>=0
    Gradf5=[gfx(xfin(1))-2*xfin(2);1];
else
    Gradf5=[gfx(xfin(1))+2*xfin(2);-1];
end  
Gradf2=double(Gradf5)
        
        
        