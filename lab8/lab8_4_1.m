vr = vision.VideoFileReader('soccer.mp4');
vr.VideoOutputDataType = 'uint8';
vr.ImageColorSpace='Intensity';
close(vr);
vp=vision.DeployableVideoPlayer(1e3);

get(vr);

while ~isDone(vr)
    a = step(vr);
    a = 255 - a;
    step(vp,a)
    vw = VideoWriter('soccerrotate.mp4','MPEG-4')
    vw.FrameRate = 29.97;
    open(vw);
    writeVideo(vw,a);
end
VideoWriter close
release('soccer.mp4')
implay(vw);

close(vw)
release(vr)
release(vp)
clear vp



