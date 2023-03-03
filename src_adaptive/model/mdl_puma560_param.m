function [p560, p560_est]= mdl_puma560_param(est_m1, est_m2, est_m3, est_m4, est_m5, est_m6)


%% All parameters are in SI units: m, radians, kg, kg.m2, N.m, N.m.s etc.

%% Link 1 modeling
% DH parameter
mdl_d1 = 0;                                 % link length (Dennavit-Hartenberg notation)       
mdl_a1 = 0;                                 % link offset (Dennavit-Hartenberg notation)       
mdl_alpha1 = pi/2;                          % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I1 = [0, 0.35, 0, 0, 0, 0];             % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r1 = [0, 0, 0];                         % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m1 = 0;                                 % mass of link
% est_m1 = 0;                              % mass of link estimated
% mdl_Jm1 = 200e-6;                           % actuator inertia
% mdl_G1 = -62.6111;                          % gear ratio

%% Link 2 modeling
% DH parameter
mdl_d2 = 0;                                 % link length (Dennavit-Hartenberg notation)       
mdl_a2 = 0.4318;                            % link offset (Dennavit-Hartenberg notation)       
mdl_alpha2 = 0;                             % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I2 = [0.13, 0.524, 0.539, 0, 0, 0];     % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r2 = [-0.3638, 0.006, 0.2275];          % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m2 = 17.4;                              % mass of link
% est_m2 = 17.4;                              % mass of link estimated
% mdl_Jm2 = 200e-6;                           % actuator inertia
% mdl_G2 = 107.815;                           % gear ratio

%% Link 3 modeling
% DH parameter
mdl_d3 = 0.15005;                           % link length (Dennavit-Hartenberg notation)       
mdl_a3 = 0.0203;                            % link offset (Dennavit-Hartenberg notation)       
mdl_alpha3 = -pi/2;                         % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I3 = [0.066, 0.086, 0.0125, 0, 0, 0];   % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r3 = [-0.0203, -0.0141, 0.070];         % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m3 = 4.8;                               % mass of link
% est_m3 = 4.8;                              % mass of link estimated
% mdl_Jm3 = 200e-6;                           % actuator inertia
% mdl_G3 = -53.7063;                          % gear ratio


%% Link 4 modeling
% DH parameter
mdl_d4 = 0.4318;                            % link length (Dennavit-Hartenberg notation)       
mdl_a4 = 0;                                 % link offset (Dennavit-Hartenberg notation)       
mdl_alpha4 = pi/2;                          % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I4 = [1.8e-3, 1.3e-3, 1.8e-3, 0, 0, 0]; % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r4 = [0, 0.019, 0];                     % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m4 = 0.82;                              % mass of link
% est_m4 = 0.82;                              % mass of link estimated
% mdl_Jm1 = 200e-6;                           % actuator inertia
% mdl_G1 = -62.6111;                          % gear ratio

%% Link 5 modeling
% DH parameter
mdl_d5 = 0;                                 % link length (Dennavit-Hartenberg notation)       
mdl_a5 = 0;                                 % link offset (Dennavit-Hartenberg notation)       
mdl_alpha5 = -pi/2;                         % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I5 = [0.3e-3, 0.4e-3, 0.3e-3, 0, 0, 0]; % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r5 = [0, 0, 0];                         % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m5 = 0.34;                              % mass of link
% est_m5 = 0.34;                              % mass of link estimated
% mdl_Jm2 = 200e-6;                           % actuator inertia
% mdl_G2 = 107.815;                           % gear ratio

%% Link 6 modeling
% DH parameter
mdl_d6 = 0;                                 % link length (Dennavit-Hartenberg notation)       
mdl_a6 = 0;                                 % link offset (Dennavit-Hartenberg notation)       
mdl_alpha6 = 0;                             % link twist (Dennavit-Hartenberg notation)       
% 
mdl_I6 = [0.15e-3, 0.15e-3, 0.04e-3, 0, 0, 0];  % inertia tensor of link with respect to center of mass I = [L_xx, L_yy, L_zz, L_xy, L_yz, L_xz]
mdl_r6 = [0, 0, 0.032];                     % distance of ith origin to center of mass [x,y,z] in link reference frame
mdl_m6 = 0.09;                              % mass of link
% est_m6 = 0.09;                              % mass of link estimated
% mdl_Jm3 = 200e-6;                           % actuator inertia
% mdl_G3 = -53.7063;                          % gear ratio


%% Some useful poses
qz = [0 0 0 0 0 0];         % zero joint angle configuration (zero angles, L shaped pose)
qr = [0 pi/2 -pi/2 0 0 0];  % vertical 'READY' configuration (ready pose, arm up)
qs = [0 0 -pi/2 0 0 0];     % arm is stretched out in the X direction
qn = [0 pi/4 pi 0 pi/4  0]; % arm is at a nominal non-singular configuration


