function BTCS(gridpts_x, domain, delta_x, delta_t, wave_speed, integral_time_iterations, extra_fractional_time, filename)
    copy_domain = domain(:).';  
    writematrix([0, copy_domain], filename, 'WriteMode','append');

    A = zeros(gridpts_x, gridpts_x);
    b = zeros(gridpts_x, 1);
    c = wave_speed * delta_t / delta_x;

    for n = 1:integral_time_iterations
        A(:) = 0;  
        b(:) = 0;
        for i = 1:gridpts_x
            if i == 1 || i == gridpts_x
                A(i,i) = 1;
                b(i) = 0;
            else
                A(i,i)   = 1;
                A(i,i-1) = -c/2;
                A(i,i+1) = c/2;
                b(i)     = copy_domain(i);
            end
        end

        domain = A \ b;
        copy_domain = domain.';  

        writematrix([n, copy_domain], filename, 'WriteMode','append');
    end

    if extra_fractional_time > 0
        A(:) = 0; b(:) = 0;
        extra_c = wave_speed * extra_fractional_time / delta_x;
        for i = 2:gridpts_x-1
            A(i,i)   = 1;
            A(i,i-1) = -extra_c/2;
            A(i,i+1) = -extra_c/2;
            b(i) = copy_domain(i);
        end
        
        A(1,1) = 1; b(1) = 0;
        A(gridpts_x, gridpts_x) = 1; b(gridpts_x) = 0;

        domain = A \ b;
        copy_domain = domain.';
        writematrix([integral_time_iterations+1, copy_domain], filename, 'WriteMode','append');
    end
end