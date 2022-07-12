function corners = myDetectHarrisFeatures(I)
%MYDETECTHARRISFEATURES searches and locates sallient points in an image
%   @param I the image
    I = rgb2gray(I);
    I = im2double(I);
    dx =[-1 0 1;...
        -1 0 1;...
        -1 0 1];
    dy = dx'; 
    Ix = conv2(double(I), dx, 'same');
    Iy = conv2(double(I), dy, 'same');
    sigma = 1;
    GaussianMask = fspecial('gaussian', 5, sigma);
    
    Ix2 = conv2(double(Ix.^2), GaussianMask,'same');
    Iy2 = conv2(double(Iy.^2), GaussianMask,'same');
    Ixy = conv2(double(Ix.*Iy), GaussianMask, 'same');
    
    k = 0.04;
    Rthres = 0.01;
    radius = 1;
    order = 2*radius+1;
    
    R = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
    mx = ordfilt2(R, order^2, ones(order));
    LayersOfFilteredImages = cat(3, cat(3,Ix2, Iy2), Ixy); 
    R2 = (R==mx) & myIsCorner(LayersOfFilteredImages, k, Rthres);
    
    [x,y] = find(R2);
    corners.Location = [x y];
    idx=sub2ind(size(R),x,y);
    corners.Metric = R(idx);
    [corners.Metric, pos] = sort(corners.Metric,'descend');
    corners.Location = corners.Location(pos,:);
    corners.Count = length(corners.Location);
    
end

