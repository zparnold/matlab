function f = myObjective(x)
f = (1-x(1)).^2 + (x(2) - x(1).^2).^2;