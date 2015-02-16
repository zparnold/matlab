clear m
m = mobiledev
m.AccelerationSensorEnabled=1;
m.Logging = 1;
go='start'
    pause(15);
    m.Logging = 0;
    
    %gather the data logged
    [a,t]=accellog(m);
    
    %separate by vector
    x = a(:,1);
    y = a(:,2);
    z = a(:,3);
    mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
    
    %adjust for gravity
    magNoG = mag - mean(mag);
    
    %count steps
    minPeakHeight = std(magNoG);

    [pks, locs] = findpeaks(magNoG, 'MINPEAKHEIGHT', minPeakHeight);
   
    numSteps = numel(pks)
    copy = [a mag magNoG t];