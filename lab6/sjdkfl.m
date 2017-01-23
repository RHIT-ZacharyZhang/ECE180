[x,fs] = audioread('hai.wav');
y = x(:);
a = flip(y);
spectro(a,fs)