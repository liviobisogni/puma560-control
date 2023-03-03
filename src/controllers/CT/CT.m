%% Guadagni Controllore
K_p = 100 * diag([1 1 1 1 1 1]);
K_d = 30 * diag([1 1 1 1 1 1]);

% Saturazione Massima controllori
max_tau = 100 * [1 1 1 1 1 1];                          % [Nm]


%% Lancio la Simulazione
tic
model = "Simulation_CT";
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
