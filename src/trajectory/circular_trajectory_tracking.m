% Circle parameters
radius = 0.1;                                   % [m]
center = [0.5 0 0];                             % [m]

% End-Effector position in operational space (cartesian)
Cercle = circle(center, radius, 'n', length(time));

T = transl(Cercle');
for i=1:size(T,3)
    T(:,:,i) = T(:,:,i)*trotx(pi);
end

% Target robot configurations along the target trajectory
q_des = p560.ikine6s(T,'ru');

% Check if the trajectory is reachable
if isnan(q_des) ~= zeros(size(q_des))
    error('Trajectory not reachable')
end

% Target joint velocities along the trajectory
q_vel_des(1,:) = zeros(1,6);
for i = 1:1:timeSpan/timeStep
    q_vel_des(i+1,:) = (q_des(i+1,:) - q_des(i,:))/timeStep;
end

% Target joint accelerations
q_acc_des(1,:) = zeros(1,6);
for i = 1:1:timeSpan/timeStep
    q_acc_des(i+1,:) = (q_vel_des(i+1,:) - q_vel_des(i,:))/timeStep;
end

% End-Effector positions
ee_pos = transl(p560.fkine(q_des))';

% Initial joint configuration
q0 = q_des(1,:);
