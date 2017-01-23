a = imread('barn.png');
a(:,:,:,64) = 0;
for k = 1:size(a,4)
    a(:,:,:,k) = circshift(a(:,:,:,1),[1*k , 1*k]);
end
for k = 1 : size(a,4)
    h = ones(65-k)/(65-k)^2;
    a(:,:,:,k) = imfilter(a(:,:,:,k),h);
end
implay(a)