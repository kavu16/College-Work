function [Q,R] = mygsqr(A)
    [m,n] = size(A);
    
    %initialize Q and R
    Q=zeros(m,n);
    Q(1:m,1) = A(1:m,1); 
    R=zeros(n); 
    R(1,1)=1;
    
    %compute the contents of Q and R
    for i = 1:n
        R(i,i) = norm(A(1:m,i));
        Q(1:m,i) = A(1:m,i)/R(i,i);
        j = [i+1:n];
        R(i,j) = Q(1:m,i)'*A(1:m,j);
        A(1:m,j) = A(1:m,j) - Q(1:m,i)*R(i,j);
    end
    return
   