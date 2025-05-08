function gui_sum_series 
    f = figure('Name', 'Сума/Добуток ряду', 'Position', [300, 300, 600, 400]); 

    % Панель для вибору між сумою і добутком 
    bg = uibuttongroup(f, 'Title', 'Операція', 'Position', [0.05 0.7 0.2 0.2]); 
    uicontrol(bg, 'Style', 'radiobutton', 'String', 'Сума', ... 
        'Position', [10 30 100 30], 'Tag', 'sum', 'Value', 1); 
    uicontrol(bg, 'Style', 'radiobutton', 'String', 'Добуток', ... 
        'Position', [10 0 100 30], 'Tag', 'prod'); 

    % Слайдер для вибору n 
    uicontrol(f, 'Style', 'text', 'Position', [30 240 150 20], 'String', 'Кількість n (1–10):'); 
    sld = uicontrol(f, 'Style', 'slider', 'Min', 1, 'Max', 10, 'Value', 6, ... 
        'SliderStep', [1/5 1/5], 'Position', [30 220 150 20]); 

    % Відображення значення слайдера 
    sld_txt = uicontrol(f, 'Style', 'text', 'Position', [180 240 40 20], ... 
        'String', '6'); 

    % Кнопка запуску обчислення 
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Обчислити', ... 
        'Position', [30 180 100 30], 'Callback', @compute_series); 

    % Осі для графіка 
    ax = axes(f, 'Position', [0.45 0.15 0.5 0.75]); 

    % Контекстне меню cmenu = uicontextmenu; 
    uimenu(cmenu, 'Label', 'Зберегти графік', 'Callback', @(~,~) saveas(f, 'graph.png')); 
    uimenu(cmenu, 'Label', 'Змінити колір', 'Callback', @(~,~) set(get(ax, 'Children'), 'Color', rand(1,3))); 
    set(ax, 'UIContextMenu', cmenu); 

    function compute_series(~, ~) 
        n = round(get(sld, 'Value')); 
        set(sld_txt, 'String', num2str(n)); 
        op = get(get(bg, 'SelectedObject'), 'Tag'); 
        x_vals = -10:1:10; 
        y_vals = zeros(size(x_vals)); 

        for i = 1:length(x_vals) 
            x = x_vals(i); 
            if strcmp(op, 'sum') 
                A = 0; 
                for k = 1:n 
                    A = A + (x^k)/k; 
                end 
            else  % prod 
                A = 1; 
                for k = 1:n 
                    A = A * ((x^k)/k); 
                end 
            end 
            y_vals(i) = A; 
        end 
 
        plot(ax, x_vals, y_vals, 'b.-', 'LineWidth', 2); 
        grid(ax, 'on'); 
        xlabel(ax, 'x'); ylabel(ax, 'A(x)'); 
        title(ax, ['A(x) для n = ' num2str(n)]); 
    end 
end 