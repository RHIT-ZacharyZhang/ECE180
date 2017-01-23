%Plot a Lissajous curve
%parameter
p=0 : pi/100 : 2*pi
%x and y curves
x = sin(p);
y = cos(p);
y1 = cos(p);
y2 = cos(3*p);
y3 = cos(5*p);
%plot the curve in different windows
figure(1)
plot(x,y1)
hold on
figure(2)
plot(x , y2,'r.--')
axis square
grid on
xlabel('x')
ylabel('y')
title('Lissajous curve')
%adjust axis
a = axis
a([1 2]) = [-2 2];
axis(a);
%plot the curve using subplot
figure(3)
subplot(2,2,1)
plot(x,y1)
subplot(2,2,2)
plot(x , y2,'r.--')
subplot(2,2,4)
plot(x,y3)
axis square
grid on
xlabel('x')
ylabel('y')
title('Lissajous curve')