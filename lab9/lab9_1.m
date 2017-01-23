v = vision.VideoFileReader('container.mp4');
x = VideoReader('container.mp4')
v1 = step(v); %first frame of video file
%imshow(v1);
v2 = rgb2gray(v1);  %grayscale format
%imshow(v2);
b = 0.1;
i=1
while ~isDone(v)
    vv = step(v);
    v3 = rgb2gray(vv);
    a = abs(v3 - v2);
    c= im2bw(a,b);
    d= bwareaopen(c,80);
    se1 = strel('square',5);
    e = imclose(d,se1);
    f = bwconncomp(e);
    n = f.NumObjects;
    g = regionprops(f);
    for k = 1:n
         vv = insertShape(vv,'Rectangle',g(k).BoundingBox);
       % rectangle('position',g(k).BoundingBox,'EdgeColor','r');
    end
    imshow(vv);
    j(:,:,:,i) = vv;
    i = i + 1;
end
implay(j)
vw = VideoWriter('container1.mp4','MPEG-4');
vw.Quality = 100;
vw.FrameRate = x.FrameRate
open(vw);
writeVideo(vw,j);
close(vw);