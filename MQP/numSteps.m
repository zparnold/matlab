function [s,l] = numSteps(x, y, z)

[mag] = sqrt(sum(x.^2+y.^2+z.^2,2));

%adjust for gravity
magNoG = mag-mean(mag);

%count stemps
minPeakHeight = std(magNoG);

[pks, locs] = findpeaks(magNoG, 'MinPeakHeight', minPeakHeight);

s = numel(pks)

l = locs

end