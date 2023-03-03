%% Guadagni Controllore
K_d    = 100 * diag([1 1 1 1 1 1]);                     % x = K_d * e_vel(t)
Lambda = 10 * eye(6);

% Saturazione Massima controllori
max_tau = 100 * [1 1 1 1 1 1];                          % [Nm]


%% Lancio la Simulazione
tic
model = "Simulation_BS";
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
