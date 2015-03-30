Array=csvread('C:\Users\zparnold.ADMIN\Desktop\zachGait.csv',1,0);
time = Array(:, 1);
x = Array(:, 2);
y= Array(:, 3);
z= Array(:, 4);

newX=[time(2024:4047),x(2024:4047)];

%fftData=fft(x);

plot(time, [x, y, z])
%plot(time,x);
xlabel('blue=x,green=y,red=z');