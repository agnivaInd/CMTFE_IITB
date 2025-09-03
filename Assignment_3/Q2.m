clc
close all
clear

A = zeros(3,3);
b = zeros(3,1);

A(1,1) = 2; A(1,2) = -6; A(1,3) = -1;
b(1) = -38;
A(2,1) = -3; A(2,2) = -1; A(2,3) = 7;
b(2) = -34;
A(3,1) = -8; A(3,2) = 1; A(3,3) = -2;
b(3) = -20;

result = Gauss_Elimination_Partial_Pivot(A,b);
disp('Result using Gauss Elimination with Partial Pivoting:')
disp(result)