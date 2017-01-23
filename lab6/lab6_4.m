fs = 5000;
f0 = 440;
t = 0:1/fs:3-1/fs;
% for s = 0:-1:-12
%     f = f0*2^(s/12);
%     y = sin(2*pi*f*t);
%     spectro(y,fs)
% end
s = 0;
f = f0*2^(s/12);
y = sin(2*pi*f*t);
spectro(y,fs);
% s = 1;
% f = f0*2^(s/12);
% y = sin(2*pi*f*t);
% spectro(y,fs);