function midpoint_temp_time_array = BTCS(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_bc,right_bc)
    midpoint_temp_time_array = [];
    gamma = alpha*delta_t/(delta_x^2);

    A = zeros(gridpts);
    b = zeros(gridpts,1);
    copy_domain(:) = domain(:);
    midpoint_temp_time_array(1) = domain((gridpts+1)/2);

    for n = 2:no_of_time_iterations
        for j = 1:gridpts
            if (j==1)
                A(j,j) = 1;
                b(j) = left_bc;
            elseif (j==gridpts)
                A(j,j) = 1;
                b(j) = right_bc;
            else
                A(j,j-1) = gamma;
                A(j,j) = -(1 + 2*gamma);
                A(j,j+1) = gamma;
                b(j) = -copy_domain(j);
            end
        end
        domain = A\b;
        midpoint_temp_time_array(n) = domain((gridpts+1)/2);
        copy_domain(:) = domain(:);
    end    
end