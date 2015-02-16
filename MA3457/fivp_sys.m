% RHS of system of four 1st-order ODE-IVP 
%
function f_i_s=fivp_sys(x, z)
f_i_s = [z(2)
        (-2./x).*z(2)
        z(4)
        (-2./x).*z(4)];