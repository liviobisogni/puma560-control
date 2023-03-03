% load real and est models
est_m1 = 0.05;                                  % mass of link 1
est_m2 = 16;                                    % mass of link 2
est_m3 = 5;                                     % mass of link 3
est_m4 = 0.7;                                   % mass of link 4
est_m5 = 0.5;                                   % mass of link 5
est_m6 = 0.15;                                  % mass of link 6

[p560, p560_est] = mdl_puma560_param(est_m1, est_m2, est_m3, est_m4, est_m5, est_m6);

init_pi

% q and dq test values
q = [0.7504516826728697, 0.8395156106908136, 0.16851233582594916, 0.3849629637427072, 0.5252993946810777, 0.6701207256444748];
dq = [0.24721855939629367, 0.9805915670454258, 0.9895299755642817, 0.7861135739668947, 0.273842245476577, 0.17182358900767503];

q = [1, 2, 3, 4, 5, 6];
dq = -2 * q;


% real
C_python_real = myCoriolis(q, dq, pi_real);
C_corke_real = coriolis(p560, q, dq);
isThisZero__C_real_dq = C_python_real * dq' - C_corke_real * dq'

M_python_real = myInertia(q, pi_real);
M_corke_real = inertia(p560, q);
isThisZero__M_real = M_python_real - M_corke_real

G_python_real = myGravload(q, pi_real);
G_corke_real = gravload(p560, q);
isThisZero__G_real = G_python_real - G_corke_real


% est
C_python_est = myCoriolis(q, dq, pi_est_0);
C_corke_est = coriolis(p560_est, q, dq);
isThisZero__C_est_dq = C_python_est * dq' - C_corke_est * dq'

M_python_est = myInertia(q, pi_est_0);
M_corke_est = inertia(p560_est, q);
isThisZero__M_est = M_python_est - M_corke_est

G_python_est = myGravload(q, pi_est_0);
G_corke_est = gravload(p560_est, q);
isThisZero__G_est = G_python_est - G_corke_est
