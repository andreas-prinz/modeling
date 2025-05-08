pkg load symbolic  % Якщо використовуєм Octave

syms x
f = x^3 - 3*x^2 + 10;

% Обчислення похідної
df = diff(f, x);

% Знаходження критичних точок (f'(x) = 0)
critical_points = solve(df == 0, x);
disp('Критичні точки:');
disp(critical_points);

% Друга похідна для визначення характеру точки (мінімум / максимум)
d2f = diff(df, x);

for i = 1:length(critical_points)
    point = double(critical_points(i));
    second_derivative = double(subs(d2f, x, point));
    value = double(subs(f, x, point));
    if second_derivative > 0
        fprintf('x = %.3f — мінімум, f(x) = %.3f\n', point, value);
    elseif second_derivative < 0
        fprintf('x = %.3f — максимум, f(x) = %.3f\n', point, value);
    else
        fprintf('x = %.3f — можливий перегин, f(x) = %.3f\n', point, value);
    end
end

% Побудова графіка
fplot(f, [-2, 5]);
grid on;
title('Графік функції f(x) = x^3 - 3x^2 + 10');
xlabel('x');
ylabel('f(x)');

