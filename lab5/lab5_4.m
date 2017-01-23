function y = lab5_4(img, kernel)
x = imread(img);
[m, n] = size(x);
y = zeros(m,n);
z = zeros(m+2,n+2);
z(2:m+1,2:n+1) = x;
switch(kernel)
    case 'average'
        h = ones(3)/9
    case 'hedges'
        h = [-1 0 1
             -1 0 1
             -1 0 1]
    case 'vedges'
        h = [-1 -1 -1;0 0 0;1 1 1]
    case 'edges'
        h = [-1 -1 -1;-1 8 -1;-1 -1 -1]
    case 'Laplacian'
        h = [0 -1 0;-1 4 -1;0 -1 0]
    case 'sharpen'
        h = [0 -1 0;-1 5 -1;0 -1 0]
    case 'pass'
        h = [0 0 0;0 1 0;0 0 0]
    otherwise
        fprintf('ERROR')
        return
end
for k = 2:m+1
    for i = 2:n+1
        a = z(k-1:k+1,i-1:i+1);
        b = a .* h;
        c = sum(sum(b));
        y(k-1,i-1) = c;
    end
end
imshowpair(x,y,'montage');