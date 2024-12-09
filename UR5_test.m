ur5 = loadrobot("universalUR5");
q = homeConfiguration(ur5);
initial_pos = tform2trvec(getTransform(ur5, q, 'tool0'));
control_points1 = [
    initial_pos; % ตำแหน่งปัจจุบัน
    0.0, 0.2, 0.0;
    0.1, 0.5, 0.3;
    0.2, 0.2, 0.2;
    0.2, 0.1, 0.3;
    0.1, 0.8, 0.2;
    0.3, 0.3, 0.1;
];

control_points1 = [
    initial_pos; % ตำแหน่งปัจจุบัน
    0.0, 0.2, 0.0;
    0.1, 0.5, 0.3;
    0.2, 0.2, 0.2;
    0.2, 0.1, 0.3;
    0.1, 0.8, 0.2;
    0.3, 0.3, 0.1;
];

control_points2 = [
    initial_pos; % ตำแหน่งปัจจุบัน
    0.1, 0.2, 0.0;
    0.2, 0.5, 0.4;
    0.0, 0.8, 0.1;
    0.2, 0.2, 0.5;
];

control_points3 = [
    initial_pos; % ตำแหน่งปัจจุบัน
    0.0, 0.2, 0.0;
    0.1, 0.5, 0.3;
    0.0, 0.8, 0.1;
    0.1, 0.2, 0.2;
    0.8, 0.1, 0.3;
    0.2, 0.3, 0.5;
    0.8, 0.2, 0.1;
];

ExecuteTrajectory(ur5,control_points,5,1,q);
% ExecuteTrajectory(ur5,control_points1,5,3,q);
% ExecuteTrajectory(ur5,control_points1,5,1,q);