%% Costruisco oggetti Link "teorici"
L(1) = Revolute('d', mdl_d1, 'a', mdl_a1, 'alpha', mdl_alpha1, ...
                'I', mdl_I1,'r', mdl_r1, 'm', mdl_m1); % 'Jm', mdl_Jm1, 'G', mdl_G1 ); 
L(2) = Revolute('d', mdl_d2, 'a', mdl_a2, 'alpha', mdl_alpha2, ...
                'I', mdl_I2,'r', mdl_r2, 'm', mdl_m2); % 'Jm', mdl_Jm2, 'G', mdl_G2 ); 
L(3) = Revolute('d', mdl_d3, 'a', mdl_a3, 'alpha', mdl_alpha3, ...
                'I', mdl_I3,'r', mdl_r3, 'm', mdl_m3); % 'Jm', mdl_Jm3, 'G', mdl_G3 ); 
L(4) = Revolute('d', mdl_d4, 'a', mdl_a4, 'alpha', mdl_alpha4, ...
                'I', mdl_I4,'r', mdl_r4, 'm', mdl_m4); % 'Jm', mdl_Jm4, 'G', mdl_G4 ); 
L(5) = Revolute('d', mdl_d5, 'a', mdl_a5, 'alpha', mdl_alpha5, ...
                'I', mdl_I5,'r', mdl_r5, 'm', mdl_m5); % 'Jm', mdl_Jm5, 'G', mdl_G5 ); 
L(6) = Revolute('d', mdl_d6, 'a', mdl_a6, 'alpha', mdl_alpha6, ...
                'I', mdl_I6,'r', mdl_r6, 'm', mdl_m6); % 'Jm', mdl_Jm6, 'G', mdl_G6 );

%mdl_p560
p560 = SerialLink(L, 'name', 'Puma 560', ...
    'configs', {'qz', qz, 'qr', qr, 'qs', qs, 'qn', qn}, ...
    'manufacturer', 'Unimation', 'ikine', 'puma', 'comment', 'params of 8/95');

p560 = nofriction(p560, 'all');


%% Costruisco oggetti Link "stimati"
L_est(1) = Revolute('d', mdl_d1, 'a', mdl_a1, 'alpha', mdl_alpha1, ...
                    'I', mdl_I1,'r', mdl_r1, 'm', est_m1); % 'Jm', mdl_Jm1, 'G', mdl_G1 ); 
L_est(2) = Revolute('d', mdl_d2, 'a', mdl_a2, 'alpha', mdl_alpha2, ...
                    'I', mdl_I2,'r', mdl_r2, 'm', est_m2); % 'Jm', mdl_Jm2, 'G', mdl_G2 ); 
L_est(3) = Revolute('d', mdl_d3, 'a', mdl_a3, 'alpha', mdl_alpha3, ...
                    'I', mdl_I3,'r', mdl_r3, 'm', est_m3); % 'Jm', mdl_Jm3, 'G', mdl_G3 ); 
L_est(4) = Revolute('d', mdl_d4, 'a', mdl_a4, 'alpha', mdl_alpha4, ...
                    'I', mdl_I4,'r', mdl_r4, 'm', est_m4); % 'Jm', mdl_Jm4, 'G', mdl_G4 ); 
L_est(5) = Revolute('d', mdl_d5, 'a', mdl_a5, 'alpha', mdl_alpha5, ...
                    'I', mdl_I5,'r', mdl_r5, 'm', est_m5); % 'Jm', mdl_Jm5, 'G', mdl_G5 ); 
L_est(6) = Revolute('d', mdl_d6, 'a', mdl_a6, 'alpha', mdl_alpha6, ...
                    'I', mdl_I6,'r', mdl_r6, 'm', est_m6); % 'Jm', mdl_Jm6, 'G', mdl_G6 );


p560_est = SerialLink(L_est, 'name', 'Puma 560', ...
    'configs', {'qz', qz, 'qr', qr, 'qs', qs, 'qn', qn}, ...
    'manufacturer', 'Unimation', 'ikine', 'puma', 'comment', 'params of 8/95');

p560_est = nofriction(p560_est, 'all');


% mdl_p560.model3d = 'UNIMATE/puma560';

clear L
clear qz qr qs qn
clear mdl_d1 mdl_a1 mdl_alpha1 mdl_I1 mdl_r1 mdl_m1
clear mdl_d2 mdl_a2 mdl_alpha2 mdl_I2 mdl_r2 mdl_m2
clear mdl_d3 mdl_a3 mdl_alpha3 mdl_I3 mdl_r3 mdl_m3
clear mdl_d4 mdl_a4 mdl_alpha4 mdl_I4 mdl_r4 mdl_m4
clear mdl_d5 mdl_a5 mdl_alpha5 mdl_I5 mdl_r5 mdl_m5
clear mdl_d6 mdl_a6 mdl_alpha6 mdl_I6 mdl_r6 mdl_m6

end