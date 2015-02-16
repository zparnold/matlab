function G = gradcheck2(x,y)

syms x1 y1
gfx = -2*(1-x);
if (y-x^2) >= 0
    gfx = gfx-2*x;
    gfy = 1;
else
    gfx = gfx + 2*x;
    gfy = -1;
end
G = [gfx;gfy];

