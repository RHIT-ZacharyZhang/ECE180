function y = func(f0,fs)
D=0.5;
t = 0:1/fs:D-1/fs;
y = sin(2*pi*f0*t);