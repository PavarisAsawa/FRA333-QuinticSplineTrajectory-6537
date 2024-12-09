function [knots] = KnotGenerator(control_points, t_start, t_end, degree)
    % Number of control points
    num_control_points = size(control_points, 1);

    % Order of B-Spline
    order = degree + 1;

    num_knots = num_control_points + order;
    
    first_knots = repmat(t_start, 1, degree);
    last_knots = repmat(t_end, 1, degree);
    middle_knots = linspace(t_start, t_end, num_knots - 2 * degree);

    % Combine all parts to form the final knot vector
    knots = [first_knots  middle_knots last_knots];
end
