clear all

k=(0.0001:0.0001:1);

for i=1:length(k)
   [x1, y1]=RK4(@(x,y)(k(i).*y.*(2010-y)),[0,30],10,300);
      if (y1(length(y1))>=19 && y1(length(y1))<=21)
          k(i)
      end
end