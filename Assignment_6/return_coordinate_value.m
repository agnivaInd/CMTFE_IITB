function [index_x, index_y] = return_coordinate_value(x_location,y_location,x_domain_start,y_domain_start,gridpts_x,gridpts_y,delta_x,delta_y)
    x_counter = x_domain_start;
    for i = 1:gridpts_x
        if (abs(x_counter - x_location)<10^-6)
            index_x = i;
            break
        else
            x_counter = x_counter + delta_x;
        end
    end
    y_counter = y_domain_start;
    for j = gridpts_y:-1:1
        if(abs(y_counter - y_location)<10^-6)
            index_y = j;
            break
        else
            y_counter = y_counter + delta_y;
        end
    end    
end