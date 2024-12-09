function [flag] = checkIKForTrajectory(ur5, trajectory, initialGuess)
    % checkIKForTrajectory: ตรวจสอบว่าแต่ละจุดใน trajectory สามารถแก้ IK ได้หรือไม่
    %
    % Inputs:
    %   - ur5: โมเดลหุ่นยนต์ UR5 (สร้างจาก loadrobot)
    %   - trajectory: Trajectory ของจุดตำแหน่ง [x, y, z] ที่ต้องการ
    %   - initialGuess: มุมข้อต่อปัจจุบันในรูปแบบ struct (จาก homeConfiguration)

    % ตรวจสอบแต่ละจุดใน trajectory
    flag = true;
    for i = 1:size(trajectory, 1)
        targetPoint = trajectory(i, :); % จุดเป้าหมายปัจจุบัน
        try
            % คำนวณ IK
            jointConfig = UR5InverseKinematics(ur5, targetPoint, initialGuess);
            initialGuess = (jointConfig);
        catch ME
            fprintf('Point %d: IK solution failed. Reason: %s\n', i, ME.message);
            flag = false;
            break;
        end
    end
end
