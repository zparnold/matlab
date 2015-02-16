function u = laplace1D(f,lambda,n)

% u = laplace1D(@(x) exp(-x),1,10);

h = 1/n; % (b-a)/n where b=1 and a=0
A = zeros(n+1); % Initialize A matrix

% Fill matrix A using loops:
for ind = 2:n
    for j = 1:n+1
        if ind == j
            % Form main diagonal
            A(ind,j) = -2/h^2 + lambda;
            
        else if j == ind-1 || j == ind+1
                % Form first sup- and sub-diagonals
                A(ind,j) = 1/h^2;
                
            end
        end
    end   
end

% Top left and bottom right corners must be 1 to ensure initial conditions
A(1,1) = 1;
A(n+1,n+1) = 1;

% Create RHS vector b. 
% If you don't understand this, make sure I explain it!!!
b = [0; f(h:h:1-h)'; 0];

% Solve system of linear equations
u = A\b;

% % check:
% check = (u(1:end-2)-2*u(2:end-1)+u(3:end))./(h^2) + lambda*u(2:end-1);
% [check f(h:h:1-h)']
