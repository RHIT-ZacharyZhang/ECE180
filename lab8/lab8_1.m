img = imread('camera.png');
fstk = img;
fstk(:,:,256) = 0;
implay(fstk)
for k = 1 : 256
    fstk1(:,:,k) = circshift(fstk(:,:,1),[1*k 1*k]);
end
implay(fstk1,50);
