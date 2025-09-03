function[residue_array,iteration_array,root] = Newton_Raphson(func,x_val,tolerance,maximum_iterations)
    iteration_array = [];
    residue_array = [];
    iteration_counter = 1;
    dx = 10^-6;
    slope_tolerance = 10^-6;
    while (iteration_counter < maximum_iterations)
        derivative = (func(x_val+dx)-func(x_val-dx))/(2*dx);
        if(abs(derivative) < slope_tolerance)
            disp('Converging towards a zero slope region, retry with a different initisl guess\n');
            break
        else    
            x_new = x_val - func(x_val)/derivative;
            residue = abs(x_new - x_val);
            residue_array(iteration_counter) = residue;
            iteration_array(iteration_counter) = iteration_counter;
            if (residue < tolerance)
                root = x_new;
                break
            else
                x_val = x_new;
            end
            iteration_counter = iteration_counter + 1;
        end    
    end    
end