function result = taylor(x)
    result = zeros(1,30);
    sum = 1;
    for i = 1:30
        sum = sum + x^i/factorial(i);
        result(i) = sum;
    end
end

