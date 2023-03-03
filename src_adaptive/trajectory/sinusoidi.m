
% Posizioni giunti desiderate
q_des = zeros(length(time),6);
% Velocità giunti desiderate
q_vel_des = zeros(length(time),6);
% Accelerazione giunti desiderate
q_acc_des = zeros(length(time),6);


A(1) = pi/2;
A(2) = pi/3;
A(3) = pi/4;
A(4) = -pi/4;
A(5) = -pi/3;
A(6) = -pi/2;

omega(1) = 1;
omega(2) = 1;
omega(3) = 1;
omega(4) = 1;
omega(5) = 1;
omega(6) = 1;

phi(1) = 0;
phi(2) = 0;
phi(3) = 0;
phi(4) = 0;
phi(5) = 0;
phi(6) = 0;

offset(1) = 0;
offset(2) = 0;
offset(3) = 0;
offset(4) = 0;
offset(5) = 0;
offset(6) = 0;


for i = 1 : length(time)
    for j = 1 : 6
        q_des(i,j) = offset(j) + A(j) * cos(omega(j) * time(i) + phi(j));
        q_vel_des(i,j) = -A(j) * omega(j) * sin(omega(j) * time(i) + phi(j));
        q_acc_des(i,j) = -A(j) * omega(j)^2 * cos(omega(j) * time(i) + phi(j));
    end
end


q_vel_des(1,:) = [0 0 0 0 0 0];
q_acc_des(1,:) = [0 0 0 0 0 0];
