function y = f(p,fs)
D=1;
t = 0:1/fs:D-1/fs;
y = sin(2*pi*p*t);