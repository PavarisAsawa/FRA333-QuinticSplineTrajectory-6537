function [position] = UR5ForwardKinematics(ur5, q)
    % UR5ForwardKinematics: คำนวณตำแหน่งปลายแขนจากมุมข้อต่อ (struct)
    %
    % Inputs:
    %   - ur5: โมเดลหุ่นยนต์ UR5
    %   - q: Joint Configuration (struct)
    %
    % Outputs:
    %   - position: ตำแหน่ง [x, y, z] ของปลายแขน (End-Effector)

    tform = getTransform(ur5, q, 'tool0');
    position = tform2trvec(tform);
end
