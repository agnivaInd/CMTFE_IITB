function residue = residue_evaluate(variable,variable_old,gridpts_x,gridpts_y)
    sum = 0;
    for j = 1:gridpts_y
        for i = 1:gridpts_x
            sum = sum + (variable(j,i) - variable_old(j,i))^2;
        end
    end
    residue = sqrt(sum);
end