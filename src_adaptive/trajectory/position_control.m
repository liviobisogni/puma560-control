
% Desired joint positions
qf = [pi/2 pi/3 pi/4 -pi/4 -pi/3 -pi/2];
q_des = qf .* ones(length(time),6);

% Desired joint velocities
q_vel_des = zeros(length(time),6);

% Desired joint accelerations
q_acc_des = zeros(length(time),6);
