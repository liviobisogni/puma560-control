

% Specify the parameters for the Puma560 robot [1] as a matrix
%   [1] Corke, P. I., and B. Armstrong-Helouvry. “A Search for Consensus Among Model Parameters Reported for the PUMA 560 Robot.” Proceedings of the 1994 IEEE International Conference on Robotics and Automation, 1608–13. San Diego, CA, USA: IEEE Comput. Soc. Press, 1994. https://doi.org/10.1109/ROBOT.1994.351360.
dhparams = [0   	pi/2	0   	0;
            0.4318	0       0       0
            0.0203	-pi/2	0.15005	0;
            0   	pi/2	0.4318	0;
            0       -pi/2	0   	0;
            0       0       0       0];
        
        
% Create a rigid body tree object
% robot = rigidBodyTree;
robot_p560 = rigidBodyTree('DataFormat', 'row');


% Create a cell array for the rigid body object, and another for the joint objects.
% Iterate through the DH parameters performing this process:
%   1) Create a rigidBody object with a unique name.
%   2) Create and name a revolute rigidBodyJoint object.
%   3) Use setFixedTransform to specify the body-to-body transformation of the joint using DH parameters.
%      The function ignores the final element of the DH parameters, theta, because the angle of the body is dependent on the joint position.
%   4) Use addBody to attach the body to the rigid body tree.
bodies = cell(6,1);
joints = cell(6,1);
for i = 1:6
    bodies{i} = rigidBody(['body' num2str(i)]);
    joints{i} = rigidBodyJoint(['jnt' num2str(i)],"revolute");
    setFixedTransform(joints{i},dhparams(i,:),"dh");
    bodies{i}.Joint = joints{i};
    if i == 1 % Add first body to base
        addBody(robot_p560,bodies{i},"base")
    else % Add current body to previous body by name
        addBody(robot_p560,bodies{i},bodies{i-1}.Name)
    end
end



% % Verify that your robot has been built properly by using the showdetails or show function
% % The showdetails function lists all the bodies of the robot in the MATLAB® command window.
% % The show function displays the robot with a specified configuration (home by default).
% showdetails(robot)
% figure('Name', 'PUMA Robot Model')
% show(robot);
% 
% % Visualize the robot model to confirm its dimensions by using the interactiveRigidBodyTree object
% figure('Name', 'Interactive GUI')
% gui = interactiveRigidBodyTree(robot, 'MarkerScaleFactor', 0.5);