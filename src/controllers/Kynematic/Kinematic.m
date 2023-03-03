puma560_RoboticsSystemToolbox


if strcmpi(controller, 'Kinematic_grad')
    K = 1 * eye(6);
elseif strcmpi(controller, 'Kinematic_LevMar')
    if strcmpi(task, 'controllo_di_posizione')
        K = 1 * eye(6);
        mu0 = 1/1000;
    elseif strcmpi(task, 'traiettoria_circolare')
        K = 20 * eye(6);
        mu0 = 1/1000;
    end
end


%% Lancio la Simulazione
if strcmpi(controller, 'Kinematic_grad')
    if strcmpi(task, 'controllo_di_posizione')
        model = "Simulation_Kinematic_grad_ConDiPos";
    else
        error('Choose ''controllo_di_posizione'' task instead.')
    end
elseif strcmpi(controller, 'Kinematic_LevMar')
    if strcmpi(task, 'controllo_di_posizione')
        model = "Simulation_Kinematic_LevMar_ConDiPos";
    elseif strcmpi(task, 'traiettoria_circolare')
        model = "Simulation_Kinematic_LevMar_InsDiMov";
    else
        error('Choose ''controllo_di_posizione'' or ''traiettoria_circolare'' task instead.')
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
