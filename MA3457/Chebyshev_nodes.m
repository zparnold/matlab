function c=Chebyshev_nodes(a,b,d)
    for i=1:d
    c=(1/2).*(a+b)+(1/2).*(b-a).*cos((2*i-1)/(2.*d).*pi)
    end
end