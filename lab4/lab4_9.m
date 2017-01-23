a = imread('hats.png');
hat = im2bw(a);
hat = bwareaopen(hat,100);
imshow(hat)
figure;
hat = bwconvhull(hat);
imshow(hat)
cc = bwconncomp(hat)
r = regionprops(cc)
img = insertText(a,r.Centroid,'orange hat');
imshow(img)
img=insertShape(img,'Rectangle',r.BoundingBox);
imshow(img)