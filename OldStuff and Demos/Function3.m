%BFGS Method for Function 1
% f(x,y)=(1-x)^2+(y-x^2)^2
syms x y;
f(x,y)=.25*abs(1-x)+abs(y-2*abs(x)+1);
x0=.7;
y0=.7;
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
%INsertion of Gradcheck Basis 
checkg(x,y)=1-x;
checkg2(x,y)=x;
checkg3(x,y)=y-2*x+1;
checkg4(x,y)=y+2*x+1;
gfxplay = 0;
gfyplay1 = 0;
gfxplay2=0;
gfyplay2=0;
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
    if checkg(x0,y0) > 0
        gfxplay1 = 1;
        gfypplay1 = 0;
        Gradf1=[gfxplay1*.25 + gfxplay2; gfyplay1*.25 + gfyplay2];
    else
        gfxplay1 = -1;
        gfypplay1 = 0;
        Gradf1=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end

    if checkg2(x0,y0) > 0
        if checkg3(x0,y0) > 0
            gfxplay2 = -2;
            gfyplay2 = 1;
            Gradf1=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
        else
            gfxplay2 = 2;
            gfyplay2 = -1;
            Gradf1=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
        end
    else
        if checkg4(x0,y0) > 0
            gfxplay2 = 2;
            gfyplay2 = 1;
            Gradf1=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
        else
            gfxplay2 = -2;
            gfyplay2 = -1;
            Gradf1=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
        end
    end  
    P=-C0*(double(Gradf1));
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
        if checkg(wowx0,wowy0) > 0
            gfxplay1 = 1;
            gfypplay1 = 0;
            Gradf2=[gfxplay1*.25 + gfxplay2; gfyplay1*.25 + gfyplay2];
        else
            gfxplay1 = -1;
            gfypplay1 = 0;
            Gradf2=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
        end
        if checkg2(wowx0,wowy0) > 0
            if checkg3(wowx0,wowy0) > 0
                gfxplay2 = -2;
                gfyplay2 = 1;
                Gradf2=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
            else
                gfxplay2 = 2;
                gfyplay2 = -1;
                Gradf2=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
            end
        else
            if checkg4(wowx0,wowy0) > 0
                gfxplay2 = 2;
                gfyplay2 = 1;
                Gradf2=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
            else
                gfxplay2 = -2;
                gfyplay2 = -1;
                Gradf2=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
            end
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
if checkg(x1,y1) > 0
    gfxplay1 = 1;
    gfypplay1 = 0;
    Gradf3=[gfxplay1*.25 + gfxplay2; gfyplay1*.25 + gfyplay2];
else
    gfxplay1 = -1;
    gfypplay1 = 0;
    Gradf3=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
end

if checkg2(x1,y1) > 0
    if checkg3(x1,y1) > 0
        gfxplay2 = -2;
        gfyplay2 = 1;
        Gradf3=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
     else
        gfxplay2 = 2;
        gfyplay2 = -1;
        Gradf3=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end
else
    if checkg4(x1,y1) > 0
        gfxplay2 = 2;
        gfyplay2 = 1;
        Gradf3=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    else
        gfxplay2 = -2;
        gfyplay2 = -1;
        Gradf3=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
     end
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
if checkg(x0,y0) > 0
    gfxplay1 = 1;
    gfypplay1 = 0;
    Gradf4=[gfxplay1*.25 + gfxplay2; gfyplay1*.25 + gfyplay2];
else
    gfxplay1 = -1;
    gfypplay1 = 0;
    Gradf4=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
end

if checkg2(x0,y0) > 0
    if checkg3(x0,y0) > 0
        gfxplay2 = -2;
        gfyplay2 = 1;
        Gradf4=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    else
        gfxplay2 = 2;
        gfyplay2 = -1;
        Gradf4=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end
else
    if checkg4(x0,y0) > 0
        gfxplay2 = 2;
        gfyplay2 = 1;
        Gradf4=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    else
        gfxplay2 = -2;
        gfyplay2 = -1;
        Gradf4=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end
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
if checkg(xfin(1),xfin(2)) > 0
    gfxplay1 = 1;
    gfypplay1 = 0;
    Gradf5=[gfxplay1*.25 + gfxplay2; gfyplay1*.25 + gfyplay2];
else
    gfxplay1 = -1;
    gfypplay1 = 0;
    Gradf5=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
end

if checkg2(xfin(1),xfin(2)) > 0
    if checkg3(x1,y1) > 0
        gfxplay2 = -2;
        gfyplay2 = 1;
        Gradf5=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    else
        gfxplay2 = 2;
        gfyplay2 = -1;
        Gradf5=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end
else
    if checkg4(xfin(1),xfin(2)) > 0
        gfxplay2 = 2;
        gfyplay2 = 1;
        Gradf5=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    else
        gfxplay2 = -2;
        gfyplay2 = -1;
        Gradf5=[gfxplay1*.25 + gfxplay2; gfypplay1*.25 + gfyplay2];
    end
end
Gradf3=double(Gradf5)
        
        
        