clc
close all
clear

% Constants
pi = 2*acos(0);

% Input Parameters
wave_speed = 250;
x_domain_start = 0;
x_domain_end = 400;
delta_x = 0.5;
gridpts_x = (x_domain_end - x_domain_start)/delta_x + 1;
start_time = 0;
end_time = 0.5;

% For explicit scheme
courant_number = 0.1;
delta_t_explicit = courant_number * delta_x / wave_speed;
no_of_time_iterations_explicit = (end_time - start_time)/delta_t_explicit;
integral_time_iterations_explicit = floor(no_of_time_iterations_explicit);
extra_fractional_time_to_cover_explicit = max(0, round(end_time - delta_t_explicit * integral_time_iterations_explicit, 10));

% For implicit scheme
delta_t_implicit = 0.1;
no_of_time_iterations_implicit = (end_time - start_time)/delta_t_implicit;
integral_time_iterations_implicit = floor(no_of_time_iterations_implicit);
extra_fractional_time_to_cover_implicit = max(0, round(end_time - delta_t_implicit * integral_time_iterations_implicit, 10));

% Create and initialize domain
domain = zeros(1,gridpts_x);
store_x_values = zeros(1,gridpts_x);
x_domain_counter = x_domain_start;
i_index_counter = 1;
while x_domain_counter <= x_domain_end
    if x_domain_counter < 50
        domain(i_index_counter) = 0;
    elseif x_domain_counter <= 110
        domain(i_index_counter) = 100*sin(pi*(x_domain_counter - 50)/60);
    else
        domain(i_index_counter) = 0;
    end
    store_x_values(i_index_counter) = x_domain_counter;
    x_domain_counter = x_domain_counter + delta_x;
    i_index_counter = i_index_counter + 1;
end

% Explicit Scheme CSV Header
filename_explicit = 'LaxWendroffResults.csv';
fid = fopen(filename_explicit,'w');
fprintf(fid,'Time Step');
for idx = 1:gridpts_x
    fprintf(fid,',%g',store_x_values(idx));
end
fprintf(fid,'\n');
fclose(fid);

% Running explicit scheme
Lax_Wendroff(gridpts_x, domain, delta_x, delta_t_explicit, wave_speed, integral_time_iterations_explicit, extra_fractional_time_to_cover_explicit, filename_explicit);

% Implicit Scheme CSV Header
filename_implicit = 'BTCSResults.csv';
fid = fopen(filename_implicit,'w');
fprintf(fid,'Time Step');
for idx = 1:gridpts_x
    fprintf(fid,',%g',store_x_values(idx));
end
fprintf(fid,'\n');
fclose(fid);

% Running implicit scheme
BTCS(gridpts_x, domain, delta_x, delta_t_implicit, wave_speed, integral_time_iterations_implicit, extra_fractional_time_to_cover_implicit, filename_implicit);

% Load and Animate Explicit Results
data_explicit = readmatrix(filename_explicit);
time_steps_explicit = data_explicit(:,1);
solution_data_explicit = data_explicit(:,2:end);
header_explicit = readcell(filename_explicit,'Range','1:1');
x_values_explicit = cell2mat(header_explicit(2:end));

figure(1);
hPlot_explicit = plot(x_values_explicit, solution_data_explicit(2,:), 'LineWidth',2);
xlabel('x'); ylabel('u(x,t)');
title('Explicit (Lax–Wendroff) Scheme Animation');
grid on;
axis([min(x_values_explicit) max(x_values_explicit) min(solution_data_explicit(:)) max(solution_data_explicit(:))]);

for k = 2:50:size(solution_data_explicit,1)
    set(hPlot_explicit,'YData',solution_data_explicit(k,:));
    title(sprintf('Explicit Step = %d', time_steps_explicit(k)));
    drawnow;
    pause(0.05);
end

% Load and Animate Implicit Results
data_implicit = readmatrix(filename_implicit);
time_steps_implicit = data_implicit(:,1);
solution_data_implicit = data_implicit(:,2:end);
header_implicit = readcell(filename_implicit,'Range','1:1');
x_values_implicit = cell2mat(header_implicit(2:end));

figure(2);
hPlot_implicit = plot(x_values_implicit, solution_data_implicit(2,:), 'LineWidth',2);
xlabel('x'); ylabel('u(x,t)');
title('Implicit (BTCS) Scheme Animation');
grid on;
axis([min(x_values_implicit) max(x_values_implicit) min(solution_data_implicit(:)) max(solution_data_implicit(:))]);

for k = 2:size(solution_data_implicit,1)
    set(hPlot_implicit,'YData',solution_data_implicit(k,:));
    title(sprintf('Implicit Step = %d', time_steps_implicit(k)));
    drawnow;
    pause(0.5);
end

result_explicit_final = solution_data_explicit(end, :);
result_implicit_final = solution_data_implicit(end, :);

figure(3);
plot(x_values_explicit, result_explicit_final, 'b-', 'LineWidth', 1.5);
hold on;
plot(x_values_implicit, result_implicit_final, 'r--', 'LineWidth', 1.5);
hold off;
xlabel('x');
ylabel('u(x, t_{final})');
title('Explicit vs. Implicit at Final Timestep');
legend('Explicit (Lax–Wendroff)', 'Implicit (BTCS)', 'Location', 'Best');