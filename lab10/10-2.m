vr = VideoReader('clock.mp4')
nframes=get(VideoReader('clock.mp4'),'NumberofFrames')
vr1 = vision.VideoFileReader('clock.mp4')
vr1.VideoOutputDataType = 'single';
vw = VideoWriter('name1.mp4','MPEG-4');
vw.FrameRate = vr.FrameRate
vw.Quality = 100;
open(vw);
%vision.DeployableVideoPlayer(1000);
sec = nframes / vw.FrameRate;
shrink = 2;
c = round(shrink);
i = 1
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