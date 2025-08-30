clear
close all
clc

% Q1 
% x = 0 to 1 domain is defined
x = linspace(0,1,101);

% Arrays for storing the values of the error function
true_value = [];        
evaluated_value_11 = [];
evaluated_value_21 = [];

for i = 1:numel(x)
    true_value(i) = erf(x(i));
    evaluated_value_11(i) = evaluate_taylor_numerically(x(i),5);
    evaluated_value_21(i) = evaluate_taylor_numerically(x(i),10);
end

figure(1)
idx = 1:10:numel(x);
plot(x(idx), true_value(idx), 'o', 'MarkerFaceColor', 'g', 'LineStyle', 'none')
hold on
plot(x,evaluated_value_11,LineStyle="-",Color="r",LineWidth=1.5)
hold on
plot(x,evaluated_value_21,LineStyle="--",Color="b",LineWidth=1.5)
hold on
xlabel('x', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('y', 'FontName', 'Times New Roman', 'FontSize', 16)
legend({'True Value', 'Order 11 polynomial', 'Order 21 polynomial'}, 'FontName', 'Times New Roman', 'FontSize', 16, 'Location', 'northwest')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
hold off

% Q2
absolute_error_3 = [];
absolute_error_5 = [];
absolute_error_11 = [];

for i = 1:numel(x)
    absolute_error_3(i) = abs(true_value(i) - evaluate_taylor_numerically(x(i), 1));
    absolute_error_5(i) = abs(true_value(i) - evaluate_taylor_numerically(x(i), 2));
    absolute_error_11(i) = abs(true_value(i) - evaluate_taylor_numerically(x(i), 5));
end

figure(2)
semilogy(x,absolute_error_3,Linestyle="-",Color="b",LineWidth=1.5)
hold on
semilogy(x,absolute_error_5,Linestyle="--",Color="g",LineWidth=1.5)
hold on
semilogy(x,absolute_error_11, LineStyle="-.",Color="r",LineWidth=1.5)
xlabel('x','FontName','Times New Roman', 'FontSize', 16)
ylabel('Absolute Error(E)','FontName','Times New Roman', 'FontSize', 16)
legend({'Order 3 polynomial', 'Order 5 polynomial', 'Order 11 polynomial'}, 'FontName', 'Times New Roman', 'FontSize', 16, 'Location', 'southeast')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
hold off