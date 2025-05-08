function gui_plot_function 
    % Створення головного вікна 
    f = figure('Name','Побудова графіка функції', 'Position',[300 300 600 400]); 

    % Меню 
    m = uimenu(f, 'Label', 'Файл'); 
    uimenu(m, 'Label', 'Вийти', 'Callback', @(~,~) close(f)); 
 
    % Текстові поля та ввод
    uicontrol(f, 'Style','text','Position',[30 350 80 20],'String','a:'); 
    a_input = uicontrol(f, 'Style','edit','Position',[120 350 80 25],'String','0'); 
 
    uicontrol(f, 'Style','text','Position',[220 350 80 20],'String','b:'); 
    b_input = uicontrol(f, 'Style','edit','Position',[300 350 80 25],'String','90'); 
 
    uicontrol(f, 'Style','text','Position',[400 350 80 20],'String','Крок:'); 
    step_input = uicontrol(f, 'Style','edit','Position',[480 350 80 25],'String','2'); 
 
    uicontrol(f, 'Style','text','Position',[30 310 150 20],'String','Функція (f(x)):'); 
    func_input = uicontrol(f, 'Style','edit','Position',[180 310 380 25],'String','tan(deg2rad(x+30))'); 
 
    % Кнопка побудови 
    uicontrol(f, 'Style','pushbutton','Position',[250 270 100 30],'String','Побудувати',... 
          'Callback', @(~,~) plot_function(a_input, b_input, step_input, func_input)); 
 
    % Область графіка 
    axes('Parent',f, 'Units','pixels','Position',[60 40 480 200]); 
end 

function plot_function(a_input, b_input, step_input, func_input) 
    a = str2double(get(a_input, 'String')); 
    b = str2double(get(b_input, 'String')); 
    step = str2double(get(step_input, 'String')); 
    func_str = get(func_input, 'String'); 

    try 
        x = a:step:b; 
        y = eval(func_str); % Обчислення функції 
        plot(x, y, 'b-', 'LineWidth', 2); 
        grid on; 
        xlabel('X, градуси'); 
        ylabel(['Y = ', func_str]); 
        title(['Графік функції Y = ', func_str], 'Interpreter', 'none'); 
    catch err 
        errordlg(['Помилка у виразі функції: ', err.message], 'Помилка'); 
    end 
end 
