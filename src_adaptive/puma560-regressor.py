import sympy
import sympybotics


pi = sympy.pi
q = sympybotics.robotdef.q

a2, a3, d3, d4 = sympy.symbols('a2, a3, d3, d4')

# 6R parametric
puma560_def = sympybotics.RobotDef('Puma 560 Robot',
                                   [('pi/2', 0, 0, 'q'),
                                    (0, 'a2', 0, 'q'),
                                    ('-pi/2', 'a3', 'd3', 'q'),
                                    ('pi/2', 0, 'd4', 'q'),
                                    ('-pi/2', 0, 0, 'q'),
                                    (0, 0, 0, 'q')],
                                   dh_convention='standard')

# # 6R real
# puma560_def = sympybotics.RobotDef('Puma 560 Robot',
#                                    [('pi/2', 0, 0, 'q'),
#                                     (0, 0.4318, 0, 'q'),
#                                     ('-pi/2', 0.0203, 0.15005, 'q'),
#                                     ('pi/2', 0, 0.4318, 'q'),
#                                     ('-pi/2', 0, 0, 'q'),
#                                     (0, 0, 0, 'q')],
#                                    dh_convention='standard')


puma560_def.frictionmodel = None
# puma560_def.frictionmodel = {'Coulomb', 'viscous', 'offset'}  # options are None or a combination of 'Coulomb', 'viscous' and 'offset'
puma560_def.gravityacc = sympy.Matrix([0.0, 0.0, -9.81])
puma560 = sympybotics.RobotDynCode(puma560_def)

# Regressor
W_Regressor = sympybotics.robotcodegen.robot_code_to_func(
    'C', puma560.H_code, 'H', 'H_puma560', puma560_def)
print(W_Regressor)

# Parameters
# parms contains the numerical standard dynamic parameters ordered according to rbtdef.dynparms()
parms = puma560_def.dynparms()
print(parms)

# Coriolis matrix
C_func_def = sympybotics.robotcodegen.robot_code_to_func(
        'C', puma560.C_code, 'C', 'C_puma560', puma560_def)
print(C_func_def)

# Inertia matrix
M_func_def = sympybotics.robotcodegen.robot_code_to_func(
    'C', puma560.M_code, 'M', 'M_puma560', puma560_def)
print(M_func_def)

# Gravity term
g_func_def = sympybotics.robotcodegen.robot_code_to_func(
    'C', puma560.g_code, 'g', 'g_puma560', puma560_def)
print(g_func_def)
