%This is the homework submission for 1b
%Student 1 = Joseph Brigham (jcbrigham)
%student 2 = Zachary Arnold (zparnold)

%function u(x) as defined in the book
function u = BrighamArnold_hw1(a,b,n,f,k)

%define how big each sub-interval will be
step = abs(b-a)/n;
negstep = -step;

%setup unknown vector u(xi)
unknownvector = 1:n+1;

%setup answer vector f(xi)
answervector = zeros(n+1,1);

%fill in values of the answervector:
for h = 1:n+1
	xk = a+(h-1).*step;
	answervector(h) = f(xk);
end

%setup the n+1 X n+1 matrix to be vertically concatenated by the unknown vector
A = zeros(n+1);

%iterate through the array and add the values to the a matrix
for i = 1:n+1
    %define the value if each xi step
    xi = a+(i-1).*step;
	%add the first and last values manually (since they are different than
    %than the rest
    A(i,1)=(1/2).*negstep .* k(xi,a);
	A(i,n+1)=(1/2).*negstep .* k(xi,b);
	%iterate through and fill in rest of matrix
    for j =2:n
	%define the value of each xj step
	xj = a+(j-1).*step;
	%handle the case if it's the main diagonal (needs to add 1)
        if j == i
            A(i,j) = negstep.* k(xi,xj) + 1;
        else 
            A(i,j) = negstep.* k(xi,xj);
        end
    end
end
%finally set the 1,1 and n+1,n+1'st places since they also need to have one added to them...but it wasn't worth the additional looping

A(1,1) = (1/2).*negstep.*k(a,a) + 1;
A(n+1,n+1) = (1/2).*negstep.*k(b,b) + 1;
format long;
unknownvector = A\answervector;
u = unknownvector;
return
end
