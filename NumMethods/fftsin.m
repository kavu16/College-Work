function X = fftsin(b,N,fun)
    h = (2*pi)/N;
    
    L = [0:h:(2*pi)-h];
    
    X = fft(fun(L));
    
    for k = 2:2:N-1
         if k <= N/2
             X(k) = X(k)/(-((k-1)^2) - b);
         else
             X(k) = X(k)/(-((k-1)-N)^2 - b);
         end
             
    end
    
    X = ifft(X);
    plot(L,X);
    return
    