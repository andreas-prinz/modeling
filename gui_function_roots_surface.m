function gui_function_roots_surface 
    pkg load symbolic % Пакет для символьної математики 

    % Головне вікно 
    f = figure('Name','Графік функції + нулі + поверхня','Position',[300 200 700 500]); 
 
    % Меню 
    uimenu(f, 'Label', 'Вихід', 'Callback', @(~,~) close(f)); 
 
    % Поле введення функції 
    uicontrol(f,'Style','text','Position',[20 460 120 20],'String','Функція f(x):'); 
    func_input = uicontrol(f,'Style','edit','Position',[140 460 520 25],... 
        'String','acos(sin(5*x) + x^5) - x/(nthroot(3 - x, 3))'); 
 
    % Кнопка обчислення 
    uicontrol(f,'Style','pushbutton','Position',[300 420 100 30],'String','Побудувати',... 
        'Callback', @(~,~) plot_and_compute(func_input)); 
 
    % Область графіка 
    ax = axes('Parent',f, 'Units','pixels','Position',[60 50 580 350]); 
end 

function plot_and_compute(func_input) 
    pkg load symbolic 
    syms x; 

    func_str = get(func_input, 'String'); 
 
    try 
        f_sym = eval(func_str); % Символьне подання функції 
        f_func = matlabFunction(f_sym); % Анонімна функція для побудови 
 
        % Побудова графіка 
        x_vals = linspace(-1.5, 1.5, 1000); 
        y_vals = arrayfun(f_func, x_vals); 
        cla; 
        plot(x_vals, y_vals, 'b-', 'LineWidth', 2); 
        hold on; grid on; 
        xlabel('x'); ylabel('f(x)'); 
        title('f(x) та її нулі'); 
 
        % Діапазон і крок для пошуку нулів 
        x_range = -2:0.1:2;  % початкові значення для пошуку 
        found_roots = []; 
 
        % Пошук нулів 
        for i = 1:length(x_range)-1 
           a = x_range(i); 
           b = x_range(i+1); 
           try 
               r = vpasolve(f_sym == 0, x, [a, b]); 
               if isempty(r) 
                   disp('Нулів не знайдено'); 
               else 
                   r_val = double(r); 
                   % Перевірка, чи корінь ще не знайдено (з урахуванням похибки) 
                   if all(abs(found_roots - r_val) > 1e-4) 
                       found_roots(end+1) = r_val; 
                       plot(r_val, 0, 'ro', 'MarkerSize', 8, 'MarkerFaceColor','r'); 
                   end 
               end 
           catch 
               % Ігнорувати помилки у проміжках, де обчислення не вдається 
           end 
        end 
 
        % Поверхня обертання навколо осі OX 
        % Побудова сітки 
        [X, T] = meshgrid(x_vals, linspace(0, 2*pi, 100)); 
 
        % Обчислення значень функції 
        Y = arrayfun(f_func, x_vals); 
 
        % Фільтрація комплексних значень 
        Y = real(Y); 
        Y(imag(Y) ~= 0 | isnan(Y)) = 0;  % зануляємо у випадку невалідних 
 
        % Формування поверхні 
        Z = repmat(Y, size(T,1), 1); 
        Xr = Z .* cos(T); 
        Yr = Z .* sin(T); 
        Zr = repmat(x_vals, size(T,1), 1); 
 
        figure('Name','Поверхня обертання навколо OX'); 
        surf(Xr, Yr, Zr); 
        xlabel('X'); ylabel('Y'); zlabel('Z'); 
        title('Поверхня при обертанні навколо осі OX'); 
        shading interp; colormap turbo; axis tight; 

        % Поверхня обертання навколо осі OY 
        % Побудова сітки 
        [Y, T] = meshgrid(x_vals, linspace(0, 2*pi, 100)); 
 
        % Обчислення значень функції 
        Z = arrayfun(f_func, x_vals); 
 
        % Фільтрація комплексних або невалідних значень 
        Z = real(Z); 
        Z(imag(Z) ~= 0 | isnan(Z)) = 0; 
 
        % Формування поверхні 
        Xr = repmat(Z, size(T,1), 1) .* cos(T); 
        Zr = repmat(Z, size(T,1), 1) .* sin(T); 
        Yr = repmat(x_vals, size(T,1), 1); 
 
        figure('Name','Поверхня обертання навколо OY'); 
        surf(Xr, Yr, Zr); 
        xlabel('X'); ylabel('Y'); zlabel('Z'); 
        title('Поверхня при обертанні навколо осі OY'); 
        shading interp; colormap turbo; axis tight; 
    catch err 
        errordlg(['Помилка: ', err.message],'Синтаксична помилка'); 
    end 
end