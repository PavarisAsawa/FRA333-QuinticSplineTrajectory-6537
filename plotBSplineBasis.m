function plotBSplineBasis(knot, degree)

    n = length(knot) - degree - 1;
    x = linspace(knot(degree+1), knot(end-degree), 500);
    figure;
    hold on;

    for i = 1:n
        B = zeros(size(x));
        for j = 1:length(x)
            B(j) = BasisFunction(i, degree, x(j), knot);
        end
        plot(x, B, 'LineWidth', 2);
    end
    
    xlabel('x');
    ylabel('Basis Function Value');
    title(['B-Spline Basis Functions (Degree = ' num2str(degree) ')']);
    grid on;
    hold off;
end