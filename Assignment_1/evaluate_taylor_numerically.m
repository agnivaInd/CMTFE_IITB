function val = evaluate_taylor_numerically(x,limit)
    pi = 2*acos(0);
    constant = 2/sqrt(pi);
    sum_value = 0;
    for n = 0:limit
        term = (x^(2*n + 1)*(-1)^n)/((2*n + 1)*factorial(n));
        sum_value = sum_value + term;
    end
    val = constant * sum_value;
end
