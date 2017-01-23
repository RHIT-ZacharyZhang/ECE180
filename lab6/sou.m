fs=5000;
Do = func(261.626,fs);
Re = func(293.665,fs);
Mi = func(329.628,fs);
Fa = func(349.228,fs);
So = func(392,fs);
La = func(440,fs);
Si = func(493.883,fs);
Do1 = func(523.251,fs);
y = [Do Re Mi Fa So La Si Do1]
spectro([y flip(y)],fs)