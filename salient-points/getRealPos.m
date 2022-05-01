function [x, y] = getRealPos(p, theta, rho)
%GETREALPOS Summary of this function goes here
%   Detailed explanation goes here
    [x,y] = pol2cart(theta, rho);
    x = floor(x + p(1));
    y = floor(y + p(2));
end

