clc
close all
clear

% Material Properties
density = 8000;
sp_heat = 385;
thermal_cond = 400;
alpha = thermal_cond/(density*sp_heat);

% Constant values are defined here
rod_domain_start = 0;
rod_domain_end = 1;
rod_length = rod_domain_end - rod_domain_start;
delta_x = 0.1;
gridpts = rod_length/delta_x + 1;

start_time = 0;
end_time = 900;
delta_t = 1;
no_of_time_iterations = (end_time - start_time)/delta_t + 1;
time = linspace(start_time,end_time,no_of_time_iterations);

left_boundary = 400;
right_boundary = 400;

domain = [];

initial_temp = 25;
for i = 1:gridpts
    domain(i) = initial_temp;
end

ftcs_midpoint_array = FTCS(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_boundary,right_boundary);
dufort_frenkel_array = DuFort_Frenkel(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_boundary,right_boundary);
btcs_frenkel_array = BTCS(gridpts,no_of_time_iterations,domain,delta_x,delta_t,alpha,left_boundary,right_boundary);

for n = 1:no_of_time_iterations
    if (ftcs_midpoint_array(n) > 200)
        first_time_at_which_Temp_more_than_200 = n;
        break;
    end
end

string = ['The first time at which temp is just more than 200 degree C in the FTCS Scheme is: ',num2str(first_time_at_which_Temp_more_than_200),' sec'];
disp(string);

figure(1)
plot(time,ftcs_midpoint_array,LineWidth=1.5,Color='r')
legend('FTCS','location','northwest')
title('FTCS Scheme')
xlabel('time')
ylabel('Temp (degree C)')
figure(2)
plot(time,dufort_frenkel_array,LineWidth=1.5,Color='b')
legend('Du-Fort Frenkel','location','northwest')
title('Du-Fort Frenkel Scheme')
xlabel('time')
ylabel('Temp (degree C)')
figure(3)
plot(time,btcs_frenkel_array,LineWidth=1.5,Color='g');
legend('BTCS','location','northwest')
title('BTCS Scheme')
xlabel('time')
ylabel('Temp (degree C)')