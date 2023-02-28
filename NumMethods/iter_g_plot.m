
% Solve 1d BVP obtained by discretizing u''(x) = f(x) 
% with Dirichlet boundary condtions  u(0) = alpha, u(1) = beta
% Discretized using centered difference.
%
% Compare matrix splitting methods:  Jacobi, Gauss-Seidel, and SOR
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)

method = 'SOR';   % 'Jacobi' or 'GS' or 'SOR'
nplot = 10;          % iterate u is plotted every nplot iterations
maxiter = 500;        % number of iterations to take

m = 39;
ax = 0;
bx = 1;
alpha = 0;
beta = 0;
f = @(x) ones(size(x));   % f(x) = 1

h = (bx-ax) / (m+1);
x = linspace(ax, bx, m+2)';

% determine exact solution to linear system by setting up
% system Au = f and solving with backslash:
e = ones(m+2,1);

A = 1/h^2 * spdiags([e -2*e e], [-1 0 1], m+2, m+2);
A(1,1:2) = [1 0];
A(m+2,m+1:m+2) = [0 1];
rhs = f(x);
rhs(1) = alpha;
rhs(m+2) = beta;
ustar = A\rhs;


% Decompose A = DA - LA - UA:
DA = diag(diag(A));   % diagonal part of A
LA = DA - tril(A);    % strictly lower triangular part of A (negated)
UA = DA - triu(A);    % strictly upper triangular part of A (negated)

% set up iteration matrix:
switch method
   case 'Jacobi'
      M = DA;
      N = LA + UA;
   case 'GS'
      M = DA - LA;
      N = UA;
%    case 'GSB'
%       M = DA - UA;
%       N = LA;
   case 'SOR'
      % use optimal omega for this problem:
      %omega = 2 / (1 + sin(pi*h));
      omega = 1.95;
      M = 1/omega * (DA - omega*LA);
      N = 1/omega * ((1-omega)*DA + omega*UA);
   end


u = zeros(size(x));   % initial guess for iteration



% Iteration:
% ----------

rhoG = zeros(41,1);
rhoG(1) = 1;

for w = 1:40
    omega = w*(1/20);
    M = 1/omega * (DA - omega*LA);
    N = 1/omega * ((1-omega)*DA + omega*UA);

    % compute spectral radius of iteration matrix G:
    G = M\N;
    rhoG(w+1) = max(abs(eig(full(G))));
    
end

plot(0:1/20:2,rhoG);
title('Spectral Radii x Omega');
    
    

