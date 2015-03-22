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
retArray(length(retArray)+1) = residualStepLength(steps,t,loc,13);
retArray(length(retArray)+1) = ratio(x,y,z);
retArray(length(retArray)+1) = residualStepTime(steps,t,loc);

mag = (x.^2+y.^2+z.^2);
magNoG = mag - mean(mag);
retArray(length(retArray)+1) = bandpower(magNoG);
retArray(length(retArray)+1) = snr(magNoG);
retArray(length(retArray)+1) = thd(magNoG);

ar = retArray;


end