function [acc] = accuracy( w,b )
    %accuracy
    x = load('test_full.txt');
    %[~,n] = size(x);
    y = x(:,1);
    %y = y';
    count = 0;
    wrong_classified = 0;
    x = x(:,2:end);
    for i = 1:1000
        t = (w'*x(i,:)' + b);
        count = count + 1;
        if (t * y(i) <= 0)
            wrong_classified = wrong_classified + 1;
        end
    end
    acc = ((count - wrong_classified)/count) *100;
    return;
end

