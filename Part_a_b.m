%linear kernel
%part a and b
clc;clear all;close all;
x = load('train_full.txt');
y = x(:,1);
x = x(:,2:end);
[m,n] = size(x);
C = 1;
Q = (y*y').*(x*x');
% cvx code
cvx_begin
    variable a(m)
    maximize(ones(m,1)'*a - (1/2)*a'*Q*a)
    subject to
        0 <= a 
        a <= C
        y'*a ==0
cvx_end
% calculate w
t = a.*y;
w = x'*t;
total_attr = 0;
for i=1:size(a,1)
    if a(i,1) > 0.0001 && a(i,1) < 0.9999
        total_attr = total_attr + 1;
    else
       a(i,1) = 0;
    end
end
fprintf('Total attributes are = %d\n',total_attr);
% calculate b
z = x';
min = 10000000;
max = -10000000;
for i = 1:m
    if (y(i) == 1)
        t1 = w'*z(:,i);
        if (t1 < min)
             min = t1;
        end
    end
    if (y(i) == -1)
        t2 = w'*z(:,i);
        if (t2 > max)
             max = t2;
        end
    end
end
b=(-1/2)*(min+max);
acc = accuracy(w,b);
fprintf('Accuracy = %0.2f%%\n',acc);