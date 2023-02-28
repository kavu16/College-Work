function E = myeig(A,n)
    E = A;
    for i = 1:n
        [Q,R] = mygsqr(E);
        E = R*Q;
    end
    E = diag(E);
   