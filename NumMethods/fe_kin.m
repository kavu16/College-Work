function fe_kin(tf,k,K1,K2);
t0 = 0;
m = (tf/k);
t = linspace(0,tf,m+1);
u = zeros(3,m+1);

u(:,1) = [3; 4; 2;];

for i = 2:m+1
    u(1,i) = u(1,i-1) + k*(-K1*u(1,i-1)*u(2,i-1)+K2*u(3,i-1));
    u(2,i) = u(2,i-1) + k*(-K1*u(1,i-1)*u(2,i-1)+K2*u(3,i-1));
    u(3,i) = u(3,i-1) + k*(K1*u(1,i-1)*u(2,i-1)-K2*u(3,i-1));
end;

clf
hold on
plot(t,u(1,:),'b')
plot(t,u(2,:),'k')
plot(t,u(3,:),'r')
legend('u1','u2','u3')
axis([0 tf -.1 1.1])
title('u(t) using time step k =',k)
