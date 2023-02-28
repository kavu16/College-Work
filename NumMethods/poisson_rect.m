% poisson2.m  -- solve the Poisson problem u_{xx} + u_{yy} = f(x,y)
% on [a,b] x [a,b].  
% 
% The 5-point Laplacian is used at interior grid points.
% This system of equations is then solved using backslash.
% 
% From  http://www.amath.washington.edu/~rjl/fdmbook/chapter3  (2007)


ax = 0; ay = 0;
bx = 2; by = 6;
dx = bx - ax;
dy = by - ay;
m = 20;

if dx < dy
    h = (bx-ax)/(m+1);
    x = linspace(ax,bx,m+2);
    y = ay:h:by;
else
    h = (by-ay)/(m+1);
    y = linspace(ay,by,m+2);
    x = ax:h:bx;
end
    

%x = linspace(a,b,m+2);   % grid points x including boundaries
%y = linspace(a,b,m+2);   % grid points y including boundaries


[X,Y] = meshgrid(x,y);      % 2d arrays of x,y values
X = X';                     % transpose so that X(i,j),Y(i,j) are
Y = Y';                     % coordinates of (i,j) point

mx = length(x)-2;
my = length(y)-2;

Iint = 2:mx+1;              % indices of interior points in x
Jint = 2:my+1;              % indices of interior points in y
Xint = X(Iint,Jint);       % interior points
Yint = Y(Iint,Jint);

f = @(x,y) 1.25*exp(x+y/2);         % f(x,y) function

rhs = f(Xint,Yint);        % evaluate f at interior points for right hand side
                           % rhs is modified below for boundary conditions.

utrue = exp(X+Y/2);        % true solution for test problem

% set boundary conditions around edges of usoln array:

usoln = utrue;              % use true solution for this test problem
                            % This sets full array, but only boundary values
                            % are used below.  For a problem where utrue
                            % is not known, would have to set each edge of
                            % usoln to the desired Dirichlet boundary values.


% adjust the rhs to include boundary terms:
rhs(:,1) = rhs(:,1) - usoln(Iint,1)/h^2;
rhs(:,my) = rhs(:,my) - usoln(Iint,my+2)/h^2;
rhs(1,:) = rhs(1,:) - usoln(1,Jint)/h^2;
rhs(mx,:) = rhs(mx,:) - usoln(mx+2,Jint)/h^2;


% convert the 2d grid function rhs into a column vector for rhs of system:
F = reshape(rhs,mx*my,1);

% form matrix A:
Iy = speye(my);
Ix = speye(mx);
ex = ones(mx,1);
ey = ones(my,1);
T = spdiags([ex -4*ex ex],[-1 0 1],mx,mx);
S = spdiags([ey ey],[-1 1],my,my);
A = (kron(Iy,T) + kron(S,Ix)) / h^2;


% Solve the linear system:
uvec = A\F;  

% reshape vector solution uvec as a grid function and 
% insert this interior solution into usoln for plotting purposes:
% (recall boundary conditions in usoln are already set) 

usoln(Iint,Jint) = reshape(uvec,mx,my);

% assuming true solution is known and stored in utrue:
err = max(max(abs(usoln-utrue)));   
fprintf('Error relative to true solution of PDE = %10.3e \n',err)

% plot results:

clf
hold on

% plot grid:
plot(X,Y,'g');  plot(X',Y','g')

% plot solution:
contour(X,Y,usoln,30,'k')

axis([ax bx ay by])
daspect([1 1 1])
title('Contour plot of computed solution')
hold off

