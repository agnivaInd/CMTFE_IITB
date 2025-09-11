function result_val = Newtons_Divided_Difference(x_val,y_val,x_input)
    points = length(x_val);
    divided_difference_table = zeros(points,points);
    for j = 1:points
        divided_difference_table(j,1) = y_val(j);
    end

    for j = 2:points
        for i = 1:points-j+1
            divided_difference_table(i,j) = (divided_difference_table(i+1,j-1) - divided_difference_table(i,j-1))/(x_val(i+j-1) - x_val(i));
        end
    end

    result_val = divided_difference_table(1,1);
    product = 1;
    for j = 2:points
        product = product*(x_input - x_val(j-1));
        result_val = result_val + product*divided_difference_table(1,j);
    end
end