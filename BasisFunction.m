function [value] = BasisFunction(i, d, t, knots)
    if d == 0
        % Degree 0
        if knots(i) <= t && t < knots(i+1)
            value = 1.0;
        else
            value = 0.0;
        end
        return;
    end
    
    % Recursive computation
    left = 0.0;
    if knots(i+d) > knots(i)
        left = (t - knots(i)) / (knots(i+d) - knots(i)) * BasisFunction(i, d-1, t, knots);
    end
    
    right = 0.0;
    if knots(i+d+1) > knots(i+1)
        right = (knots(i+d+1) - t) / (knots(i+d+1) - knots(i+1)) * BasisFunction(i+1, d-1, t, knots);
    end
    
    value = left + right;
end
