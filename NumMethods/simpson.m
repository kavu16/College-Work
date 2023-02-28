function area = simpson(f,x)
    N = length(x);
    area = 0;
    
    for i = 1:1:N-1
        a = x(i);
        b = x(i+1);
        mid = (a+b)/2;
        h = b-a;
        
        if isa(f,'function_handle')
            sub = (f(a)+f(b)+4*f(mid))*h;
        
        else 
            sub = (f(2*i-1)+f(2*i+1)+4*f(2*i))*(b-a);
            
        end
        area = area + sub;
    end
    
    area = area/6;
    