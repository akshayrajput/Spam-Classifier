clc; clear;close all;
%linear kernel small data
inputx = load ('./libsvm-input/train_small.txt');
y = inputx(:,1);
x = inputx(:,2:end);
model=svmtrain(y,x,'-h 0 -t 0');
inputx = load ('./libsvm-input/test_small.txt');
y = inputx(:,1);
x = inputx(:,2:end);
svmpredict(y,x,model);
clear;close all;
%linear kernel full training data
inputx = load ('./libsvm-input/train_full.txt');
y = inputx(:,1);
x = inputx(:,2:end);
model=svmtrain(y,x,'-h 0 -t 0');
inputx = load ('./libsvm-input/test_full.txt');
y = inputx(:,1);
x = inputx(:,2:end);
svmpredict(y,x,model);
clear;close all;
%gaussian kernel small training data
inputx = load ('./libsvm-input/train_small.txt');
y = inputx(:,1);
x = inputx(:,2:end);
model=svmtrain(y,x,'-h 0 -t 1 -g 2.5*1e-4');
inputx = load ('./libsvm-input/test_small.txt');
y = inputx(:,1);
x = inputx(:,2:end);
svmpredict(y,x,model);
clear;close all;
%gaussian kernel full training data
inputx = load ('./libsvm-input/train_full.txt');
y = inputx(:,1);
x = inputx(:,2:end);
model=svmtrain(y,x,'-h 0 -t 1 -g 2.5*1e-4');
inputx = load ('./libsvm-input/test_full.txt');
y = inputx(:,1);
x = inputx(:,2:end);
svmpredict(y,x,model);