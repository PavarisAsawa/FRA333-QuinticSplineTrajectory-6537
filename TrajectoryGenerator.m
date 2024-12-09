function [trajectory, velocity] = TrajectoryGenerator(control_points ,t_use , degree)
    % Parameters
    dt = 0.05; % Time step
    t_start = 0.0;
    t_end = t_use; % เวลาสิ้นสุด

    % สร้าง Knot Vector
    knots = KnotGenerator(control_points, t_start, t_end, degree)
    if isempty(knots)
        error('Failed to generate knots.');
    end

    % เวลาทั้งหมด
    t_steps = t_start:dt:t_end;
    trajectory = [];
    velocity = [];
    basis =[];
    % ต้อง Loop ทุก t เพราะ Basis Function อาจจะมีผลกับ time step ถัดไป
    for t = t_steps
        C_t = zeros(1, size(control_points, 2)); % เริ่มต้นตำแหน่ง
        C_t_dot = zeros(1, size(control_points, 2)); % เริ่มต้นความเร็ว
        for i = 1:size(control_points, 1)
            N_i_d = BasisFunction(i, degree, t, knots); 
            N_i_d_dot = BasisFunctionDerivative(i, degree, t, knots);
            if t == t_use
                C_t = control_points(i, :);
            else
                C_t = C_t + N_i_d * control_points(i, :);      % ตำแหน่ง
                C_t_dot = C_t_dot + N_i_d_dot * control_points(i, :); % ความเร็ว
            end
        end
        basis = [basis N_i_d];
        trajectory = [trajectory; C_t];
        velocity = [velocity; C_t_dot];
    end
end
