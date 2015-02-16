f2 = fit(newTime,newX,'fourier8');
plot(f2,newTime,newX);
hold on
f3 = fit(newTime,newX,'smoothingspline');
plot(f3,'b');
hold on
f4 = fit(newTime,newX,'sin8');
plot(f4,'g');
hold off
legend( 'Data', 'Fourier', 'Spline','Sum of Sines')