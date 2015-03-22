% Starts datacollection for Mobile MATLAB and does simple feature
% calculation
function dataCollection(weight,gender,drinks)

%prompt1 = 'Mass in Kg?\n';
%prompt2 = 'Gender?\n';
%prompt3 = 'Number of Drinks?\n';
%weight = input(prompt1);
%gender = input(prompt2,'s');
%drinks = input(prompt3);

m = mobiledev();

[y,Fs] = audioread('ding.mp3');
sound(y,Fs);
m.AccelerationSensorEnabled = 1;
m.logging = 1;
pause(12);
m.logging  = 0;
sound(y,Fs);

[a, t] = accellog(m);

copy = [a,t];

ar = featuresForSingleStreamOfData(a(:,1),a(:,2),a(:,3),t);

ar = [ar weight drinks];

dlmwrite('C:\Users\Zach\Documents\MATLAB\matlab\MQP\3212015DataCollection.csv',ar,'-append');

clear m
end