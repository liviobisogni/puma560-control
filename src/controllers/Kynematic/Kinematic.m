puma560_RoboticsSystemToolbox


if strcmpi(controller, 'Kinematic_grad')
    K = 1 * eye(6);
elseif strcmpi(controller, 'Kinematic_LevMar')
    if strcmpi(task, 'position_control')
        K = 1 * eye(6);
        mu0 = 1/1000;
    elseif strcmpi(task, 'circular_trajectory_tracking')
        K = 20 * eye(6);
        mu0 = 1/1000;
    end
end


%% Lancio la Simulazione
if strcmpi(controller, 'Kinematic_grad')
    if strcmpi(task, 'position_control')
        model = "Simulation_Kinematic_grad_ConDiPos";
    else
        error('Choose ''position_control'' task instead.')
    end
elseif strcmpi(controller, 'Kinematic_LevMar')
    if strcmpi(task, 'position_control')
        model = "Simulation_Kinematic_LevMar_ConDiPos";
    elseif strcmpi(task, 'circular_trajectory_tracking')
        model = "Simulation_Kinematic_LevMar_InsDiMov";
    else
        error('Choose ''position_control'' or ''circular_trajectory_tracking'' task instead.')
    end
else
    error('Choose ''Kinematic_grad'' or ''Kinematic_LevMar'' controller instead.')
end

tic
simIn = Simulink.SimulationInput(model);
simIn = setModelParameter(simIn,"StopTime","timeSpan");
% Simulate the model using accelerator mode.
simIn = setModelParameter(simIn,"SimulationMode","accelerator");
out = sim(simIn);
toc

% Access the timing information for the first rapid accelerator simulation.
% Then, extract the initialization time, execution time, and total elapsed time for the simulation.
rapidAccel = out.SimulationMetadata.TimingInfo
rapidBuildInit = rapidAccel.InitializationElapsedWallTime;
rapidBuildExec = rapidAccel.ExecutionElapsedWallTime;
rapidBuildTotal = rapidAccel.TotalElapsedWallTime;
