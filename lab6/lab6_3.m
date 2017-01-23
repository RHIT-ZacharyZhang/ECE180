f0 = 1000;
fs = 5000;
t = 0:1/fs:5-1/fs;
alpha = 0.2;
e = exp(-alpha * t);
% I = 8 * e;
% M = 0.2;
% x = e .* sin(2*pi*f0*t + I.*sin(2*pi*M*f0*t));
% spectro(x,fs)
I0 = 8;
If = 3;
I = (I0-If)*e+If;
M = 0.1;
x = e .* sin(2*pi*f0*t + I.*sin(2*pi*M*f0*t));
spectro(x,fs)