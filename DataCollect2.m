%%
% Starts datacollection for Mobile MATLAB and does simple feature
% calculation


m = mobiledev();

m.AccelerationSensorEnabled = 1;
m.logging = 1;
pause(15);
m.logging  = 0;

[a, t] = accellog(m);

copy = [a,t];
        
        
clear m;
    