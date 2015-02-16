function I = Trap(f, a, b, n)
% The function finds integral of f using the Composite Trapezoid Rule
%
h = (b-a)/n; S = feval(f, a);
%
for i = 1 : n-1
    x(i) = a + h*i;
    S = S + 2*feval(f, x(i));
end
%
S = S + feval(f, b); I = h*S/2