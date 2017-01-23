fs = 8000;
D=2;
%set up t
tt=(0:1/fs:D-1/fs)';
f0=4000;
x = sin(2*pi*f0*tt);
%play the audio
spectro(x,fs)
