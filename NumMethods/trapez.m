function area = trapez(f,x)
    N = length(x);
    area = 0;
    
    for i = 1:1:N-1
        a = x(i);
        b = x(i+1);
        h = b-a;
        
        if isa(f,'function_handle')
            sub = (f(a)+f(b))*h;
        
        else 
            sub = (f(i)+f(i+1))*h;
            
        end
        area = area + sub;
    end
    
    area = area/2;
    