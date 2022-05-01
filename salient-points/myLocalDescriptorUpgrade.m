function d = myLocalDescriptorUpgrade(I,p,rhom,rhoM,rhostep ,N)
%MYLOCALDESCRIPTOR Summary of this function goes here
%   Detailed explanation goes here
    [X, Y, ~] = size(I);
    d = [];
    for r = rhom:rhostep:rhoM
        x_rho = [];
        for theta = 0:(2*pi/N):2*pi
            [x, y] = getRealPos(p, theta ,r);
            if y >= 1 || y <= Y || x >= 1 || x <= X
                value = getColor(I, x, y, X, Y);
                x_rho = [x_rho; value];
            end
        end
        if ~isnan(mean(x_rho))
            d = [d; mean(x_rho)];
        end
    end
    
    
end

