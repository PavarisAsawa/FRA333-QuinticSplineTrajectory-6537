function jointConfig = UR5InverseKinematics(ur5, targetTranslation, currentJointAngles)
    % UR5InverseKinematics: คำนวณมุมข้อต่อสำหรับ UR5 เพื่อให้ปลายแขนไปยังตำแหน่งที่ต้องการ
    %
    % Inputs:
    %   - ur5: โมเดลหุ่นยนต์ UR5 (สร้างจาก loadrobot)
    %   - targetTranslation: ตำแหน่ง [x, y, z] ที่ต้องการของปลายแขน
    %   - currentJointAngles: มุมข้อต่อปัจจุบันในรูปแบบ struct (จาก homeConfiguration)
    %
    % Outputs:
    %   - jointConfig: มุมข้อต่อของ UR5 ที่ทำให้ปลายแขนอยู่ใน targetTranslation

    ik = inverseKinematics('RigidBodyTree', ur5);
    targetPose = trvec2tform(targetTranslation);

    endEffector = 'tool0';
    weights = [0 0 0 1 1 1];
    [configSol, solInfo] = ik(endEffector, targetPose, weights, currentJointAngles);
    if solInfo.Status == "success"
        jointConfig = configSol;
    else
        error('IK solver failed to find a solution.');
    end
end
