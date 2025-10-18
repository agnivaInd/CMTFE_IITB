clc
close all
clear

% Material Properties
k = 100;
alpha = 10^-4;
h = 10;
rhs_flux = 2;
lhs_temp = 200;
ambient_temp = 25;

% Grid and time step parameters
x_domain_start = 0;
x_domain_end = 1;
y_domain_start = 0;
y_domain_end = 1;
gridpts_x = 41;
gridpts_y = 41;
delta_x = (x_domain_end - x_domain_start)/(gridpts_x - 1);
delta_y = (y_domain_end - y_domain_start)/(gridpts_y - 1);

start_time = 0;
end_time = 10;
delta_t = 0.1;
no_of_time_iterations = (end_time - start_time)/delta_t;
time = linspace(start_time,end_time,no_of_time_iterations);

domain = zeros(gridpts_y,gridpts_x);
initial_temp = 0;
for j = 1:gridpts_y
    for i = 1:gridpts_x
        domain(j,i) = initial_temp;
    end
end 

domain_data = FTCS_2D_storing_all_timesteps(gridpts_x,gridpts_y,delta_x,delta_y,delta_t,no_of_time_iterations,domain,alpha,k,h,rhs_flux,lhs_temp,ambient_temp,1);

x_array = linspace(x_domain_start, x_domain_end, gridpts_x);
y_array = linspace(y_domain_start, y_domain_end, gridpts_y);

[coord_x,coord_y] = return_coordinate_value(0.2,0.2,x_domain_start,y_domain_start,gridpts_x,gridpts_y,delta_x,delta_y);

[X,Y] = meshgrid(x_array,y_array);
%{
figure(1)
contourf(X, Y, domain_data(:,:,no_of_time_iterations), 20) 
xlabel('x')
ylabel('y')
title('Temperature Contours')
colorbar
axis equal
%}

point_1_x = 0.2; point_1_y = 0.2;
point_2_x = 0.5; point_2_y = 0.5;
point_3_x = 0.75; point_3_y = 0.75;

[point_1_x_coord, point_1_y_coord] = return_coordinate_value(point_1_x,point_1_y,x_domain_start,y_domain_start,gridpts_x,gridpts_y,delta_x,delta_y);
[point_2_x_coord, point_2_y_coord] = return_coordinate_value(point_2_x,point_2_y,x_domain_start,y_domain_start,gridpts_x,gridpts_y,delta_x,delta_y);
[point_3_x_coord, point_3_y_coord] = return_coordinate_value(point_3_x,point_3_y,x_domain_start,y_domain_start,gridpts_x,gridpts_y,delta_x,delta_y);

point_1_history = [];
point_2_history = [];
point_3_history = [];

for n = 1:no_of_time_iterations
    point_1_history(n) = domain_data(point_1_y_coord,point_1_x_coord,n);
    point_2_history(n) = domain_data(point_2_y_coord,point_2_x_coord,n);
    point_3_history(n) = domain_data(point_3_y_coord,point_3_x_coord,n);
end

figure(1);
plot(time,point_1_history,LineStyle="-",LineWidth=1.5,Color='b')
hold on
plot(time,point_2_history,LineStyle="--",LineWidth=1.5,Color='r')
hold on
plot(time,point_3_history,LineStyle=':',LineWidth=1.5,Color='g')
hold off
xlabel('Time')
ylabel('Temperature (Degree C)')
ylim([-0.002 inf])
title('Temperature Time History')
legend('Point 1: (0.2,0.2)', 'Point 2: (0.5,0.5)', 'Point 3: (0.75,0.75)','Location','northwest')

figure(2)
time_counter = 0;
for t = 1:no_of_time_iterations
    contourf(X, Y, domain_data(:,:,t), 20)
    xlabel('x')
    ylabel('y')
    title(['Temperature Contours at timestep ', num2str(time_counter), ' s'])
    colorbar
    axis equal
    drawnow
    time_counter = time_counter + delta_t;
end
