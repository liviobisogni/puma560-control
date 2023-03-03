% # Manipulator Link
n = p560.n;                                             % #Links

% Matrici di design
K_p = 50 * eye(n);
K_v = 10 * eye(n);
R   = 10 * eye(n * 10);
Q   = 1 * eye(n + n);


A = [zeros(n) eye(n); ...
     -K_p     -K_v];

B = [zeros(n); ...
     eye(n)];

P = lyap(A',Q);


% Saturazione controllori
max_tau = 100 * [1 1 1 1 1 1];                          % [Nm]


%% Lancio la Simulazione
tic
model = "adaptiveCT";
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
