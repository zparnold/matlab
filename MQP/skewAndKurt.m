function [w,k] = skewAndKurt(x,y,z)

[mag] = sqrt(sum(x.^2+y.^2+z.^2,2));

%adjust for gravity
magNoG = mag-mean(mag);

w = skewness(magNoG);

k = kurtosis(magNoG);

end