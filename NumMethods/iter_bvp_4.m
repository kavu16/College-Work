
% Solve 1d BVP obtained by discretizing u''(x) = f(x) 
% with Dirichlet boundary condtions  u(0) = alpha, u(1) = beta
% Discretized using centered difference.
%
% Compare matrix splitting methods:  Jacobi, Gauss-Seidel, and SOR
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)

   % 'Jacobi' or 'GS' or 'SOR'
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

u = zeros(size(x));   % initial guess for iteration

figure(1)
clf
plot(x,ustar,'r')
hold on
plot(x,u)

error = nan(maxiter+1,1);
error(1) = max(abs(u-ustar));


% Iteration:
% ----------

omega = 2 / (1 + sin(pi*h));
for iter=1:maxiter

   uGS = (DA - LA) \ (UA*u + rhs);
   u = u + omega*(uGS - u);
      
   error(iter+1) = max(abs(u-ustar));
   if mod(iter,nplot)==0
      % plot u every nplot iterations
      plot(x,u)
      title(sprintf('%s: Iteration %4i, error = %9.3e',...
             method,iter,error(iter+1)),'FontSize',15)
      drawnow
      pause(.1)
      end
   end

% plot errors vs. iteration:
figure(2)
semilogy(error)
axis([0 maxiter min(error)/10 1])
title('Errors','FontSize',15)
xlabel('iteration')
hold on


