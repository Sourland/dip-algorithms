function d = myLocalDescriptor(I,p,rhom,rhoM,rhostep ,N)
%MYLOCALDESCRIPTOR A rotational descriptor to descripe a neighborhood of a
%pixel using consecutive circles
%   @param I the image
%   @param p the pixel to describe
%   @param rhom the minimum radius of the descriptor
%   @param rhoM the maximum radius of the descriptor
%   @param rhoStep the tempo of radius growth
%   @param N how many rotation per circles

    [X, Y, ~] = size(I);
    d = [];
    for r = rhom:rhostep:rhoM
        x_rho = [];
        for theta = 0:(2*pi/N):2*pi
            [x, y] = getRealPos(p, theta ,r);
            if y >= 1 || y <= Y || x >= 1 || x <= X
                value =  getColor(I, x, y, X, Y, 'isGreyScale');
                x_rho = [x_rho; value];
            end
        end
        if ~isnan(mean(x_rho))
            d = [d; mean(x_rho)];
        end
    end
end
function [x, y] = getRealPos(p, theta, rho)
%GETREALPOS Summary of this function goes here
%   Detailed explanation goes here
    [x,y] = pol2cart(theta, rho);
    x = floor(x + p(1));
    y = floor(y + p(2));
end


