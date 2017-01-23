fs=1000;
f0=500;
t=(0:1/fs:10-1/fs)';
e = hann(size(t,1));
for i = 1:size(t,1)
    x(i) = e(i).*sin(2*pi*f0*t(i));
end
spectro(x,fs)
alpha = 0.5;
e = exp(-alpha*t);
x = e.*sin(2*pi*f0*t);
spectro(x,fs)
D = size(t,1);
tt = (0:D-1)'
e=interp1([0 0.1 0.8 1]*D,[0 1 0.1 0],tt,'linear');
x = e.*sin(2*pi*f0*t);
spectro(x,fs)
plot(x);
figure;
a = flip(x);
spectro(a,fs);
plot(a);