clc
close all
clear

A = zeros(3,3);
b = zeros(3,1);

% Part A: Assigning values to A, b and displaying them
A(1,1) = 10; A(1,2) = 2; A(1,3) = -1;
b(1) = 27;
A(2,1) = -3; A(2,2) = -6; A(2,3) = -2;
b(2) = -61.5;
A(3,1) = 1; A(3,2) = 1; A(3,3) = 5;
b(3) = -21.5;

disp('Matrix A:')
disp(A)
disp('Column Vector b:')
disp(b)

% Part B: Solving by Gauss Elimination
result = Gauss_Elimination_No_Pivot(A,b);
disp('x (Using Gauss Elimination Without Pivoting):')
disp(result)

% Part C: Solving by Matrix Inversion
x = A\b;
disp('x (Using Matrix Inversion):')
disp(x)