%Ratio of high and low frequencies
function r = ratio(x,y,z)

sp = spectralPeaks(x,y,z);

numSP = length(sp);

totalSP = sum(sp);

averageSP = totalSP/numSP;

dev = std(sp);

high = [];
low = [];

for i=1:numSP
    if(sp(i) < (mean(sp)))
        low = [low sp(i)];
    elseif (sp(i) > (mean(sp)))
        high = [high sp(i)];
    end
end

r = sum(low)./sum(high);

end