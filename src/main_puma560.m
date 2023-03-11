clear all, close all, clc


%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                                INSTRUCTIONS
%__________________________________________________________________________
%
% Please select one of the following controllers:
%                   * 'Kinematic_grad'
%                   * 'Kinematic_LevMar'
%                   * 'PD'
%                   * 'CT'
%                   * 'BS'
%
controller = 'CT';
% Please select one of the following tasks:
%                   * 'position_control'                (for Kinematic_grad, Kinematic_LevMar)
%                   * 'pick_and_place'                  (for PD, CT, BS)
%                   * 'circular_trajectory_tracking'    (for CT, BS, Kinematic_LevMar)
%
task = 'pick_and_place';
%%_________________________________________________________________________



%% Simulation time
timeSpan = 20;                                          % [s]
timeStep = 0.01;                                        % [s]
time = [0:timeStep:timeSpan]';                          % [s]


%% PUMA560 model
mdl_puma560_simpl;    % Peter Corke model, simplified


%% General variables:
% q_des = [];       % target robot configuration/joint target position
% q_vel_des = [];   % joint target velocity
% q_acc_des = [];   % joint target acceleration
% %
% q = [];           % actual robot configuration/actual joint position
% q_vel = [];       % actual joint velocity
% q_acc = [];       % actual joint acceleration
% %
% e = [];           % tracking error
% e_vel = [];       % velocity error
% %
% tau = [];         % joint torque



%% Manipulator initial configuration
q_vel0 = [0 0 0 0 0 0];
q_acc0 = [0 0 0 0 0 0];



%% Trajectory
if strcmpi(task, 'pick_and_place')
    if (~strcmpi(controller, 'PD') && ~strcmpi(controller, 'CT') && ~strcmpi(controller, 'BS'))
        error('Controller: choose ''PD'', ''CT'' or ''BS'' controller instead.')
    end
    pick_and_place
elseif strcmpi(task, 'circular_trajectory_tracking')
    if (~strcmpi(controller, 'CT') && ~strcmpi(controller, 'BS') && ~strcmpi(controller, 'Kinematic_LevMar'))
        error('Controller: choose ''CT'', ''BS'' or Kinematic_LevMar controller instead.')
    end
    circular_trajectory_tracking
elseif strcmpi(task, 'position_control')
    if (~strcmpi(controller, 'Kinematic_grad') && ~strcmpi(controller, 'Kinematic_LevMar'))
        error('Controller: choose ''Kinematic_grad'' or ''Kinematic_LevMar'' controller instead.')
    end
else
    error('Invalid task.');
end



%% Controller
if (strcmpi(controller, 'Kinematic_grad') || strcmpi(controller, 'Kinematic_LevMar'))
    Kinematic
elseif strcmpi(controller, 'PD')
    PD
elseif strcmpi(controller, 'CT')
    CT
elseif strcmpi(controller, 'BS')
    BS
else
    error('Invalid controller type. Possible values: ''Kinematic_grad'', ''Kinematic_LevMar'', ''PD'', ''CT'', or ''BS''.');
end



%% Plot
plot_Simulation
