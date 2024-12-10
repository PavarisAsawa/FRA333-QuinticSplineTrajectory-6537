function [flag] = ExecuteTrajectory(ur5,control_points,t_use,degree,q)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [trajectory,velocity] = TrajectoryGenerator(control_points,t_use,degree);
    
    if checkIKForTrajectory(ur5, trajectory, q)
        disp("All Trajectory Success");
    
        % แปลง Task Trajectory เป็น Joint Trajectory
        joint_traj = Task2JointTrajectoryMapper(ur5, trajectory, q);

        v = VideoWriter('ur5_trajectory_video2', 'MPEG-4'); % ตั้งชื่อไฟล์วีดีโอ
        open(v); % เปิดการบันทึกวีดีโอ
    
        % เคลื่อนที่ตาม Trajectory
        figure;
        set(gcf, 'Position', [100, 100, 1920, 1080]);
        show(ur5, q, 'Frames', 'on', 'PreservePlot', false, 'Collisions', 'off', 'Visuals', 'on');
        hold on;
        plot3(control_points(:,1), control_points(:,2), control_points(:,3), 'ro-', 'LineWidth', 1, 'MarkerSize', 8);
        plot3(trajectory(:,1), trajectory(:,2), trajectory(:,3), '-o');
        xlabel('X'); ylabel('Y'); zlabel('Z');
        title('Generated Trajectory');
        grid on;
    
        % Loop เคลื่อนที่ตาม Joint Trajectory
        for i = 1:size(joint_traj, 1)
            % อัปเดตค่ามุมข้อต่อ
            for j = 1:numel(q)
                q(j).JointPosition = joint_traj(i, j);
            end
    
            % แสดงตำแหน่งหุ่นยนต์
            show(ur5, q, 'Frames', 'on', 'PreservePlot', false);
            frame = getframe(gcf);  % ใช้ getframe เพื่อจับภาพจาก figure ปัจจุบัน
            writeVideo(v, frame);   % เขียน frame ลงในวีดีโอ
            pause(0.01);
            flag = 1;
        end
        close(v);
    else
        disp("Some points in Trajectory failed IK.");
        flag = 0;
    end
end