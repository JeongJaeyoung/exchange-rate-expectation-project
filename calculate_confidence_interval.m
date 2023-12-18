df = 46;  % 자유도
confidence = 0.9;  % 양방향 신뢰수준

alpha = (1 - confidence) / 2;  % 한 쪽의 신뢰수준 계산
t_value = tinv(1 - alpha, df);  % 한 쪽 신뢰수준을 이용하여 T-값 계산

lower_bound = -t_value;  % 하한값
upper_bound = t_value;  % 상한값

disp(lower_bound);
disp(upper_bound);