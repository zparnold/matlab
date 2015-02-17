%% file for generating features

flags = [Uphill(1),FrontofBody(1),TightClothes(1),HardShoes(1),InAttache(1)];
stepCount=[]; averageCadenceArray=[]; gaitVelocityArray=[]; oneStepLengthArray=[];
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
        [s,l] = numSteps(newX',newY',newZ');
        stepCount(place) = s;
        averageCadenceArray(place) = averageCadence(s,t,l);
        %gaitVelocityArray(place) = gaitVelocity(newX',newY',newZ');
        %oneStepLengthArray(place) = oneStepLength(newX',newY',newZ');
        %%ratioArray(place) = ratio(newX',newY',newZ');
        %residualStepTimeArray(place) = residualStepTime(newX',newY',newZ');
        

        %Reset vars for next iteration
        newX = [];
        newY = [];
        newZ = [];
    end
end
