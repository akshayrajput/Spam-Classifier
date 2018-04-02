clc;clear;close all;
%gaussian kernel
x = load('train_small.txt');
y = x(:,1);
x = x(:,2:end);
[m,n] = size(x);
C = 1;
Q = zeros(m,m);
g = 2.5*1e-4;
for i=1:m
    Q(i,i) = 1;
    for j =i+1:m
        Q(i,j) = exp(-1 * g * ((x(i,:) - x(j,:))*(x(i,:) - x(j,:))'));
        Q(j,i) = Q(i,j);
    end
end
% cvx code
cvx_begin
    variable a(m)
    maximize(ones(m,1)'*a - (1/2)*a'*Q*a)
    subject to
        0 <= a 
        a <= C
        y'*a ==0
cvx_end
% calculate accuracy
total_sv = 0;
tempa = a;
for i =1:size(tempa,1)
    if tempa(i,1)>=0.0001 && tempa(i,1) <=0.9999
        total_sv = total_sv+1;
    else
        tempa(i,1) = 0;
    end
end
inputx = load('test_small.txt');
ty = inputx(:,1);
tx = inputx(:,2:end);
correctly_classified = 0;

for i =1:size(tx,1)
    for j = 1:size(x,1)
        k(i,j) = exp(-1 * g * norm(tx(i,:) - x(j,:))^2);
    end
    Mt = (a.*y)'*k(i,:)';
    b = 1 - (tempa.* a)' * k(i,:)';
    if ty(i,1)*(Mt+b)>0
            correctly_classified = correctly_classified + 1;
    end
end

acc = correctly_classified/size(tx,1);
fprintf('Accuracy = %0.2f%%\n',acc);