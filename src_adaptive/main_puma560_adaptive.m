close all, clear all, clc,


%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                                INSTRUCTIONS
%__________________________________________________________________________
%
% Please select one of the following controllers:
%                   * 'adaptiveCT'
%                   * 'adaptiveBS'
%
controller = 'adaptiveBS';
%
% Please select one of the following tasks:
%                   * 'position_control'
%                   * 'sinusoidal_trajectory_tracking'
%                   * 'finite_fourier_series_trajectory_tracking'
task = 'finite_fourier_series_trajectory_tracking';
%%_________________________________________________________________________



%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                           SIMULATION PARAMETERS
%__________________________________________________________________________
% Simulation time
timeSpan = 20;                                      % Duration  [s]
timeStep = 0.001;                                   % Time step [s]

time = [0:timeStep:timeSpan]';


%% Model (true values)
% % mdl_m1 = 0;                                 % mass of link 1    [kg]
% % mdl_m2 = 17.4;                              % mass of link 2    [kg]
% % mdl_m3 = 4.8;                               % mass of link 3    [kg]
% % mdl_m4 = 0.82;                              % mass of link 4    [kg]
% % mdl_m5 = 0.34;                              % mass of link 5    [kg]
% % mdl_m6 = 0.09;                              % mass of link 6    [kg]

%% Initial estimation
est_m1 = 0.05;                                  % mass of link 1    [kg]
est_m2 = 16;                                    % mass of link 2    [kg]
est_m3 = 5;                                     % mass of link 3    [kg]
est_m4 = 0.7;                                   % mass of link 4    [kg]
est_m5 = 0.5;                                   % mass of link 5    [kg]
est_m6 = 0.15;                                  % mass of link 6    [kg]


[p560, p560_est] = mdl_puma560_param(est_m1, est_m2, est_m3, est_m4, est_m5, est_m6);

% Initial Dynamic Parameter Guess
init_pi         % generates pi_real and pi_est_0


%% Trajectory
if strcmpi(task, 'finite_fourier_series_trajectory_tracking')
    finite_fourier_series_trajectory_tracking
elseif strcmpi(task, 'sinusoidal_trajectory_tracking')
    sinusoidal_trajectory_tracking
elseif strcmpi(task, 'position_control')
    position_control
else
    error('Invalid task.');
end



%% Controller
if strcmpi(controller, 'adaptiveCT')
    adaptiveCT_main
elseif strcmpi(controller, 'adaptiveBS')
    adaptiveBS_main
else
    error('Invalid controller type. Possible values: ''adaptiveCT'' or ''adaptiveBS''.');
end



%% Plot
plot_adaptive
