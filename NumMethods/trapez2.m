function area = trapez2(a,b,h,f)
    area = 0;
    
    for i = a+h:h:b-h

    area = area + f(i);
    
    end
    
    area = h*area;
    
    area = area + f(a)*h/2 + f(b)*h/2;

    return
    
  