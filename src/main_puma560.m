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
%                   * 'controllo_di_posizione'      (for Kinematic_grad, Kinematic_LevMar)
%                   * 'pick_and_place'              (for PD, CT, BS)
%                   * 'traiettoria_circolare'       (for CT, BS, Kinematic_LevMar)
%
task = 'pick_and_place';
%%_________________________________________________________________________



%% Tempo simulazione
timeSpan = 20;                                          % [s]
timeStep = 0.01;                                        % [s]
time = [0:timeStep:timeSpan]';                          % [s]


%% Modello Puma560
mdl_puma560_simpl;    % Modello Peter Corke semplificato


% %% Variabili generali:
% q_des = [];                                             % configurazione target robot/posizione target giunti
% q_vel_des = [];                                         % velocità target giunti
% q_acc_des = [];                                         % accelerazione target giunti
% %
% q = [];                                                 % configurazione reale robot/posizione reale giunti
% q_vel = [];                                             % velocità reale giunti
% q_acc = [];                                             % accelerazione reale giunti
% %
% e = [];                                                 % errore d'inseguimento
% e_vel = [];                                             % errore in velocità
% %
% tau = [];                                               % coppia giunti




%% Configurazione iniziale manipolatore
q_vel0 = [0 0 0 0 0 0];
q_acc0 = [0 0 0 0 0 0];





%% Traiettoria
if strcmpi(task, 'pick_and_place')
    if (~strcmpi(controller, 'PD') && ~strcmpi(controller, 'CT') && ~strcmpi(controller, 'BS'))
        error('Controller: choose ''PD'', ''CT'' or ''BS'' controller instead.')
    end
    pick_and_place
elseif strcmpi(task, 'traiettoria_circolare')
    if (~strcmpi(controller, 'CT') && ~strcmpi(controller, 'BS') && ~strcmpi(controller, 'Kinematic_LevMar'))
        error('Controller: choose ''CT'', ''BS'' or Kinematic_LevMar controller instead.')
    end
    traiettoria_circolare
elseif strcmpi(task, 'controllo_di_posizione')
    if (~strcmpi(controller, 'Kinematic_grad') && ~strcmpi(controller, 'Kinematic_LevMar'))
        error('Controller: choose ''Kinematic_grad'' or ''Kinematic_LevMar'' controller instead.')
    end
else
    error('Invalid task.');
end



%% Controllore
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



%% Plotto i vari grafici
plot_Simulation
