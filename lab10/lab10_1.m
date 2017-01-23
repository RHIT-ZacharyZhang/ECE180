close all
clear all
clc
shrink = 2;
a = imread('mandril_color.png');
a=im2double(a);
figure(1);
imshow(a,'InitialMagnification','fit');
figure(2);
h = size(a,1);
w = size(a,2);
% % for k = 1:shrink:h
% %     for m = 1:shrink:w
% %         h1(k,m,:)=a(k,m,:);
% %     end
% % end
h1 =a([1:shrink:h],[1:shrink:w],:);
imshow(h1);
figure(3);
h2 = imresize(h1,1,'nearest');
imshow(h2);
figure(4);
b = fspecial('average',[5 5]);
h3 = imfilter(h1,b);
imshow(h3);
figure(5);
h4 = imresize(h1,1,'bicubic');
imshow(h4);
figure(6);
m = a;
m(:,:,:,2) = b;
m(:,:,:,3) = c;
m(:,:,:,4) = d;
montage(m)