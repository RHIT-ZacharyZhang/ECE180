vr = vision.VideoFileReader('soccer.mp4');
vr = vision.VideoFileReader('VideoOutputDataType','uint8')
for i = 1: 100
    imshow(step(vr));
    pause(1/1000);
end
vr = vision.VideoFileReader('VideoOutputDataType','single');