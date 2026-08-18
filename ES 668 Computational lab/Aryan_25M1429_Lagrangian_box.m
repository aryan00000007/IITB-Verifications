function Aryan_25M1429_Lagrangian_box()
clc
clear

% Initialize Parameters
q = 2000; % flux of pollutant in ug/m2-h
H = 1000; % mixing height in m
k = 0.03; % rate constant in per hour
vd = 0.01 * 3600; % m/hr
c_initial = [1:1:10]; % ug/m3, initial concentration

%Timespan for solving ODE
tspan = [0,60];

%Solve ODE for Lagrangian box
[t, c] = ode45(@(t,c) Lagrangian_ODE(t, c, q, H, k, vd), tspan, c_initial);

%Plot results
plot(t, c);
xlabel('Time (h)');
ylabel('SO_2 Concentration (\mug/m3)');
title ('Time Variation of SO_2 Concentration');
grid on;
end

%Define what ODE equation is being solved in the above function
function dcdt = Lagrangian_ODE(~,c,q,H,k,vd)
dcdt = (q/H) - (k*c) - (vd*c/H);
end
