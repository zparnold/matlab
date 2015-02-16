function numSteps = getSteps(x, y, z)
    mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
    
    %adjust for gravity
    magNoG = mag - mean(mag);
    
    %count steps
    minPeakHeight = std(magNoG);

    [pks, locs] = findpeaks(magNoG, 'MINPEAKHEIGHT', minPeakHeight);
   
    numSteps = numel(pks);
    
end

