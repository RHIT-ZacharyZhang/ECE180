function y = function5_1_3(img)
x = imread(img);
%x = rgb2gray(x);
%x = im2double(x);
[m, n] = size(x);
y = zeros(m,n);
z = zeros(m+2,n+2);
z(2:m+1,2:n+1) = x;
h=ones(3)/3^2;
for k = 2:m+1
    for i = 2:n+1
        a = z(k-1:k+1,i-1:i+1);
        b = a .* h;
        c = sum(sum(b));
        y(k-1,i-1) = c;
    end
end