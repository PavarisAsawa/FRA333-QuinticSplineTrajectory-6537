function [value] = BasisFunctionDerivative(i, d, t, knots)
    % คำนวณอนุพันธ์ของ Basis Function
    
    % ถ้า degree = 0 ไม่มีอนุพันธ์ (ค่าคงที่)
    if d == 0
        value = 0; % Degree 0 ไม่มีอนุพันธ์
        return;
    end
    
    % คำนวณส่วนแรกของสมการ
    left = 0.0;
    if knots(i+d) > knots(i)
        left = (1 / (knots(i+d) - knots(i))) * BasisFunction(i, d-1, t, knots);
    end
    
    % คำนวณส่วนที่สองของสมการ
    right = 0.0;
    if knots(i+d+1) > knots(i+1)
        right = -(1 / (knots(i+d+1) - knots(i+1))) * BasisFunction(i+1, d-1, t, knots);
    end
    
    % รวมค่าทั้งสองส่วน
    value = left + right;
end
