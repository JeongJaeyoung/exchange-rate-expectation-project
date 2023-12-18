clear;clc;

%% Step 1: 데이터 준비하기
% 환율 월별 데이터
EX_JPN_WON_MONTHLY = readmatrix('exchange_rate.xlsx', 'sheet', '데이터', 'range', 'F556:F716');
EX_EUR_WON_MONTHLY = readmatrix('exchange_rate.xlsx', 'sheet', '데이터', 'range', 'H556:H716');
EX_US_WON_MONTHLY = readmatrix('exchange_rate.xlsx', 'sheet', '데이터', 'range', 'B556:B716');




%% Step 2: 추정하기

%[beta_hat, SE_beta_hat, t_values, R2, adj_R2] = OLS_FORMULA(Y_JPN, X_JPN );


us_kr_data = EX_US_WON_MONTHLY(:, 1);

% x축 인덱스 배열 생성
x = 1:numel(us_kr_data);

%그래프 그리기
fig = figure;
set(fig, 'Position', [100, 100, 1200, 300]);

%일본 엔/원 환율 그래프
subplot(1, 3, 1);
plot(x, EX_JPN_WON_MONTHLY, 'LineWidth', 2, 'Color', 'blue');
title('일본 환율(100엔=XXX원)');
xlim([1, numel(EX_JPN_WON_MONTHLY)]);

%x축 틱 설정
startYear = 2010;
endYear = startYear + floor(numel(us_kr_data) / 12) - 1;
xticks(1:24:numel(us_kr_data));
%연도 레이블 생성
yearLabels = cellstr(num2str((startYear:2:endYear)', '%d년'));
xticklabels(yearLabels);
%x축 범위 조정
xlim([1, numel(us_kr_data)]);


%유럽 유로/원 환율 그래프
subplot(1, 3, 2);
plot(x, EX_EUR_WON_MONTHLY, 'LineWidth', 2, 'Color', 'blue');
title('유럽 환율(1유로=XXX원)');
xlim([1, numel(EX_EUR_WON_MONTHLY)]);

%x축 틱 설정
startYear = 2010;
endYear = startYear + floor(numel(us_kr_data) / 12) - 1;
xticks(1:24:numel(us_kr_data));
yearLabels = cellstr(num2str((startYear:2:endYear)', '%d년'));
xticklabels(yearLabels);
xlim([1, numel(us_kr_data)]);


%미국 달러/원 환율 그래프
subplot(1, 3, 3);
plot(x, EX_US_WON_MONTHLY, 'LineWidth', 2, 'Color', 'blue');
title('미국 환율(1달러=XXX원)');
xlim([1, numel(EX_US_WON_MONTHLY)]);

startYear = 2010;
endYear = startYear + floor(numel(us_kr_data) / 12) - 1;
xticks(1:24:numel(us_kr_data));
yearLabels = cellstr(num2str((startYear:2:endYear)', '%d년'));
xticklabels(yearLabels);
xlim([1, numel(us_kr_data)]);



