%% Traditional Pick and Place
% Punto iniziale/finale per P&P (configurazione di giunto)
q0 = [0         pi/4    pi  0   pi/4    pi/2];              % posizione di start and place
qf = [3*pi/4    pi/4    pi  0   pi/4    pi/2];              % posizione del pick

% Pick&Place
q_des = [repmat(qf,(length(time)-1)/2,1); repmat(q0,(length(time)+1)/2,1) ];
q_vel_des = zeros(length(time),6);
q_acc_des = zeros(length(time),6);
ee_pos = transl(p560.fkine(q_des))';
