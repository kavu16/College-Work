function l = my_l(k, x)
    s = size(x);
    l = ones(s(2));

    if k == 0
        return
    end
    
    if k == 1
        l = 1 - x;
        return
    end
    
    
    k1 = k - 1;
    k2 = k - 2;
    l = ((2*(k-1) + 1 - x)/k).*my_l(k1,x) - ((k-1)/k).*my_l(k2,x);
        