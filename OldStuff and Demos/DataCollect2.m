%%
% Starts datacollection for Mobile MATLAB and does simple feature
% calculation


m = mobiledev()

m.AccelerationSensorEnabled = 1;
%tell user to start
%pause(1);
[s, Fs] = audioread('MQP/ding.mp3');
sound(s,Fs);


m.logging = 1;
pause(15);
m.logging  = 0;

sound(s,Fs);

[a, t] = accellog(m);

copy = [a,t];
        
        
clear m;
    