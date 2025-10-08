function midpoint_temp_time_array = FTCS(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_bc,right_bc)
    midpoint_temp_time_array = [];
    midpoint_temp_time_array(1) = domain((gridpts+1)/2);
    gamma = alpha*delta_t/(delta_x^2);
    for n = 2:no_of_time_iterations
        copy_domain = [];
        for j = 1:gridpts
            copy_domain(j) = domain(j);
        end
        for j = 1:gridpts
            if (j==1)
                domain(j) = left_bc;
            elseif (j==gridpts)
                domain(j) = right_bc;
            else
                domain(j) = gamma*copy_domain(j+1) + (1 - 2*gamma)*copy_domain(j) + gamma*copy_domain(j-1);
            end
        end
        midpoint_temp_time_array(n) = domain((gridpts+1)/2);
    end    
end