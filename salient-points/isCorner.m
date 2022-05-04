function [c, R] = isCorner(M, p, k, Rthres)
%ISCORNER returns TRUE if pixel is on an edge corner
%   @param I the image
%   @param p the pixel for examination
%   @param k a hyperparameter to calculate R
%   @param Rthresh the minimum R for p to be in a corner
    
    R = det(M) - k*trace(M).^2;
    c = false;
    if R > Rthresh
        c = true;
    end
    
end

