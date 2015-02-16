%HW2_b submission for JCBRIGHAM and ZPARNOLD

function u = BrighamArnold_hw2(lambda,m,f)
%define step size
h = 1/m;

%Set up the answer vector
b = zeros((m+1).^2,1);

%fill in with appropriate values
for i = m+2:m+1:(m.*(m+1))
	xi = 2;
	for j = 2:m
		yj = j/m;
		b(i+j)=f(xi/m,yj);
	end
	xi = xi+1;
end

%setup matrix I
I = eye(m+1);
%setup matrix M
M = zeros(m+1);
M(1,1) = 1;
M(end,end) = 1;

for i = 2:m
	for j = 2:m
		if (i == j)
			M(i,j) = lambda - 4/(h.^2);
			M(i,j-1) = 1/(h.^2);
			M(i,j+1) = 1/(h.^2);
		end
	end
end

%setup matrix N
N = eye(m+1);
N(1,1) = 0;
N(end,end) = 0;
N = N * 1/(h.^2);
%initialize matrix A
A = zeros((m+1).^2);
A(1:m+1,1:m+1) = I;
A(m.*(m+1)+1:(m+1).^2,m.*(m+1)+1:(m+1).^2) = I;
%fill in values of A
for i = 2:m
	A((i-1).*(m+1)+1:i.*(m+1),(i-1).*(m+1)+1:i.*(m+1))=M;
	A((i-1).*(m+1)+1:i.*(m+1),(i-2).*(m+1)+1:(i-1).*(m+1))=N;
	A((i-1).*(m+1)+1:i.*(m+1),(i).*(m+1)+1:(i+1).*(m+1))=N;
end
%begin finalization
u = A\b;
u = reshape(u,m+1,m+1);
u = u(2:end-1,2:end-1);
end