clc; clear;
UE = readmatrix('kr_unemployment_rate.xlsx', 'sheet', '데이터', 'range', 'B144:B236');
GDP = readmatrix('kr_gdp.xlsx', 'sheet', '데이터', 'range', 'B166:B258');


T=[UE, GDP];

% 그래프 보여주기
figure;
scatter(T(:, 1), T(:, 2), 'filled', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black','SizeData', 10);
title('한국의 오쿤의 법칙(실업률 & GDP 성장률)', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('실업률');
ylabel('GDP 성장률');
