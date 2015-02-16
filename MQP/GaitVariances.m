[peaks,locs]=findpeaks(mag,'minpeakheight',2.5);
[peaks1,locs1]=findpeaks(mag10,'minpeakheight',2.5);
stretchVariance = mean(peaks)-mean(peaks1)
for i = 2:length(locs)
    dist(i,1)= time10(locs(i))-time(locs(i-1));
end
for i = 2:length(locs1)
    dist1(i,1)= time10(locs1(i))-time(locs1(i-1));
end
distVariance = mean(dist)-mean(dist1)