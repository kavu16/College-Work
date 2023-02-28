function [i,x2] = fixed(x,k)
    t = 10^(-8);

    x1 = x;
    x2 = x + k*(x*exp(x)-1);
    i = 1;
    
    if abs(x2-x1) < t
        return 
        endfk
    
    while abs(x2-x1) >= t
        x1 = x2;
        x2 = x1 + k*(x1*exp(x1)-1);
        i = i + 1;
    end