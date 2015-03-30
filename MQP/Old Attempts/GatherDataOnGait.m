%%
% Feature Extraction for Gait Data Analysis

%This script is used to determine number of steps as well as the rate of 
%steps.
count=0;
currentPeak=0;
lastPeak=0;
for i=1:length(mag1)
   if mag1(i)>2.75
       if(mag1(i-1)<mag1(i)&&mag1(i+1)<mag1(i))
       count=count+1;
       end
   end
end
count
rate=(count)./time1(length(time1))
dist=(2.6).*rate.*time1(length(time1))
totaltime1=time1(length(time1))


