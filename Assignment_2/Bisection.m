function [residue_array, iteration_array, root] = Bisection(func,lower_limit,upper_limit,tolerance,maximum_iterations)
    iteration_array = [];
    residue_array = [];
    iteration_counter = 1;
    if (func(lower_limit)*func(upper_limit) > 0)
        disp('Function values are not of opposite signs');
    end
    while((upper_limit - ((lower_limit + upper_limit)/2)) > tolerance)
        if(iteration_counter > maximum_iterations)
            break
        end
        midpoint_value = (lower_limit + upper_limit)/2;
        residue = upper_limit - midpoint_value; 
        residue_array(iteration_counter) = residue;
        iteration_array(iteration_counter) = iteration_counter;
        if(residue <= tolerance)
            root = midpoint_value;
            break
        else
            if(func(lower_limit)*func(midpoint_value) < 0)
                upper_limit = midpoint_value;
            else
                lower_limit = midpoint_value;
            end
        end

        iteration_counter = iteration_counter + 1;
    end
    if ~(exist('root','var'))
        root = (lower_limit + upper_limit) / 2;
    end
end
