% Діапазони значень y і z
[y, z] = meshgrid(linspace(-20, 10, 20), linspace(-20, 10, 20));

% Обчислення x з рівняння
x = ((y + 1).^2) / 5 + ((z + 4).^2) / 2 + 2;

% Побудова графіка
surf(x, y, z);
xlabel('x');
ylabel('y');
zlabel('z');
title('Графік поверхні: x = (y+1)^2/5 + (z+4)^2/2 + 2');
shading interp;
colormap turbo;
colorbar;
grid on;

