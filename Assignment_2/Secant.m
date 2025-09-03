function[residue_array,iteration_array,root] = Secant(func,x_old,x_new,tolerance,maximum_iterations)
    iteration_array = [];
    residue_array = [];
    iteration_counter = 1;
    while (iteration_counter < maximum_iterations)
        x_latest = x_new - func(x_new)*(x_new - x_old)/(func(x_new) - func(x_old));
        residue = abs(x_latest - x_new);
        if(residue < tolerance)
            root = x_latest;
            break
        else
            x_old = x_new;
            x_new = x_latest;
        end
        iteration_array(iteration_counter) = iteration_counter;
        residue_array(iteration_counter) = residue;
        iteration_counter = iteration_counter + 1;
    end
end