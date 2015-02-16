function I = Simp(f, a, b, n)
% The function finds integral of f using the Composite Simpson's Rule
%
h = (b-a)/n; 

xi0= feval(f,a)+feval(f,b);
xi1=0;
xi2=0;
%
for i = 1 : n-1
	x(i) = a + h*i;
	
	if mod(n,2)==0
		xi2 = xi2 + feval(f, x(i));
	else
		xi1 = xi1 + feval(f, x(i));
	end
end
%
I = h*(xi0 + 2*xi2 + 4*xi1)/3