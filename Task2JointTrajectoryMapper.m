function [joint_traj] = Task2JointTrajectoryMapper(ur5,trajectory,initialGuess)
    joint_traj = [];
    for i = 1:size(trajectory, 1)
        % ดึงตำแหน่งในแต่ละแถว
        targetPoint = trajectory(i, :); 
        jointConfig = UR5InverseKinematics(ur5, targetPoint, initialGuess);
        joint_traj = [joint_traj; arrayfun(@(x) x.JointPosition, jointConfig)];
        % อัปเดต Initial Guess
        initialGuess = jointConfig;
    end

end