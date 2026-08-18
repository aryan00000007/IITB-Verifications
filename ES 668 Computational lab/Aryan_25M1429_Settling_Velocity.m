clc
clear
disp("Settling Velocity using Regula-Falsi Method")
% Given parameters
rho_p = 2650;      % density of particle
rho_f = 1000;      % density of water
g     = 9.81;      % acceleration due to gravity
mu    = 0.001;     % dynamic viscosity of water
d     = 0.0005;    % diameter of particle
C_d    = 0.47;     % drag coefficient for a sphere (non-linear)
% Defined Function
f = @(v) (((rho_p - rho_f).*g.*d.^2) ...
         ./ (18.*mu + 0.5.*C_d.*rho_f.*v.*d)) - v;
% Initial guesses
a = 0;              % lower limit
b = 1;              % upper limit
tol = 0.000001;
n = 100;
% Plot preparation
figure
fplot(f,[a,b])
hold on;
grid on;
xlabel("Velocity v (m/s)");
ylabel("f(v)");
title("Regula-Falsi Method Convergence");
plot(a,f(a),"ro")
plot(b,f(b),"ro")
% Check validity
if f(a)*f(b) > 0
    error("Function must have opposite signs at a and b")
end
% Regula-Falsi iteration
for i = 1:n
    c = b - f(b)*(b-a)/(f(b)-f(a));
    % print iteration count with function value
    fprintf("Iteration %d: v = %.6f, f(v) = %.6f\n", i, c, f(c))
    plot(c,f(c),"bo")
    % check if the root is reached or the interval is small enough
    if abs(f(c)) < tol||(b-a) < tol
        fprintf("Settling velocity v = %.6f m/s after %d iterations\n", c, i)
        plot(c,f(c),"go","MarkerSize",10,"MarkerFaceColor","g")
        hold off;
        break
    end
    % Subinterval for next iteration
    if f(a)*f(c) < 0
        b = c;          % Update the upper limit
    else
        a = c;          % Update the lower limit
    end
    pause(0.5);
end
% if max. iterations are reached
if i == n
    disp("Maximum number of iterations reached without convergence")
end