%Homework 4b submission for:
% Joseph Brigham: jcbrigham
% Zach Arnold: zparnold

function BrighamArnold_hw3(A,b)
%get the size of the nxn matrix
n=size(b);

%initialize first guess including residual
x=zeros(n,1);
normv=zeros(n,1);
r = b - A*x;

%actual solution to check against
xreal=A\b;
v1=r;
oldresidual=r'*r;

for k=1:n+1 
	%loop invariant: in the nth iteration we either do or don't have it
	%this case looks to see if we broke the loop without an answer yet (non-convergence)
    if k==n+1
        'Oops looks like I dont converge'
        return
    end
	%replicate the algorithm for this method from textbook and class below
    Av1=A*v1;
        holder=oldresidual/(v1'*Av1);
        strcat('normalized v for iteration ',num2str(k));
        normv = horzcat(normv, v1/norm(v1,2));
        x=x+holder*v1;
        r=r-holder*Av1;
        newresidual=r'*r;
        if sqrt(newresidual)<1e-10 %this condition is to satisfy that xreal and x are basically equal
		%due two double floating point precision round-off error, and the mantissa of a double having
		%natural error in 32 or 64-bit architectures, we cannot use a logical == operator to determine
		%if x and xreal are equal. But within 1^-10 tolerance they can be basically equal
              break
        end
        v1=r+newresidual/oldresidual*v1;
        oldresidual=newresidual;
end
normv = normv(1:end,2:end);
    'I am either close or equal to the real solution...heres x'
    x
    'and the real solution:'
    xreal
	'and the norm vector matrix'
	normv
end