%Names: Yang Zhang & Chenxu Wang
%Date: 09/07/2015
%This is the script to generate the sinusoids.

%begin of code
%Value of Parameters
f_0 = 10;
A1 = 1.5;
Phi1 = -pi/2;
A2 = 1.5;
Phi2 = pi/2;
A3 = 1.0;
Phi3 = pi;
A4 = 3.0;
Phi4 = 0;
N = 2;
n = 29;
%calculate T
T = 1/f_0
t = 0 : T/n : N*T;
%generate the figures with different values
figure(1)
subplot(2,2,1)
plot(cos(2*pi*f_0*t),'black')
hold on
plot(A1*cos(2*pi*f_0*t + Phi1),'red')
grid on
ylim([-2,2])
xlabel('time/seconds');
ylabel('y axis');
title(sprintf('two sinusoids, f_0 %d HZ A %d Phi %d',f_0,A,Phi))

subplot(2,2,2)
plot(cos(2*pi*f_0*t),'black')
hold on
plot(A2*cos(2*pi*f_0*t + Phi2),'red')
grid on
ylim([-2,2])
xlabel('time/seconds');
ylabel('y axis');
title(sprintf('two sinusoids, f_0 %d HZ A %d Phi %d',f_0,A,Phi))

subplot(2,2,3)
plot(cos(2*pi*f_0*t),'black')
hold on
plot(A3*cos(2*pi*f_0*t + Phi3),'red')
grid on
ylim([-2,2])
xlabel('time/seconds');
ylabel('y axis');
title(sprintf('two sinusoids, f_0 %d HZ A %d Phi %d',f_0,A,Phi))

subplot(2,2,4)
plot(cos(2*pi*f_0*t),'black')
hold on
plot(A4*cos(2*pi*f_0*t + Phi4),'red')
grid on
ylim([-2,2])
xlabel('time/seconds');
ylabel('y axis');
title(sprintf('two sinusoids, f_0 %d HZ A %d Phi %d',f_0,A,Phi))

%end of code