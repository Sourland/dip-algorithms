function c = myIsCorner(LayersOfFilteredImages, k, Rthres)
%ISCORNER returns TRUE if pixel is on an edge corner
%   @param LayersOfFilteredImage the gradients of image
%   @param k a hyperparameter to calculate R
%   @param Rthresh the minimum R for p to be in a corner
    
    Ix2 = LayersOfFilteredImages(:,:,1);
    Iy2 = LayersOfFilteredImages(:,:,2);
    Ixy = LayersOfFilteredImages(:,:,3);
    
    R = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
    
    c = R > Rthres;
end

