function [Q,R] = myhouseqr(A)
    [m,n] = size(A);
    
    %initialize Q and R
    Q = eye(m);
    R = A;
    
    %compute Q1
    y = A(1:m,1);
        e1 = zeros(m,1); e1(1) = 1;
        v = norm(y)*e1 - y;
        v = v./norm(v);
        F = eye(m) - 2*(v*v')/(v'*v);
        Q1 = F;
        A = Q1*A;
        R(1:m,1) = A(1:m,1);
        Q = Q1;
    
    %compute Qi for i = 2:n
    for i = 2:n
        y = A(i:m,i);
        e1 = zeros(m-i+1,1); e1(1) = 1;
        v = norm(y)*e1 - y;
        v = v./norm(v);
        F = eye(m-i+1) - 2*(v*v')/(v'*v);
        Qi = zeros(m);
        Qi(1:i-1,1:i-1) = eye(i-1);
        Qi(i:m,i:m) = F;
        A = Qi*A;
        R(1:m,i) = A(1:m,i);
        Q = Qi*Q;
    end
    
    %transpose final product
    Q = Q';
    return
        