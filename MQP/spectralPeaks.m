function [sp,newMag] = spectralPeaks(x,y,z)

[mag] = sqrt(sum(x.^2+y.^2+z.^2,2));

%adjust for gravity
magNoG = mag-mean(mag);

newMag = pwelch(magNoG);

%count stemps
minPeakHeight = std(newMag);

[pks, locs] = findpeaks(newMag, 'MinPeakHeight', minPeakHeight);

sp = pks';

end
