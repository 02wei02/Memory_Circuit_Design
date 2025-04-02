% Specify the Excel file path
excelFilePath = "D:\Document\Senior\Memory_Circuit_Design\HW2\SRAM8T.xlsx";
% Read data from Excel
data = xlsread(excelFilePath, 4);

close; % 关闭窗口
% Extract data
VI = data(:, 1);  % Assuming VI is in the first column
VOr = data(:, 2);
VOw = data(:, 3);
%VOgnd = data(:, 2);  % Assuming VO is in the second column
%VOVdd = data(:, 3);


% Plot SNM
figure(1);
width=500;%宽度，像素数
height=500;%高度
left=200;%距屏幕左下角水平距离
bottem=200;%距屏幕左下角垂直距离
set(gcf,'position',[left,bottem,width,height])
plot(VI, VOr, 'b-', 'LineWidth', 2);
hold on;
plot(VOr, VI, 'g-', 'LineWidth', 2);
hold on;


figure(2);
width=500;%宽度，像素数
height=500;%高度
left=200;%距屏幕左下角水平距离
bottem=200;%距屏幕左下角垂直距离
set(gcf,'position',[left,bottem,width,height])
plot(VI, VOr, 'b-', 'LineWidth', 2);
hold on;
plot(VOw, VI, 'g-', 'LineWidth', 2);
hold on;


% Find the maximum square
[maxSquareSize, maxSquareIdx] = findMaxSquare(VI, VO);

% Plot the maximum square
plot(VI(maxSquareIdx), VO(maxSquareIdx), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
hold on;

% Label the plot
xlabel('Input Voltage (Vi)');
ylabel('Output Voltage (Vo)');
title('Read Signal Noise Margin (RSNM)');

% Display the grid
grid on;
hold off;

