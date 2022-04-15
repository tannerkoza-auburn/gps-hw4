%% Fundamentals of GPS - Homework 4 - Problem 1

clear
clc
close all

%% Controller

% Control Gains
Kp = 8;
Ki = 25;

% Plant & Controller Definition
G = tf(1,[1 0]);
C = pid(Kp,Ki);

% Closed Loop System Definition
GCL = feedback(C*G,1);

% Step Response
figure
step(GCL)
lim = xlim;

%% Simulation

% Time Initialization
dt = 0.01;
t = 0:dt:lim(2);
tLen = length(t);

% Reference
rS = ones(tLen,1); % Step Input
rR = t'.*ones(tLen,1); % Ramp Input

% Initial Conditions & Preallocation
xDot = 0;
x = zeros(tLen,1);
e = zeros(tLen,1);
u = zeros(tLen,1);
eInt = 0;

for i = 1:tLen-1

    % Error
    e(i) = rS(i) - x(i);
    eInt = eInt + e(i)*dt;

    % Controller
    u(i) = Kp*e(i) + Ki*eInt;

    % Plant
    xDot = u(i);
    x(i+1) = x(i) + xDot*dt;

end

figure
plot(t,x)
hold on
yline(rS(1),'k:','LineWidth', 1.5)
title('Step Response')
legend('Output','Reference')

for i = 1:tLen-1

    % Error
    e(i) = rR(i) - x(i);
    eInt = eInt + e(i)*dt;

    % Controller
    u(i) = Kp*e(i) + Ki*eInt;

    % Plant
    xDot = u(i);
    x(i+1) = x(i) + xDot*dt;

end

figure
plot(t,x)
hold on
plot(t,rR,'k.','LineWidth', 1.5)
title('Ramp Response')
legend('Output','Reference')