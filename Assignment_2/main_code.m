clear
close all
clc

% Definitions of the functions
function_1 = @(x) exp(x)-x-2;
function_2 = @(x) x^5 - 8*x^4 + 44*x^3 - 91*x^2 + 85*x - 26;

% Tolerance and Maximum Number of Iterations
tolerance = 10^-6;
maximum_iterations = 10^4;

% Initial Values for the three methods
initial_guess_newton_raphson = 1;
lower_limit_bisection = -4;
upper_limit_bisection = 1;
first_guess_secant = -4;
second_guess_secant = -1;

% Solving Question 1 by the three methods
% Bisection
[q1_bisection_residue,q1_bisection_iteration,q1_bisection_root] = Bisection(function_1,lower_limit_bisection,upper_limit_bisection,tolerance,maximum_iterations);
% Newton-Raphson
[q1_newton_residue,q1_newton_iteration,q1_newton_root] = Newton_Raphson(function_1,initial_guess_newton_raphson,tolerance,maximum_iterations);
% Secant
[q1_secant_residue,q1_secant_iteration,q1_secant_root] = Secant(function_1,first_guess_secant,second_guess_secant,tolerance,maximum_iterations);

% Solving Question 2 by the three methods
% Bisection
[q2_bisection_residue,q2_bisection_iteration,q2_bisection_root] = Bisection(function_2,lower_limit_bisection,upper_limit_bisection,tolerance,maximum_iterations);
% Newton-Raphson
[q2_newton_residue,q2_newton_iteration,q2_newton_root] = Newton_Raphson(function_2,initial_guess_newton_raphson,tolerance,maximum_iterations);
% Secant
[q2_secant_residue,q2_secant_iteration,q2_secant_root] = Secant(function_2,first_guess_secant,second_guess_secant,tolerance,maximum_iterations);

q1_Bisection = [q1_bisection_iteration(:),q1_bisection_residue(:)];
filename = 'Q1_Bisection.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q1_Bisection,filename,'WriteMode','append');

q1_Newton_Raphson = [q1_newton_iteration(:),q1_newton_residue(:)];
filename = 'Q1_Newton_Raphson.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q1_Newton_Raphson,filename,'WriteMode','append');

q1_Secant = [q1_secant_iteration(:),q1_secant_residue(:)];
filename = 'Q1_Secant.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q1_Secant,filename,'WriteMode','append');

q2_Bisection = [q2_bisection_iteration(:),q2_bisection_residue(:)];
filename = 'Q2_Bisection.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q2_Bisection,filename,'WriteMode','append');

q2_Newton_Raphson = [q2_newton_iteration(:),q2_newton_residue(:)];
filename = 'Q2_Newton_Raphson.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q2_Newton_Raphson,filename,'WriteMode','append');

q2_Secant = [q2_secant_iteration(:),q2_secant_residue(:)];
filename = 'Q2_Secant.csv';
fid = fopen(filename,'w');
fprintf(fid,'Iteration Counter, Absolute Error\n');
fclose(fid);
writematrix(q2_Secant,filename,'WriteMode','append');

disp('Question 1')
disp(['Bisection Root: ',num2str(q1_bisection_root)]);
disp(['Newton-Raphson Root: ',num2str(q1_newton_root)]);
disp(['Secant Root: ',num2str(q1_secant_root)]);

disp('Question 2')
disp(['Bisection Root: ',num2str(q2_bisection_root)]);
disp(['Newton-Raphson Root: ',num2str(q2_newton_root)]);
disp(['Secant Root: ',num2str(q2_secant_root)]);