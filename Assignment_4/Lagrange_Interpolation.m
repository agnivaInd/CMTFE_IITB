function result_val = Lagrange_Interpolation(x_val,y_val,x_input)
    points = length(x_val);
    result_val = 0;
    for i = 1:points
        Li = 1;
        for j = 1:points
            if(i~=j)
                Li = Li*(x_input - x_val(j))/(x_val(i) - x_val(j));
            end
        end
        result_val = result_val + y_val(i)*Li;
    end
end