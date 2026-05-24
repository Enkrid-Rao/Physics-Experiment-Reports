%% 查理定律实验：压强(p)与绝对温度(T)关系图
clear; clc; close all;

% ===================== 1. 输入实验数据 =====================
t_celsius = [25.4, 28.4, 31.4, 34.4, 37.4, 40.4, 43.4, 46.4, 49.4, 52.4]; % 摄氏温度(°C)
delta_p = [8.38, 10.12, 11.54, 12.79, 13.92, 15.06, 16.16, 17.22, 18.26, 19.36]; % 压强差(kPa)
p = [104.54, 106.28, 107.7, 108.95, 110.08, 111.22, 112.32, 113.38, 114.42, 115.52]; % 实测压强(kPa)
T = [298.55, 301.55, 304.55, 307.55, 310.55, 313.55, 316.55, 319.55, 322.55, 325.55]; % 绝对温度(K)
atm_p = 96.16; % 大气压(kPa)

% ===================== 2. 数据处理与拟合 =====================
% 查理定律本质：p = k*T + b (同一体积下)
x = T;          % 横轴：绝对温度 T (K)
y = p;          % 纵轴：压强 p (kPa)

% 线性拟合
p_fit = polyfit(x, y, 1);
k = p_fit(1);   % 斜率 (kPa/K)
b = p_fit(2);   % 截距 (kPa)
y_fit = polyval(p_fit, x);

% 计算相关系数 R²
R2 = 1 - sum((y - y_fit).^2) / sum((y - mean(y)).^2);

% ===================== 3. 绘图 =====================
figure('Color','white','Position',[100,100,800,600]);

% 绘制数据点和拟合直线
plot(x, y, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5); hold on;
plot(x, y_fit, 'r-', 'LineWidth', 2);

% --- 标题与标签 ---
% 解决中文乱码（根据系统设置，Windows常用SimHei，Mac常用Heiti SC）
set(gca, 'FontName', 'SimHei'); 
title({'查理定律：同一体积下气体压强与绝对温度关系', ...
       ['大气压：', num2str(atm_p), ' kPa']}, ...
      'FontSize', 14, 'FontWeight', 'bold');

xlabel('绝对温度 T (K)','FontSize', 12);
ylabel('压强值 p (kPa)','FontSize', 12);

% --- 图例与标注 ---
legend('实验数据点','线性拟合直线','Location','best','FontSize', 11);

% 在图上标注拟合方程与 R²
fit_eq_text = sprintf('拟合方程：p = %.4f · T + %.2f', k, b);
text(300, 110, {fit_eq_text}, ...
     'FontSize', 11, 'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 5);

% --- 网格与样式 ---
grid on;
grid minor; % 细网格
set(gca, 'FontSize', 10);
hold off;

% ===================== 4. 输出结果至命令行 =====================
fprintf('========== 查理定律实验拟合结果 ==========\n');
fprintf('斜率 k = %.4f kPa/K\n', k);
fprintf('截距 b = %.2f kPa\n', b);
fprintf('相关系数 R² = %.6f\n', R2);
fprintf('==========================================\n');