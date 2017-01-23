function [c d e] = showplanes(img)
a = imshow(img);
b = imread(img);
whos;
imfinfo(img);
subplot(2,2,1);
imshow(b);
subplot(2,2,2);
c = b(:,:,1);
imshow(c);
subplot(2,2,3);
d = b(:,:,2);
imshow(d);
subplot(2,2,4);
e = b(:,:,3);
imshow(e);