%Calculates the variance in the time of each step
%s is the number of steps
%t is the time
%l is the location of each step
function rst = residualStepTime(s,t,l)

timeOfStep = [t(l(1))];
stepTime = timeOfStep(1) - 0;
stepTimeArray = [stepTime];

for i=2:s
    timeOfStep = [timeOfStep t(l(i))];
    stepTime = timeOfStep(i) - timeOfStep(i-1);
    stepTimeArray = [stepTimeArray stepTime];
    
end

totalTime = sum(stepTimeArray);

as = s/totalTime;

residual = as - stepTimeArray(1);

for j=2:s
    difference = as - stepTimeArray(j);
    residual = [residual difference];
end

rst = sum(residual);

end