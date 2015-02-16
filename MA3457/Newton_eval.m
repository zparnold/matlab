function p = Newton_Eval(t, x, a)
n = length(x);
%
for i = 1 : length(t)
	ddd(1) = 1; 		% Compute 1st term
	c(1) = a(1);
	for j = 2 : n
		ddd(j) = (t(i) - x(j-1)).*ddd(j-1);
				% Compute jth term
		c(j) = a(j) .* ddd(j);
	end
	p(i) = sum(c);
end
	
	%ezplot(p)
end 