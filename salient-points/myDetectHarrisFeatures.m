function corners = myDetectHarrisFeatures(I)
%MYDETECTHARRISFEATURES searches and locates sallient points in an image
%   @param I the image
    img = rgb2gray(I);
    [X, Y] = size(img);
    dx =[-1 0 1];
    dy = dx'; 
    Ix = conv2(double(img), dx, 'same');
    Iy = conv2(double(img), dy, 'same');
    sigma = 2;
    GaussianMask = fspecial('gaussian', 9, sigma);
    
    Ix2 = conv2(double(Ix.^2), GaussianMask,'same');
    Iy2 = conv2(double(Iy.^2), GaussianMask,'same');
    Ixy = conv2(double(Ix.*Iy), GaussianMask, 'same');
    
    k = 0.04;
    Rthres = 1e3;
    LayersOfFilteredImages = cat(3,cat(3,Ix2, Iy2), Ixy); 
    E = zeros(X,Y);
    corners = [];
    for x = 2:1:X-1
        for y = 2:1:Y-1
            x_sum = sum(Ix2(x-1:x+1, y-1:y+1), 'all');
            y_sum = sum(Iy2(x-1:x+1, y-1:y+1), 'all');
            xy_sum = sum(Ixy(x-1:x+1, y-1:y+1), 'all');
            M = [x_sum xy_sum;xy_sum y_sum];
            E(x, y) = min(eig(M));
            [found_corner, R] = isCorner(M, k, Rthres);
            if found_corner
                corner.location = p;
            end
                
                
        end
    end
end

