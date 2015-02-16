 %separate by vector
    x = a(:,1);
    y = a(:,2);
    z = a(:,3);
    mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
    
    %adjust for gravity
    magNoG = mag - mean(mag);