% Load symbolic package
pkg load symbolic

% Force gnuplot renderer
graphics_toolkit('gnuplot');

% Step 1: Define data points
x_vals = [0, 2, 3, 4];
y_vals = [7, 11, 28, 63];

% Step 2: Define the interpolating polynomial
P = @(x) x.^3 - 2*x + 7;

% Step 3: Save verification to text file
filename = 'lagrange_verification.txt';
fid = fopen(filename, 'w');
if fid == -1
    error('Could not open file for writing.');
endif

fprintf(fid, 'Verifying original data points:\n');
disp('Verifying original data points:');
for i = 1:length(x_vals)
    y_interp = P(x_vals(i));
    fprintf(fid, 'P(%d) = %.2f (Expected: %.2f)\n', x_vals(i), y_interp, y_vals(i));
    fprintf('P(%d) = %.2f (Expected: %.2f)\n', x_vals(i), y_interp, y_vals(i));
end
fclose(fid);
fprintf('Verification saved to: %s\n', filename);

% Step 4: Plot and save to file
x_range = linspace(min(x_vals) - 1, max(x_vals) + 1, 200);
y_range = P(x_range);

% Create visible figure using gnuplot
figure(1, 'visible', 'on');
plot(x_range, y_range, 'b-', 'LineWidth', 2); hold on;
plot(x_vals, y_vals, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
grid on;
xlabel('x');
ylabel('P(x)');
title('Lagrange Interpolating Polynomial');
legend('Interpolating Polynomial', 'Data Points');

% Pause to allow gnuplot to render properly before saving
pause(1);

% Save figure
print('lagrange_polynomial_plot.png', '-dpng');
fprintf('Plot saved as lagrange_polynomial_plot.png in directory: %s\n', pwd);
