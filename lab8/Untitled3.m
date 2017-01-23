vr = VideoReader('mobile.mp4');
get(vr);
get(vr,'NumberOfFrames');
fstk = read(vr);
implay(fstk);
imshow(fstk(:,:,:,100));
imshow(fstk(:,:,2,200));
implay(fstk(:,:,3,:));
for k = 1:vr.NumberOfFrames
    fstk1(:,:,k) = rgb2gray(fstk(:,:,:,k));
end
implay(fstk1);
for i = 1:size(fstk1,3)
    fstk2(:,:,i) = imrotate(fstk1(:,:,i),(360/260)*(i+1),'nearest','crop');
end
implay(fstk2);
for j = 1:size(fstk2,3)
    fstk3(:,:,1,j) = fstk2(:,:,j);
    fstk3(:,:,2,j) = fstk2(:,:,j);
    fstk3(:,:,3,j) = fstk2(:,:,j);
end
vw = VideoWriter('mobile-rotated.mp4','MPEG-4')
open(vw);
writeVideo(vw,fstk3);
close(vw);
