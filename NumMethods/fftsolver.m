function X = fftsolver(a,b,N,fun)
    h = (2*pi)/N;
    
    L = [0:h:(2*pi)-h];
    
    X = fft(fun(L));
    
    for k = 1:N
         if k < N/2
             X(k) = X(k)/(-((k-1)^2) + a*(i*(k-1)) - b);
         elseif k == N/2
             X(k) = X(k)/(-((k-1)^2) - b);
         else
             X(k) = X(k)/(-((k-1)-N)^2 + a*i*((k-1)-N) - b);
         end
             
    end
    
    X = ifft(X);
    return
    