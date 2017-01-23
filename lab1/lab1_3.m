%% First Section
%first step
a = [1 2 3 4];
b = 10;

%last step
c = a + b;

%finished
disp('all done!')

%% Second Section
% Creat a Lissajous Curve
x = 0 :pi/100 : 2*pi;
plot(sin(2*x), cos(3*x));
axis square
% Finished