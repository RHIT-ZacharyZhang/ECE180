% fs=1000;                      % sampling rate = 1kHz
% t=0:1/fs:10-1/fs;              % sampled time array, 3 seconds
% x=chirp(t,100,2,200,'q');     % quadratic-style chirp
% spectro(x,fs)
% xlim([-1,1])
% ylim([-1,1])
f0 = 1000;
fs = 10000;
t = 0:1/fs:5-1/fs;
% x = sin(2*pi*f0*t);
% spectro(x,fs)
% xlabel('t seconds')
% ylabel('x(t)')
% x = diric(2*pi*f0*t,3);
% spectro(x,fs)
% plot(t,x)
% figure;
% x = 2*(f0*t-fix(f0*t)-0.5)
% spectro(x,fs)
% plot(t,x)
M = 0.001;
x = sin(2*pi*f0*t).*sin(2*pi*M*f0*t);
spectro(x,fs)
% [x,fs] = audioread('audio/s1.wav');
% N = size(x,1);
% t = (0:1/fs:(N-1)/fs)';
% for i=1:N
%     y (i)= sin(2*pi*f0*t(i)).*x(i);
% end
% spectro(y,fs)
% f0 = 1500;
% M = 0.05;
% I = 2;
% x = sin(2*pi*f0*t+I*sin(2*pi*M*f0*t));
% spectro(x,fs)