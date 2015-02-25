%% file for generating features

flags = [Uphill(1),FrontofBody(1),TightClothes(1),HardShoes(1),InAttache(1)];
stepCount=[]; faverageCadenceArray=[]; gaitVelocityArray=[]; residualStepLengthArray=[];
ratioArray=[]; residualStepTimeArray=[]; spectralPeaksArray=[];

%make vars
    newX=[]; newY=[]; newZ=[]; newT=[];
    lenx = length(x);

%set new last row to zeros to end the loop
Uphill(lenx+1) = 0;
FrontofBody(lenx+1) = 0;
TightClothes(lenx+1) = 0;
HardShoes(lenx+1) = 0;
InAttache(lenx+1) = 0;

%iterate over all data
for i=1:(lenx+1)
    
    %are we still in the same experiment?
    check = [Uphill(i),FrontofBody(i),TightClothes(i),HardShoes(i),InAttache(i)];
    if (check == flags)
        newX(length(newX)+1) = x(i);
        newY(length(newY)+1) = y(i);
        newZ(length(newZ)+1) = z(i);
        newT(length(newT)+1) = t(i);
    else
        nx = newX;
        ny = newY;
        nz = newZ;
        nt = newT;
        %make sure next time around we are still in the same experiment!
        flags = check;
        place = length(stepCount) + 1;
        
        %calulate the number of steps for each trial
        [steps,loc] = numSteps(newX',newY',newZ');
        [skew,kurt] = skewAndKurt(newX',newY',newZ');
        cadence = averageCadence(steps,newT',loc);
        stepCount(place) = steps;
        averageCadenceArray(place) = cadence;
        skewnessArray(place) = skew;
        kurtosisArray(place) = kurt;
        gaitVelocityArray(place) = gaitVelocity(cadence,steps);
        residualStepLengthArray(place) = residualStepLength(steps,newT',loc,15.1);
        ratioArray(place) = ratio(newX',newY',newZ');
        residualStepTimeArray(place) = residualStepTime(steps,newT',loc);
        spectralPeaksArray = [spectralPeaksArray 0 spectralPeaks(newX',newY',newZ')];
        

        %Reset vars for next iteration
        newX = [];
        newY = [];
        newZ = [];
        newT = [];
    end
end

newStepCount = stepCount';
newAverageCadence = averageCadenceArray';
newGaitVelocity = gaitVelocityArray';
newResidualStepLength = residualStepLengthArray';
newSkewness = skewnessArray';
newKurtosis = kurtosisArray';
newRatio = ratioArray';
newResidualStepTime = residualStepTimeArray';
