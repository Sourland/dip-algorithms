function c = isCorner(LayersOfFilteredImages, p, k, Rthres)
%ISCORNER returns TRUE if pixel is on an edge corner
%   @param I the image
%   @param p the pixel for examination
%   @param k a hyperparameter to calculate R
%   @param Rthresh the minimum R for p to be in a corner
     
    Ix2 = LayersOfFilteredImages(:,:,1);
    Iy2 = LayersOfFilteredImages(:,:,2);
    Ixy = LayersOfFilteredImages(:,:,3);
    
    x_sum = sum(Ix2(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
    y_sum = sum(Iy2(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
    xy_sum = sum(Ixy(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
    
    M = [x_sum xy_sum;xy_sum y_sum];
    R = det(M) - k*trace(M).^2;
    
    if R > Rthres
        c = true;
    else
        c = false;
    end
    
end

