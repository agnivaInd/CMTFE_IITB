clc
close all
clear

% Domain setup
x_domain_start = 0;
x_domain_end = 1;
y_domain_start = 0;
y_domain_end = 1;
delta_x = 0.02;
delta_y = 0.02;
gridpts_x = (x_domain_end - x_domain_start)/delta_x + 1;
gridpts_y = (y_domain_end - y_domain_start)/delta_y + 1;
beta = delta_x/delta_y;

y_array = linspace(y_domain_end,y_domain_start,gridpts_y);
x_array = linspace(x_domain_end,x_domain_start,gridpts_x);

% Case specific values
Re = 100;
u_top_bc = 1;

% Creating data structure and initializing interior domain
U = zeros(gridpts_y,gridpts_x);
V = zeros(gridpts_y,gridpts_x);
Shi = zeros(gridpts_y,gridpts_x);
Omega = zeros(gridpts_y,gridpts_x);

% Boundary Conditions
U(1,:) = u_top_bc;

tolerance = 10^-4;
residue = 1; % Initializing residue with 1
iteration_count = 0;

while (residue > tolerance)

    % (Step 4) Copying data from previous iteration
    U_old = U; V_old = V; Shi_old = Shi; Omega_old = Omega;

    % (Step 5) Evaluating u, v from old shi
    for j = 2:gridpts_y-1
        for i = 2:gridpts_x-1
            U(j,i) = (Shi_old(j-1,i) - Shi_old(j+1,i))/(2*delta_y);
            V(j,i) = (Shi_old(j,i-1) - Shi_old(j,i+1))/(2*delta_x);
        end
    end
    U(:,1) = 0; U(:,gridpts_x) = 0;
    U(gridpts_y,:) = 0; U(1,:) = u_top_bc;
    V(:,1) = 0; V(:,gridpts_x) = 0;
    V(gridpts_y,:) = 0; V(1,:) = 0;

    % (Step 6) Updating Shi at interior gridpoints using previous values of Omega
    for j = 2:gridpts_y-1
        for i = 2:gridpts_x-1
            Shi(j,i) = (1/(2*(1+beta^2)))*(Shi_old(j,i+1)+Shi_old(j,i-1)+ (beta^2)*(Shi_old(j+1,i)+Shi_old(j-1,i))+ (delta_x^2)*Omega_old(j,i));
        end
    end

    % (Step 7) Updating omega at boundaries
    for i = 1:gridpts_x
        Omega(gridpts_y,i) = -(2/delta_y^2)*Shi(gridpts_y-1,i);
        Omega(1,i) = (2/delta_y^2)*(- u_top_bc*delta_y - Shi(2,i));
    end
    for j = 1:gridpts_y
        Omega(j,1) = -(2/delta_x^2)*Shi(j,2);
        Omega(j,gridpts_x) = -(2/delta_x^2)*Shi(j,gridpts_x-1);
    end

    % (Step 8) Updating Vorticity at interior nodes
    for j = 2:gridpts_y-1
        for i = 2:gridpts_x-1
            term_1 = Omega_old(j,i+1) + Omega_old(j,i-1) + (beta^2)*(Omega_old(j+1,i) + Omega_old(j-1,i));
            term_2 = Re*(delta_x^2)*(U(j,i)*(Omega_old(j,i+1) - Omega_old(j,i-1))/(2*delta_x) + V(j,i)*(Omega_old(j-1,i) - Omega_old(j+1,i))/(2*delta_y));
            Omega(j,i) = (1/(2*(1 + beta^2)))*(term_1 + term_2);
        end
    end

    % Step 9 skipped
    % (Step 10) Residue checking
    residue_array = zeros(1,4);
    residue_array(1) = max(abs(U(:) - U_old(:)));
    residue_array(2) = max(abs(V(:) - V_old(:)));
    residue_array(3) = max(abs(Shi(:) - Shi_old(:)));
    residue_array(4) = max(abs(Omega(:) - Omega_old(:)));
    residue = max(residue_array);

    iteration_count = iteration_count + 1;
end

% Benchmark result
u_B = [-0.036619718, -0.042253521, -0.047887324, -0.061971831, -0.101408451, ...
-0.157746479, -0.211267606, -0.205633803, -0.136619718, 0.004225352, ...
0.232394366, 0.688732394, 0.738028169, 0.790140845, 0.842253521, ...
1.001408451];
y_B = [0.052030457, 0.063451777, 0.072335025, 0.098984772, 0.171319797, ...
0.280456853, 0.45177665, 0.498730964, 0.616751269, 0.733502538, ...
0.851522843, 0.953045685, 0.960659898, 0.968274112, 0.975888325, ...
0.998730964];

[X,Y] = meshgrid(x_array,y_array);

figure(1)
contourf(X, Y, Shi, 20)
title('Stream function Contour Plot')
xlabel('X')
ylabel('Y')
colorbar

figure(2)
contourf(X, Y, Omega, 20)
title('Vorticity Field')
xlabel('X')
ylabel('Y')
colorbar

figure(3)
contourf(X, Y, U, 20)
title('U Velocity Contour Plot')
xlabel('X')
ylabel('Y')
colorbar

figure(4)
contourf(X, Y, -V, 20)
title('V Velocity Contour Plot')
xlabel('X')
ylabel('Y')
colorbar

figure(5)
plot(u_B,y_B,'o',Color='r',LineWidth=1.5)
hold on
plot(U(:,(gridpts_x+1)/2),y_array,'-',Color ='b',LineWidth=1.5);
hold off
legend('Benchmark Solution','Present Results', Location='best')
xlabel('U velocity')
ylabel('y value')