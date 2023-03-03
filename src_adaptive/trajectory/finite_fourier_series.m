
omega = 1;                                % [Hz]      fundamental frequency


%% Parametri serie di Fourier
% Link 1
a(1,1) = 0.88;
a(1,2) = 0.26;
a(1,3) = -0.54;
a(1,4) = -0.76;
b(1,1) = -0.57;
b(1,2) = 0.26;
b(1,3) = 0.23;
b(1,4) = 0.11;

% Link 2
a(2,1) = 1.20;
a(2,2) = -0.13;
a(2,3) = 0.41;
a(2,4) = 0.21;
b(2,1) = 0.27;
b(2,2) = 0.28;
b(2,3) = -1.89;
b(2,4) = -0.29;

% Link 3
a(3,1) = 0.0008;
a(3,2) = 0.0006;
a(3,3) = 0.066;
a(3,4) = 0.11;
b(3,1) = -0.63;
b(3,2) = -0.30;
b(3,3) = 0.56;
b(3,4) = 0.17;

% Link 4
a(4,1) = -0.28;
a(4,2) = 0.41;
a(4,3) = -0.88;
a(4,4) = -0.99;
b(4,1) = 0.24;
b(4,2) = -0.067;
b(4,3) = 0.92;
b(4,4) = 0.44;

% Link 5
a(5,1) = -0.09;
a(5,2) = -0.026;
a(5,3) = -0.86;
a(5,4) = -0.22;
b(5,1) = 0.75;
b(5,2) = 0.74;
b(5,3) = 0.20;
b(5,4) = -0.44;

% Link 6
a(6,1) = -1.44;
a(6,2) = 0.19;
a(6,3) = 0.26;
a(6,4) = -1;
b(6,1) = 0.091;
b(6,2) = 1.33;
b(6,3) = 1.08;
b(6,4) = -0.54;



% Joint position offsets
q_offset(1) = 0;
q_offset(2) = 0;
q_offset(3) = 0;
q_offset(4) = 0;
q_offset(5) = 0;
q_offset(6) = 0;


% Posizioni giunti desiderate
q_des = zeros(length(time),6);
% Velocità giunti desiderate
q_vel_des = zeros(length(time),6);
% Accelerazione giunti desiderate
q_acc_des = zeros(length(time),6);

n = 6;      % # links
L = 4;      % ordine della serie di Fourier

for k = 1 : length(time)                    % istante temporale (discreto)
    t = time(k);                            % tempo [s]
    for i = 1 : n                           % indice link
        
        q_des(k,i) = q_offset(i);
        
        for l = 1 : 4                       % serie di Fourier di ordine 4
            q_des(k,i)     = q_des(k,i)     + a(i,l) / (omega * l) * sin(omega * l * t) - b(i,l) / (omega * l) * cos(omega * l * t);
            q_vel_des(k,i) = q_vel_des(k,i) + a(i,l) * cos(omega * l * t)               + b(i,l) * sin(omega * l * t);
            q_acc_des(k,i) = q_acc_des(k,i) - a(i,l) * omega * l * sin(omega * l * t)   + b(i,l) * omega * l * cos(omega * l * t);
        end
        
    end
end

q_vel_des(1,:) = [0 0 0 0 0 0];
q_acc_des(1,:) = [0 0 0 0 0 0];
