%% file for generating features
function script = NewScript(x,y,z,t,Uphill,FrontofBody,TightClothes,HardShoes,InAttache)

flags = [Uphill(1),FrontofBody(1),TightClothes(1),HardShoes(1),InAttache(1)];
stepCount=[]; averageCadenceArray=[]; gaitVelocityArray=[]; residualStepLengthArray=[];
ratioArray=[]; residualStepTimeArray=[]; spectralPeaksArray=[];

%make vars
    newX=[]; newY=[]; newZ=[]; newT=[];
%iterate over all data
for i=1:length(x)
    
    %are we still in the same experiment?
    check = [Uphill(i),FrontofBody(i),TightClothes(i),HardShoes(i),InAttache(i)];
    if (check == flags)
        newX(length(newX)+1) = x(i);
        newY(length(newY)+1) = y(i);
        newZ(length(newZ)+1) = z(i);
        newT(length(newT)+1) = t(i);
    else
        %make sure next time around we are still in the same experiment!
        flags = check;
        place = length(stepCount) + 1;
        
        %calulate the number of steps for each trial
        [steps,loc] = numSteps(newX',newY',newZ');
        cadence = averageCadence(steps,newT',loc);
        stepCount(place) = steps;
        averageCadenceArray(place) = cadence;
        gaitVelocityArray(place) = gaitVelocity(cadence,steps);
        %Length of hallway is currently hardcoded to 15.1
        % Fix for later versions
        residualStepLengthArray(place) = residualStepLength(steps,newT',loc,15.1);
        ratioArray(place) = ratio(newX',newY',newZ');
        residualStepTimeArray(place) = residualStepTime(steps,newT',loc);
        %spectralPeaks returns an array, must make array of arrays
        %spectralPeaksArray(place) = spectralPeaks(newX',newY',newZ');
        

        %Reset vars for next iteration
        newX = [];
        newY = [];
        newZ = [];
    end
end

end
