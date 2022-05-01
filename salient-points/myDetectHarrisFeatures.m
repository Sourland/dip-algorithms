function corners = myDetectHarrisFeatures(I)
%MYDETECTHARRISFEATURES searches and locates sallient points in an image
%   @param I the image
    I = rgb2gray(I);
    [X, Y] = size(I);
    dx =[-1 0 1];
    dy = dx'; 
    Ix = conv2(double(I), dx, 'same');
    Iy = conv2(double(I), dy, 'same');
    sigma = 0.5;
    h = fspecial('gaussian', fix(sigma*6), sigma);
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.^Iy;
    k = 0.04;
    Rtresh = 1e3;
    gradientImage = cat(3,cat(3,Ix2, Iy2), Ixy); 
    
    for x = 1:X;
        for y = 1:Y
            p = [x y];
            if isCorner(gradientImage, p, k, Rtresh)
            
            end
        end
    end
    
end

