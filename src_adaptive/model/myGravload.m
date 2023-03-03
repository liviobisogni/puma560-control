function G_out = myGravload(q, parms)

    % https://github.com/cdsousa/SymPyBotics
    
    %% Denavit-Hartenberg
    a2 = 0.4318;    a3 = 0.0203;
    d3 = 0.15005;   d4 = 0.4318;

    %% Variabili di giunto
    % q1 = q(1);  dq1 = dq(1);   ddq1 = ddq(1);
    % q2 = q(2);  dq2 = dq(2);   ddq2 = ddq(2);
    % q3 = q(3);  dq3 = dq(3);   ddq3 = ddq(3);
    % q4 = q(4);  dq4 = dq(4);   ddq4 = ddq(4);
    % q5 = q(5);  dq5 = dq(5);   ddq5 = ddq(5);
    % q6 = q(6);  dq6 = dq(6);   ddq6 = ddq(6);

    %% parms
    % (L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, L_4xx, L_4xy, L_4xz, L_4yy, L_4yz, L_4zz, l_4x, l_4y, l_4z, m_4, L_5xx, L_5xy, L_5xz, L_5yy, L_5yz, L_5zz, l_5x, l_5y, l_5z, m_5, L_6xx, L_6xy, L_6xz, L_6yy, L_6yz, L_6zz, l_6x, l_6y, l_6z, m_6)
    % Where:
    %   L is the link inertia tensor computed about the link frame;
    %   l is the link first moment of inertia;
    %   m is the link mass.
    % These are the so-called barycentric parameters, with respect to which the dynamic model is linear.


    x0 = sin(q(2));
    x1 = sin(q(4));
    x2 = d4*x1;
    x3 = cos(q(4));
    x4 = 9.8100000000000005*x0;
    x5 = cos(q(3));
    x6 = cos(q(2));
    x7 = 9.8100000000000005*x6;
    x8 = sin(q(3));
    x9 = x4*x5 + x7*x8;
    x10 = x3*x9;
    x11 = cos(q(5));
    x12 = -x8;
    x13 = x12*x4 + x5*x7;
    x14 = sin(q(5));
    x15 = x10*x11 + x13*x14;
    x16 = cos(q(6));
    x17 = x1*x9;
    x18 = -x17;
    x19 = sin(q(6));
    x20 = x15*x16 + x18*x19;
    x21 = parms(60)*x20;
    x22 = -x19;
    x23 = x15*x22 + x16*x18;
    x24 = parms(60)*x23;
    x25 = parms(50)*x15 + x16*x21 + x22*x24;
    x26 = -x14;
    x27 = x10*x26 + x11*x13;
    x28 = parms(50)*x27 + parms(60)*x27;
    x29 = parms(40)*x10 + x11*x25 + x26*x28;
    x30 = parms(58)*x27 - parms(59)*x23;
    x31 = -x27;
    x32 = parms(57)*x31 + parms(59)*x20;
    x33 = parms(48)*x27 - parms(49)*x18 + x16*x30 + x22*x32;
    x34 = -x13;
    x35 = parms(57)*x23 - parms(58)*x20;
    x36 = parms(47)*x18 - parms(48)*x15 + x35;
    x37 = parms(38)*x17 + parms(39)*x34 + x11*x33 + x26*x36;
    x38 = -parms(47)*x31 - parms(49)*x15 - x16*x32 - x19*x30;
    x39 = parms(37)*x13 - parms(38)*x10 + x38;
    x40 = d4*x3;
    x41 = parms(40)*x17 - parms(50)*x18 - x16*x24 - x19*x21;
    x42 = parms(28)*x13 + x1*x39 - x2*x29 + x3*x37 + x40*x41;
    x43 = parms(37)*x18 + parms(39)*x10 + x11*x36 + x14*x33;
    x44 = -parms(28)*x9 + x43;
    x45 = parms(30)*x9 + x1*x41 + x29*x3;
    x46 = d3*x45;
    x47 = parms(30)*x13 + parms(40)*x13 + x11*x28 + x14*x25;
    x48 = d3*x47;
    x49 = -x3;
    x50 = x1*x29 + x41*x49;
    x51 = a3*((x5)*(x5)) + a3*((x8)*(x8));
    x52 = x50*x51;
    x53 = -a2;
    x54 = -parms(27)*x34 - parms(29)*x9 - x1*x37 - x2*x41 - x29*x40 - x39*x49;

    g(1) = x0*(-parms(19)*x7 + x12*x44 + x12*x46 + x12*x52 + x42*x5 - x48*x5) - x50*x6*(((x0)*(x0))*x53 + x53*((x6)*(x6))) + x6*(parms(19)*x4 + x12*x48 + x42*x8 + x44*x5 + x46*x5 + x5*x52);
    g(2) = a2*(parms(20)*x7 + x45*x8 + x47*x5) + parms(17)*x7 - parms(18)*x4 + x47*x51 + x54;
    g(3) = a3*x47 + x54;
    g(4) = x43;
    g(5) = x38;
    g(6) = x35;


    G_out = g;

end
