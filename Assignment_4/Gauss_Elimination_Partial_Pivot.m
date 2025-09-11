function result = Gauss_Elimination_Partial_Pivot(A,b)
    dimension = size(A,1);
    augmentedMatrix = [A b];

    % Forward Elimination
    for i=1:dimension-1
        % Partial Pivoting
        maxval = abs(A(i,i));
        for m = (i+1):dimension
            if(abs(A(m,i)) > maxval)
                maxval = A(m,i);
                temp_array = augmentedMatrix(i,:);
                augmentedMatrix(i,:) = augmentedMatrix(m,:);
                augmentedMatrix(m,:) = temp_array;
            end
        end
        for j=(i+1):dimension
            multiplier = augmentedMatrix(j,i)/augmentedMatrix(i,i);
            augmentedMatrix(j,:) = augmentedMatrix(j,:) - multiplier*augmentedMatrix(i,:);
        end
    end
    result = zeros(dimension,1);

    % Back Substitution
    for i=dimension:-1:1
        if i == dimension
            result(i) = augmentedMatrix(i,end)/augmentedMatrix(i,i);
        else
            sum = 0;
            for j=(i+1):dimension
                sum = sum + augmentedMatrix(i,j)*result(j);
            end
            result(i) = (augmentedMatrix(i,end) - sum)/augmentedMatrix(i,i);
        end
    end    
end
