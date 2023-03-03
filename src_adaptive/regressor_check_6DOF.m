clear all, close all, clc


%% Simulation parameters
timeSpan = 0.05 * 3;                                        % Duration  [s]     60
timeStep = 0.005;                                           % Time step [s]
time = [0:timeStep:timeSpan]';

%% Simualtion time
timeSpan = 5;                                               % [s]      20
timeStep = 0.05;                                            % [s]
time = [0:timeStep:timeSpan]';                              % [s]

%% Model
mdl_puma560_simpl

%% Parameters
init_pi
pi0 = pi_real;

%% Trajectory
finite_fourier_series


%% Check regressore su traiettoria
tmp = zeros(size(q_des,1),6);

% Errore dinamica lagrangiana e dinamica via regressore
for i = 1:20
    i  % DEBUG
    
    G = p560.gravload(q_des(i,:));                              % G(q)
%     B = p560.friction(q_vel_des(i-1,:));                      % B(qd)
    M = p560.inertia(q_des(i,:));                               % Matrice inerzia M(q)
    C = p560.coriolis(q_des(i,:), q_vel_des(i,:));              % Matrice Coriolis C(q,qd)
    
    Y = regressor(q_des(i,:), q_vel_des(i,:), q_acc_des(i,:));
    
    tmp(i,:) = M * q_acc_des(i,:)' + C * q_vel_des(i,:)' + G' - Y * pi0';
    tmp(i,:)  % DEBUG

end

% Norma dell'errore
for i = 1:length(tmp)
    A(i) = norm(tmp(i,:));
end

% A(1:length(time))
A(1:20)
