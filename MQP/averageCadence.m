%Determines the average cadence for the person
%s is the number of steps
%t is the time
%l is the location of each step
function ac = averageCadence(s,t,l)

timeOfStep = [t(l(1))];
stepTime = timeOfStep(1) - 0;
stepTimeArray = [stepTime];

for i=2:s
    timeOfStep = [timeOfStep t(l(i))];
    stepTime = timeOfStep(i) - timeOfStep(i-1);
    stepTimeArray = [stepTimeArray stepTime];
    
end

totalTime = sum(stepTimeArray);

ac = s/totalTime;

end