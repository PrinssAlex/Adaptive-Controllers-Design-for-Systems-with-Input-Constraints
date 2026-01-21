
clear; clc;

% Simulation parameters
gamma=1; % adaptation gain
simTime=20; % simulation time

% Display setup
fprintf('Lion Scheme Simulation Setup\n');
fprintf('Plant: 3/(s^2 + 3s + 1)\n');
fprintf('Reference Model: 1/(s^2 + 2s + 1)\n');
fprintf('Reference Signal: sign(sin(t)) + 2\n');
fprintf('Adaptation Gain: %.1f\n', gamma);
fprintf('Simulation Time: %.1f s\n\n', simTime);

% Save to workspace for Simulink access
assignin('base', 'gamma', gamma);
assignin('base', 'simTime', simTime);
%%

% lion_setup.m
% Setup plant, model, filters, and sim parameters

% Plant and reference model 
Gp = tf(3, [1 3 1]);
Gm = tf(1, [1 2 1]);

% Filters H1, H2, H3
H1 = tf(1,1);
H2 = tf(1, [1 1]);
H3 = tf(2, [1 2]);

% Adaption gain 
gamma = 1;

% Simulation settings 
simTime = 20;
solver = 'ode45';

% Save to workspace 
assignin('base', 'Gp', Gp);
assignin('base', 'Gm', Gm);
assignin('base', 'H1', H1);
assignin('base', 'H2', H2);
assignin('base', 'H3', H3);
assignin('base', 'gamma', gamma);
assignin('base', 'simTime', simTime);
assignin('base', 'solver', solver);




