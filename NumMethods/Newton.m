function [x1,x2,d] = Newton(x,n)

    x1 = x
    x2 = x1 - ((1/x1) + 2*log(x1) - 2)/((-1/(x1^2))+(2/x1))
    d = abs(x2-x1)

    for i = 2:n
        x1 = x2;
        x2 = x1 - ((1/x1) + 2*log(x1) - 2)/((-1/(x1^2))+(2/x1))
        d = abs(x2-x1)
    end