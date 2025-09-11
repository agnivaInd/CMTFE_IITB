clc
close all
clear

f = @(x) 1/(1 + 25*x^2);
N = 20; % Number of grid points

domain_start = -1;
domain_end = 1;

x_val = linspace(domain_start,domain_end,N);
func_val = [];

for i=1:numel(x_val)
    func_val(i) = f(x_val(i));
end

x = linspace(domain_start,domain_end,1001);
true_value = [];
lagrange_interpolation_result = [];
divided_difference_result = [];
least_squares_quadratic_interpolation = [];

for i = 1:numel(x)
    true_value(i) = f(x(i));
    lagrange_interpolation_result(i) = Lagrange_Interpolation(x_val,func_val,x(i));
    divided_difference_result(i) = Newtons_Divided_Difference(x_val,func_val,x(i));
    least_squares_quadratic_interpolation(i) = Least_Squares_Quadratic_Pol(x_val, func_val, x(i));
end

plot(x,true_value,LineWidth=1.5,LineStyle=":",Color='magenta')
hold on
plot(x,lagrange_interpolation_result,LineWidth=1.5,LineStyle="-",Color='blue')
hold on
plot(x,divided_difference_result,LineWidth=1.5,LineStyle="--",Color='red')
hold on
plot(x,least_squares_quadratic_interpolation,LineWidth=1.5,LineStyle="-.",Color='green')
hold off
xlabel('x')
ylabel('y')
legend(' True Function Value ',' Lagrange Interpolation ',' Newton''s Divided Difference ',' Least Square Quadratic Interpolation ','Location','north')
set(findall(gcf,'Type','text'),'FontName','Times New Roman','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',16); 

error_array = [];
for i = 1:numel(x)
    error_array(i) = (true_value(i) - least_squares_quadratic_interpolation(i))/true_value(i);
end

transpose_error_array = error_array.';
x_transpose = x.';

matrix = [x_transpose,transpose_error_array];
filename = 'Relative_Error_Least_Square_Pol_Interpol.csv';
fid = fopen(filename,'w');
fprintf(fid,'x Value, Relative Error\n');
fclose(fid);
writematrix(matrix,filename,'WriteMode','append');