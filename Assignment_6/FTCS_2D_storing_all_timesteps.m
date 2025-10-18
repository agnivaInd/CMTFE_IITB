function domain_data = FTCS_2D_storing_all_timesteps(gridpts_x,gridpts_y,delta_x,delta_y,delta_t,no_of_time_iterations,domain,alpha,k,h,rhs_flux,lhs_temp,ambient_temp,point)
    domain_data = zeros(gridpts_y,gridpts_x,no_of_time_iterations);
    gamma_x = alpha*delta_t/(delta_x^2);
    gamma_y = alpha*delta_t/(delta_y^2);

    for j = 1:gridpts_y
        for i = 1:gridpts_x
            domain_data(j,i,1) = domain(j,i);
        end
    end

    for n = 2:no_of_time_iterations
        for j = 2:gridpts_y-1
            for i = 2:gridpts_x-1
                domain_data(j,i,n) = (1 - 2*gamma_x - 2*gamma_y)*domain_data(j,i,n-1) + gamma_x*(domain_data(j,i-1,n-1) + domain_data(j,i+1,n-1)) + gamma_y*(domain_data(j-1,i,n-1) + domain_data(j+1,i,n-1));
            end
        end

        % Left Dirichlet BC
        for j = 1:gridpts_y
            domain_data(j,1,n) = lhs_temp;
        end

        % Bottom Neumann BC
        for i = 1:gridpts_x
            domain_data(gridpts_y,i,n) = domain_data(gridpts_y-1,i,n);
        end

        % Right Flux BC
        for j = 1:gridpts_y
            domain_data(j,gridpts_x,n) = domain_data(j,gridpts_x-1,n) - rhs_flux*delta_x/k;
        end

        % Top Mixed BC
        for i = 1:gridpts_x
            domain_data(1,i,n) = (ambient_temp*(h*delta_y/k) + domain_data(2,i,n))/(1 + (h*delta_y/k));
        end
    end
end