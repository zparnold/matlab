function G = gradcheck1(f,x,y)

syms x1 y1

    G = double(subs(gradient(f),[x1,y1],[x,y]));
