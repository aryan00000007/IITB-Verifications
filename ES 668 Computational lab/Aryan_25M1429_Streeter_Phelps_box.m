function Aryan_25M1429_Streeter_Phelps_box()
clear
clc

% Initialize Parameters
u = 3; % stream velocity in km/day
kd = 1; % BOD degradation rate in per day
ka = 3; % reaeration rate in per day 
Lo = 30; % Initial BOD loading in mg/L
yo = 3; % Initial DO Deficit in mg/L
DO_s = 8; % Saturation DO in mg/L

% Upto 10 km stretch at every 0.2 km 
xspan = 0:0.2:10;

%Solve ODE for DO Deficit
[x,y] = ode45(@(x,y) StreeterPhelps_ODE(x,y,ka,kd,u,Lo),xspan,yo);

% Do Deficit remaining
DO_act=DO_s-y;

%Plot results
plot(x,y);
hold on
plot(x,DO_act);
hold off
xlabel('Distance (in km)');
ylabel('DO Deficit Levels (mg/L)');
title ('Estimation of DO Deficit and actual DO by Streeter Phelps ODE');
legend("DO Deficit","Actual DO",Location="east")
grid on;
end

%Define what ODE equation is being solved in the above function
function dydx = StreeterPhelps_ODE(y,x,ka,kd,u,Lo)
dydx = -(ka/u)*y + (kd/u)*Lo*exp(-(kd/u)*x);
end