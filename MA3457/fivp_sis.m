% RHS of system of four 1st-order ODE-IVP 
%
function f_i_s=fivp_sys(x, z)
f_i_s = [z(2)
        z(2).*2.*x./(x.^2 + 1) - z(1).*2/(x.^2 + 1) + x.^2 + 1
        z(4)
        z(4).*2.*x./(x.^2 + 1) - z(3).*2/(x.^2 +1)];