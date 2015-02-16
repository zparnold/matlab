%% file for generating features

flags = [Uphill(1),FrontofBody(1),TightClothes(1),HardShoes(1),InAttache(1)];
stepCount=0;

%make vars
    newX=0; newY=0; newZ=0;
%iterate over all data
for i=1:length(x)
    
    %are we still in the same experiment?
    check = [Uphill(i),FrontofBody(i),TightClothes(i),HardShoes(i),InAttache(i)];
    if (check == flags)
        newX(length(newX)+1) = x(i);
        newY(length(newY)+1) = y(i);
        newZ(length(newZ)+1) = z(i);
    else
        %make sure next time around we are still in the same experiment!
        flags = check;
        place = length(stepCount) + 1;
        
        %calulate the number of steps for each trial
        stepCount(place) = getSteps(newX',newY',newZ');
        
        %THIS IS WHERE YOU INSERT YOUR FUNCTIONS TO CALCULATE THE 
        %OTHER FEATURES

        %Reset vars for next iteration
        newX = 0;
        newY = 0;
        newZ = 0;
    end
end
