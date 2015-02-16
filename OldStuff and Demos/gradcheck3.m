function G = gradcheck3(x,y)

syms x1 y1

if (1-x) > 0
    gfxp1 = -1;
    gfyp1 = 0;
elseif (1-x) > 0
    gfxp1 = 1;
    gfyp1 = 0;
else
    gfxp1 = 0;
    gfyp1 = 0;
end

if x > 0
    if y-2*x+1 > 0
        gfxp2 = -2;
        gfyp2 = 1;
    else
        gfxp2 = 2;
        gfyp2 = -1;
    end
elseif x < 0
    if y+2*x+1 > 0
        gfxp2 = 2;
        gfyp2 = 1;
    else
        gfxp2 = -2;
        gfyp2 = -1;
    end
else
    gfxp2 = 0;
    if y+1 > 0
        gfyp2 = 1;
    elseif y+1 < 0
        gfyp2 = -1;
    else
        gfyp2 = 0;
    end
end
G = [gfxp1*.25 + gfxp2; gfyp1*.25 + gfyp2];

