function W = Romb(f, a, b, d)
%
% The function finds integral of f on the interval [a, b] using 
% d steps of Romberg integration (or accelerated Simpson Rule) 
%
T = zeros(d+1, d+1); 
%
for k = 1 : d+1
    n = 2^k; T(1, k) = Simp(f, a, b, n);
end
%
for p = 1 : d
    q = 16^p;
    for k = 0 : d-p
        T(p+1, k+1) = (q*T(p, k+2) - T(p, k+1))/(q-1);
    end
end
%
for i = 1 : d+1
    table = T(i, 1 : d-i+2); disp(table)
end
%
W = T(d+1,1);