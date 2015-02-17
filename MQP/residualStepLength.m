%Calculates the variance in the length of each step
%s is the number of steps
%t is the time
%l is the location of each step in the data rows
%len is the length (in meters) of the area
function rsl = residualStepLength(s,t,l,len)

c = averageCadence(s,t,l);
asl = averageStepLength(s,len);
v = gaitVelocity(c,asl);

timeOfStep = [t(l(1))];
stepLength = v*(timeOfStep(1) - 0);
stepLengthArray = [stepLength];

for i=2:s
    timeOfStep = [timeOfStep t(l(i))];
    stepLength = v*(timeOfStep(i) - timeOfStep(i-1));
    stepLengthArray = [stepLengthArray stepLength];
    
end

residual = asl - stepLengthArray(1);

for j=2:s
    difference = asl - stepLengthArray(j);
    residual = [residual difference];
end

rsl = sum(residual);

end
