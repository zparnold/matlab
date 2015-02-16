%%
% Starts datacollection for Mobile MATLAB and does simple feature
% calculation

%Open connection
connector on WPI2015;
disp('I will wait till you connect your phone, type "pause off" to continue.')
pause on;
pause;

%Make sure you connect your phone beore this step!
m = mobiledev;

if (m.Connected == 0)
    %The phone didn't connect properly, handle the error
    disp('I do not see a phone connected...try again.');
    m.disp;
    disp('When you get your phone connected, type "pause off" to continue.');
    pause on;
    pause;
else
    %Begin logging for 15 seconds
    m.AccelerationSensorEnabled = 1;
    
    pause on;
    pause;

    disp('Ready to go! Type "pause off" to continue.');

    m.Logging = 1;
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
    
    amplitudeVariance = 
    numSteps = numel(pks)
end

%clean up and end
m.AccelerationSensorEnabled = 0;

clear m;

