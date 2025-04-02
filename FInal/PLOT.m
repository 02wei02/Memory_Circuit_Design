% Specify the Excel file path
excelFilePath = "D:\Document\Senior\Memory_Circuit_Design\Final\SNM.xlsx";
% Read data from Excel
data = xlsread(excelFilePath, 3);

close; % 关闭窗口
% Extract data
VI = data(:, 1);  % Assuming VI is in the first column
VOr = data(:, 2);
% 从第四列提取 VOW
VOw = data(:, 3);


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
grid on;

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


% Display the grid
grid on;
hold off;

