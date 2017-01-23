a = imread('parrots.png');
N=41
h = zeros(N);
h((N+1)/2,(N+1)/2) = 1;
figure(9);
imshow(imfilter(a,h,'full'))
avg = ones(41)/41^2;
figure(1);
imshow(imfilter(a,avg))
figure(2);
imshow(imfilter(a,avg,'full'))
figure(3);
imshow(imfilter(a,h,'full','circular'))
figure(4);
imshow(imfilter(a,avg,'full','circular'))
figure(5);
imshow(imfilter(a,h,'full','replicate'))
figure(6);
imshow(imfilter(a,avg,'replicate'))
figure(7);
imshow(imfilter(a,h,'full','symmetric'))
figure(8);
imshow(imfilter(a,avg,'symmetric'))