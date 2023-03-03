
% Parametri circonferenza
radius = 0.1;                                   % [m]
center = [0.5 0 0];                             % [m]

% Posizione End-Effector nello spazio operativo (cartesiano)
Cercle = circle(center, radius, 'n', length(time));

T = transl(Cercle');
for i=1:size(T,3)
    T(:,:,i) = T(:,:,i)*trotx(pi);
end
% Configurazioni robot target lungo la traiettoria target
q_des = p560.ikine6s(T,'ru');

if isnan(q_des) ~= zeros(size(q_des))
    error('Traiettoria non raggiungibile')
end

% Velocità giunti target lungo la traiettoria
q_vel_des(1,:) = zeros(1,6);
for i = 1:1:timeSpan/timeStep
    q_vel_des(i+1,:) = (q_des(i+1,:) - q_des(i,:))/timeStep;
end

% Accelerazione giunti target
q_acc_des(1,:) = zeros(1,6);
for i = 1:1:timeSpan/timeStep
    q_acc_des(i+1,:) = (q_vel_des(i+1,:) - q_vel_des(i,:))/timeStep;
end

ee_pos = transl(p560.fkine(q_des))';

q0 = q_des(1,:);
