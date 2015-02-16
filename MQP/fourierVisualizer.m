x =normV;      % Signal

y = fft(x);                               % Compute DFT of x
m = abs(y);                               % Magnitude
p = unwrap(angle(y));                     % Phase

f = (0:length(y)-1)*100/length(y);        % Frequency vector
subplot(2,1,1)
plot(f,m)
title('Magnitude')
subplot(2,1,2)
plot(f,p*180/pi)
title('Phase')
