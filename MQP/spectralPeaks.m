function [sp,newMag] = spectralPeaks(x,y,z)

[mag] = sqrt(sum(x.^2+y.^2+z.^2,2));

%adjust for gravity
magNoG = mag-mean(mag);

newMag = real(fft(magNoG));

nMag = smooth(newMag);

%count stemps
minPeakHeight = std(nMag);

[pks, locs] = findpeaks(nMag, 'MinPeakHeight', minPeakHeight);

sp = pks';

end
