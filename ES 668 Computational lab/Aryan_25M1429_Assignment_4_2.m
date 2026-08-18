function Aryan_25M1429_Assignment_4_2
% Parameters
T  = 4639;          % transmissivity (m^2/day)
S  = 0.0004493;     % storativity
Q  = 8640;          % pumping rate (m^3/day)
h0 = 1000;          % initial head (m)

rmax = 100000;      % 100 km
tmax = 100;         % 100 days

% time and distance span
r = linspace(1, rmax, 500);    
t = linspace(0, tmax, 250);

% Solve PDE
sol = pdepe(1,@pbpde,@icpb,@bcpb,r,t);
h = sol(:,:,1);

% (a) Hydraulic head over space and time
figure;
surf(r,t,h);
xlabel('Radius (m)');
ylabel('Time (days)');
zlabel('Hydraulic head (m)');
title('Hydraulic head h(r,t)');
shading interp
grid on

% (b) Drawdown vs time at r = 100 m
r_obs = 100;
[~, idx] = min(abs(r - r_obs));
drawdown_t = h0 - h(:,idx);
figure;
plot(t,drawdown_t);
xlabel('Time (days)');
ylabel('Drawdown (m)');
title('Drawdown vs Time at r = 100 m');
grid on

% (c) Drawdown vs radius at t = 60 days
t_obs = 60;
[~, idt] = min(abs(t - t_obs));
drawdown_r = h0 - h(idt,:);
figure;
plot(r,drawdown_r);
xlabel('Radius r (m)');
ylabel('Drawdown (m)');
title('Drawdown vs Radius at t = 60 days');
grid on
% defined functions
function [c,f,s] = pbpde(r,t,h,dhdr)
c = S/T;
f = dhdr;
s = 0;
end
% initial condition
function hini = icpb(r)
hini = h0;
end
% boundary condition
function [pl,ql,pr,qr] = bcpb(rl,hl,rr,dhdr,t)
pl = -Q/(2*pi*T);  
ql = 1;
pr = 0;
qr = 1;
end
end