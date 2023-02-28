function area = Romberg(a,b,n,fun)
    for i = 1:n+1
        h = (b-a)/(2^(i-1));
        A(i,1) = trapez2(a,b,h,fun);
    end
    for j = 2:n+1
        for i = j:n+1
            A(i,j) = (4^(j-1)*A(i,j-1)-A(i-1,j-1))/(4^(j-1)-1);
        end
    end
    area = A(n+1,n+1);
    return