%%
a = imread('images\camera.png');
imshow (a)
colorbar
truesize
figure;
[b MAP] = imread('images\SunCountry.png');
imshow(b,MAP)
colorbar
truesize
%%
a=imread('images\camera.png');
imshow(a')
figure;
%%
imshow(flip(a))
figure;
imshow(fliplr(a))
figure;
imshow(rot90(a))
b = a'
imwrite(b,'ima.png')
pwd
%%
a = imshow('images\hats.png');
b = imread('images\hats.png');
whos;
imfinfo images\hats.png;
subplot(2,2,1);
imshow(b)
subplot(2,2,2);
c = b(:,:,1);
imshow(c)
subplot(2,2,3);
d = b(:,:,2);
imshow(d)
subplot(2,2,4);
e = b(:,:,3);
imshow(e)
%%