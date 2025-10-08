function midpoint_temp_time_array = DuFort_Frenkel(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_bc,right_bc)
    midpoint_temp_time_array = [];
    gamma = alpha*delta_t/(delta_x^2);

    older_domain(:) = domain(:);
    midpoint_temp_time_array(1) = older_domain((gridpts+1)/2);
    current_domain = [];

    % First step using FTCS
    for j = 1:gridpts
        if (j==1)
            current_domain(j) = left_bc;
        elseif (j==gridpts)
            current_domain(j) = right_bc;
        else
            current_domain(j) = gamma*older_domain(j+1) + (1 - 2*gamma)*older_domain(j) + gamma*older_domain(j-1);
        end
    end
    midpoint_temp_time_array(2) = current_domain((gridpts+1)/2);

    for n = 3:no_of_time_iterations
        n_timestep_domain(:) = current_domain(:);
        n_minus_one_timestep(:) = older_domain(:);
        for j = 1:gridpts
            if (j==1)
                current_domain(j) = left_bc;
            elseif (j==gridpts)
                current_domain(j) = right_bc;
            else
                current_domain(j) = ((1 - 2*gamma)*n_minus_one_timestep(j) + 2*gamma*(n_timestep_domain(j+1) + n_timestep_domain(j-1)))/(1 + 2*gamma);
            end
        end
        older_domain(:) = n_timestep_domain(:);
        midpoint_temp_time_array(n) = current_domain((gridpts+1)/2);
    end
       