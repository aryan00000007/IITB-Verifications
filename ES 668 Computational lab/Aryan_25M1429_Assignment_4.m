function Aryan_25M1429_Assignment_4
%parameters
T=5;
L=2.5;
D=0.01;
v=1;
ui=1;
u0=0;
%time and distance span
x=linspace(0,L,100);
t=linspace(0,T,100);
%solve PDE
sol=pdepe(0,@pbpde,@icpb,@bcpb,x,t);
u_output=sol(:,end);
u_middle=sol(40,:);
%Plot results
surf(x,t,sol)
title('pollutant concentration over space and time')
xlabel('Distance(m)')
ylabel('Time(s)')
zlabel('Concentration(x,t)')
grid on;
figure;
plot(t,u_output);
xlabel('Time(s)')
ylabel('Concentration(kg/m^3)')
grid on;
figure;
plot(x, u_middle);
xlabel('Distance (m)')
ylabel('Concentration (kg/m^3)')
grid on;

function[c,f,s]=pbpde(x,t,u,dudx);
c=1;
f=D*dudx;
s=-v*dudx;
end
%initial condition
function u0=icpb(x);
u0=0;
end
%boundary condition
function [pl,ql,pr,qr]=bcpb(xl,ul,pr,qr,t);
pl=ul-ui;
ql=0;
pr=0;
qr=1;
end
end