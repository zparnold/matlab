%% function 

function ar = featuresForSingleStreamOfData(x,y,z,t)
%calulate the number of steps for each trial
retArray = [];

        [steps,loc] = numSteps(x,y,z);
        [skew,kurt] = skewAndKurt(x,y,z);
        cadence = averageCadence(steps,t,loc);
        retArray(length(retArray)+1) = steps;
        retArray(length(retArray)+1) = cadence;
        retArray(length(retArray)+1) = skew;
        retArray(length(retArray)+1) = kurt;
        retArray(length(retArray)+1) = gaitVelocity(cadence,steps);
        retArray(length(retArray)+1) = residualStepLength(steps,t,loc,15.1);
        retArray(length(retArray)+1) = ratio(x,y,z);
        retArray(length(retArray)+1) = residualStepTime(steps,t,loc);

        ar = retArray;
end