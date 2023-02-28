% Solver using GMRES

ax = 0;
bx = 1;
m = 200;
h = (bx-ax)/(m-1);
x = linspace(ax,bx,m);

I = speye(m);
e = ones(m,1);
A2 = -spdiags([e -2*e e],[-1 0 1],m,m)/h^2;
A1 = spdiags([-e e], [-1 1], m, m)/(2*h);

A = A2 + A1 + I;
A(1,1:2) = [1 0];
A(m,m-1:m) = [0 1];

e(1) = 0;
e(m) = 0;

[X,FLAG,RELRES,ITER,RESVEC] = gmres(A,e,[],[],100,ilu(A));

plot(1:101,RESVEC);
hold on;

[X,FLAG,RELRES,ITER,RESVEC] = gmres(A,e,20,[],100,ilu(A));

plot(1:22,RESVEC(1:20:424));

