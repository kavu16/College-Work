function x = forward1(L,b)
    [n,m] = size(L);
    assert(n==m,"L is not square")
    assert(n==size(b,1),"Dimension of L does not agree with b")
    
    x = zeros(n,1);
    
    x(1) = b(1)/L(1,1);
    for i = 2:n
        x(i) = b(i);
        for j = 1:i-1
            x(i) = x(i) - L(i,j)*x(j);
        end
        x(i) = x(i)/L(i,i);
    end
    