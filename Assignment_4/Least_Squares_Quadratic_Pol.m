function result_val = Least_Squares_Quadratic_Pol(x_val,y_val,x_input)
    points = length(x_val);
    sum_x = 0; sum_x2 = 0; sum_x3 = 0; sum_x4 = 0;
    sum_y = 0; sum_xy = 0; sum_x2y = 0;
    for i = 1:points
        sum_x = sum_x + x_val(i); 
        sum_x2 = sum_x2 + (x_val(i))^2;
        sum_x3 = sum_x3 + (x_val(i))^3; 
        sum_x4 = sum_x4 + (x_val(i))^4;
        sum_y = sum_y + (y_val(i)); 
        sum_xy = sum_xy + (x_val(i)*y_val(i));
        sum_x2y = sum_x2y + y_val(i)*(x_val(i))^2;
    end
    
    A = zeros(3,3);
    b = zeros(3,1);

    A(1,1) = points; A(1,2) = sum_x; A(1,3) = sum_x2;
    A(2,1) = sum_x; A(2,2) = sum_x2; A(2,3) = sum_x3;
    A(3,1) = sum_x2; A(3,2) = sum_x3; A(3,3) = sum_x4;

    b(1) = sum_y; b(2) = sum_xy; b(3) = sum_x2y;

    result = Gauss_Elimination_Partial_Pivot(A,b);
    result_val = result(1) + result(2)*x_input + result(3)*(x_input)^2;
end