clear;clc;

%% Step 1: 데이터 준비하기
%환율 분기별 데이터
EX_JPN_WON_QUARTER = readmatrix('exchange_rate.xlsx', 'sheet', '데이터', 'range', 'F901:F953');

Y_JPN=(EX_JPN_WON_QUARTER(2:end) - EX_JPN_WON_QUARTER(1:end-1)) ./ EX_JPN_WON_QUARTER(1:end-1);

% 한국 데이터
% 필수 설명변수 1 : 한국 정치적 양극화 정도
KR_POLARIZATION = readmatrix('polarization_index.xlsx', 'sheet', 'Sheet1', 'range', 'D6:D57');

% 필수 설명변수 2 : 한국 실업률
KR_UNEMPLOYMENT = readmatrix('kr_unemployment_rate.xlsx', 'sheet', '데이터', 'range', 'B184:B235');

% 추가 설명변수 1 : 한국 2년 국채 금리
KR_2YEAR_INTEREST_RAW=readmatrix('kr_2year.xlsx', 'sheet', '한국 2년 채권수익률 과거 데이터', 'range', 'B5:B166');
KR_2YEAR_INTEREST_REVERT = flip(KR_2YEAR_INTEREST_RAW);
% 분기별 자료를 담을 행렬 초기화
KR_2YEAR_INTEREST_QUARTER = zeros(size(KR_2YEAR_INTEREST_REVERT,1)/3, 1);
% 분기별 데이터 추출하여 행렬 구성
for i = 1:numel(KR_2YEAR_INTEREST_QUARTER)
    Index = 3*(i-1) + 1;
    KR_2YEAR_INTEREST_QUARTER(i) = KR_2YEAR_INTEREST_REVERT(Index,1);
end
KR_2YEAR_INTEREST_QUARTER_DATA=KR_2YEAR_INTEREST_QUARTER(2:end-1,1);

% 추가 설명변수 2 : 한국 주가지수(KOSPI) 성장률
KR_STOCK_RAW = readmatrix('KOSPI.xlsx', 'sheet', 'kospi', 'range', 'B5:B166');
KR_STOCK_REVERT = flip(KR_STOCK_RAW);
% 분기별 자료를 담을 행렬 초기화
KR_STOCK_QUARTER = zeros(size(KR_STOCK_REVERT,1)/3, 1);
% 분기별 데이터 추출하여 행렬 구성
for i = 1:numel(KR_STOCK_QUARTER)
    Index = 3*(i-1) + 1;
    KR_STOCK_QUARTER(i) = KR_STOCK_REVERT(Index,1);
end
KR_STOCK_RATE = (KR_STOCK_QUARTER(2:54) - KR_STOCK_QUARTER(1:53)) ./ KR_STOCK_QUARTER(1:53);

% 추가 설명변수 3 : 한국 실질 GDP 성장률
KR_GDP_RATE = readmatrix('KR_GDP_RATE.xlsx', 'sheet', '데이터', 'range', 'B9:B61');



%일본 데이터
% 필수 설명변수 3 : 일본 중앙은행 자산 증가율
BOJ_ASSET = readmatrix('JPNASSETS.xls', 'sheet', 'FRED Graph', 'range', 'B17:B70');
BOJ_ASSET_RATE = (BOJ_ASSET(2:54) - BOJ_ASSET(1:53)) ./ BOJ_ASSET(1:53);

% 추가 설명변수 1 : 일본 2년 국채 금리
JPN_2YEAR_INTEREST_RAW=readmatrix('jpn_2year.xlsx', 'sheet', 'jpn_2year', 'range', 'B5:B166');
JPN_2YEAR_INTEREST_REVERT = flip(JPN_2YEAR_INTEREST_RAW);
% 분기별 자료를 담을 행렬 초기화
JPN_2YEAR_INTEREST_QUARTER = zeros(size(JPN_2YEAR_INTEREST_REVERT,1)/3, 1);
% 분기별 데이터 추출하여 행렬 구성
for i = 1:numel(JPN_2YEAR_INTEREST_QUARTER)
    Index = 3*(i-1) + 1;
    JPN_2YEAR_INTEREST_QUARTER(i) = JPN_2YEAR_INTEREST_REVERT(Index,1);
end
JPN_2YEAR_INTEREST_QUARTER_DATA=JPN_2YEAR_INTEREST_QUARTER(2:end-1,1);

% 추가 설명변수 2 : 일본 주가지수(NIKKEI) 성장률
JPN_STOCK = readmatrix('NIKKEI225.xls', 'sheet', 'FRED Graph', 'range', 'B19:B72');
JPN_STOCK_RATE = (JPN_STOCK(2:54) - JPN_STOCK(1:53)) ./ JPN_STOCK(1:53);

% 추가 설명변수 3 : 일본 실질 GDP 성장률
JPN_GDP = readmatrix('JPNRGDPEXP.xls', 'sheet', 'FRED Graph', 'range', 'B18:B71');
JPN_GDP_RATE = (JPN_GDP(2:54) - JPN_GDP(1:53)) ./ JPN_GDP(1:53);

T=size(JPN_GDP_RATE,1)-1;




% 사용할 설명변수 정리
% 필수 설명변수 3가지
KR_POLARIZATION = KR_POLARIZATION;
KR_UNEMPLOYMENT = KR_UNEMPLOYMENT;
BOJ_ASSET_DATA=BOJ_ASSET_RATE(1:end-1,1);

% 추가 설명변수 3가지
KR_JPN_INTEREST_GAP=KR_2YEAR_INTEREST_QUARTER_DATA-JPN_2YEAR_INTEREST_QUARTER_DATA;
KR_JPN_STOCK_GAP=KR_STOCK_RATE(1:end-1,1)-JPN_STOCK_RATE(1:end-1,1);
KR_JPN_GDP_GAP=KR_GDP_RATE(1:end-1,1)-JPN_GDP_RATE(1:end-1,1);

% 다양한 CASE들
X_JPN_CASE1 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA];
X_JPN_CASE2 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_INTEREST_GAP];
X_JPN_CASE3 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_STOCK_GAP];
X_JPN_CASE4 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_GDP_GAP];
X_JPN_CASE5 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_INTEREST_GAP, KR_JPN_STOCK_GAP];
X_JPN_CASE6 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_INTEREST_GAP,  KR_JPN_GDP_GAP];
X_JPN_CASE7 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_STOCK_GAP, KR_JPN_GDP_GAP];
X_JPN_CASE8 = [ones(T,1), KR_POLARIZATION, KR_UNEMPLOYMENT, BOJ_ASSET_DATA, KR_JPN_INTEREST_GAP, KR_JPN_STOCK_GAP, KR_JPN_GDP_GAP];



%% Step 2: 추정하기
disp("CASE1");
OLS_FORMULA(Y_JPN, X_JPN_CASE1);
disp("CASE2");
OLS_FORMULA(Y_JPN, X_JPN_CASE2);
disp("CASE3");
OLS_FORMULA(Y_JPN, X_JPN_CASE3);
disp("CASE4");
OLS_FORMULA(Y_JPN, X_JPN_CASE4);
disp("CASE5");
OLS_FORMULA(Y_JPN, X_JPN_CASE5);
disp("CASE6");
OLS_FORMULA(Y_JPN, X_JPN_CASE6);
disp("CASE7");
OLS_FORMULA(Y_JPN, X_JPN_CASE7);
disp("CASE8");
OLS_FORMULA(Y_JPN, X_JPN_CASE8);


