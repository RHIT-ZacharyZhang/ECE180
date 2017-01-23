function [name1 , sec] = function10_2(name)
vr = VideoReader(name)
a = vr.NumberofFrames;
vr1 = vision.VideoFileReader(name)
vr1.VideoOutputDataType = 'single';
vw = VideoWriter('name1.mp4','MPEG-4');
vw.FrameRate = vr.FrameRate
vw.Quality = 100;
open(vw);
sec = a / vw.FrameRate;
shrink = 2;
c = round(shrink);
i = 1
% d = zeros(160,140,3,1800);
while ~isDone(vr1)
    b = step(vr1);
    if mod(i,2) == 0;
        d(:,:,:,(i/2)) = b;
    end
    i=i+1;
end
writeVideo(vw,d);
implay(d);
close(vw);