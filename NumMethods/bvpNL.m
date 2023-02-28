%set up grid and boundary conditions
T = 100;
 
ax = 0;
bx = T;
alpha = 0.7;
beta = 0.7;
 
m1 = 500;
m2 = m1 + 1;
m = m1 - 1;
 
h = (bx - ax)/m1;
 
gridchoice = 'uniform';
x = xgrid(ax,bx,m,gridchoice);


iterates = zeros(m2,11);
%initialize Theta
Theta = 0.7*cos(x) - 0.7*sin(x);

iterates(:,1) = Theta;
for k = 1:10
    %set up Jacobian matrix
    J = spalloc(m,m,3*m);
    J(1,1:2) = [-2/(h^2), 1/(h^2)];
    J(m,m-1:m) = [1/(h^2), -2/(h^2)];
    for i = 2:m-1
        J(i,i-1:i+1) = [1/(h^2),-2/(h^2),1/(h^2)];
    end
    
    Jcos = cos(Theta);
    Jcos = Jcos(2:m1);
    
    for i = 1:m
        J(i,i) = J(i,i) + Jcos(i,1);
    end
    
    %set up G
    G0 = spalloc(m2,m2,3*m2);
    G0(1,1:3) = fdcoeffF(0,x(1),x(1:3));
    G0(m2,m:m2) = fdcoeffF(0,x(m),x(m:m2));
    
    for i = 2:m1
        G0(i,i-1:i+1) = fdcoeffF(2, x(i), x((i-1):(i+1)));
    end
    
    Gsin = sin(Theta);
    
    G = G0*Theta + Gsin;

    G = -1*G(2:m1);
    
    delta = 0*Theta;
    delta(2:m1) = J\G;
 
%update Theta
    Theta = Theta + delta;
    
    iterates(:,k+1) = Theta;
end

for i = 1:11
    plot(x,iterates(:,i),'o');
    hold on;
end
hold off;
title(sprintf('Computed solutions for T = %i',100));
drawnow;
