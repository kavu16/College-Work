function C = mychol(A)
    assert(A(1,1) > 0,"diagonal element 0 or negative")
    
    if size(A) == [1,1]
        C(1,1) = sqrt(A(1,1));
        return
    end
    
    alpha = A(1,1);
    v = A(1,2:size(A,1));
    
    beta = sqrt(alpha);
    w = v/beta;
    
    Astar = A(2:size(A,1),2:size(A,2));
    
    C(1,1) = beta;
    C(1,2:size(A,1)) = w;
    C(2:size(A,1),2:size(A,2)) = mychol(Astar - w'*w);
end
    
    