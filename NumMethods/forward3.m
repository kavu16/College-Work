function b = forward3(L,b)
    [n,m] = size(L);
    assert(n==m,"L is not square")
    assert(n==size(b,1),"Dimension of L does not agree with b")
    
    for i = 1:n-1
        b(i) = b(i)/L(i,i);
        b(i+1:n) = b(i+1:n) - b(i)*L(i+1:n,i);
    end
    
    b(n) = b(n)/L(n,n);