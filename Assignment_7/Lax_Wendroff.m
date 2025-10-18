function Lax_Wendroff(gridpts_x, domain, delta_x, delta_t, wave_speed, integral_time_iterations, extra_fractional_time, filename)
    copy_domain = domain; 
    data_to_write = [0, copy_domain];
    writematrix(data_to_write, filename, 'WriteMode', 'append');

    for n = 1:integral_time_iterations
        domain_scheme = zeros(1, gridpts_x);
        for i = 2:gridpts_x-1
            domain_scheme(i) = copy_domain(i) - (wave_speed*delta_t/(2*delta_x))*(copy_domain(i+1) - copy_domain(i-1)) + (((wave_speed*delta_t/delta_x)^2)/2)*(copy_domain(i+1) - 2*copy_domain(i) + copy_domain(i-1));
        end
        domain_scheme(1) = 0;
        domain_scheme(gridpts_x) = 0;

        copy_domain = domain_scheme;
        data_to_write = [n, domain_scheme];
        writematrix(data_to_write, filename, 'WriteMode', 'append');
    end

    if extra_fractional_time > 0
        domain_scheme = zeros(1, gridpts_x);
        for i = 2:gridpts_x-1
            domain_scheme(i) = copy_domain(i) - (wave_speed*extra_fractional_time/(2*delta_x))*(copy_domain(i+1) - copy_domain(i-1)) + (((wave_speed*extra_fractional_time/delta_x)^2)/2)*(copy_domain(i+1) - 2*copy_domain(i) + copy_domain(i-1));
        end
        domain_scheme(1) = 0;
        domain_scheme(gridpts_x) = 0;

        data_to_write = [integral_time_iterations + 1, domain_scheme];
        writematrix(data_to_write, filename, 'WriteMode', 'append');
    end
end
