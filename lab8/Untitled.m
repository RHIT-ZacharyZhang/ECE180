vr = VideoReader('mobile.mp4');
get(vr)
get(vr,'NumberOfFrames') 
vr.NumberOfFrames
fstk = read(vr);
size(fstk)
implay(fstk);