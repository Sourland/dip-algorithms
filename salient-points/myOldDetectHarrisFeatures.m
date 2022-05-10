function corners = myOldDetectHarrisFeatures(I)
%MYDETECTHARRISFEATURES searches and locates sallient points in an image
%using loops and windows - OUTDATED, SLOW, RUNTIME ~ 5-10 MINUTES
%   @param I the image
tic
    I = rgb2gray(I);
    [X, Y] = size(I);
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
    corners.Location = [];
    corners.Metric = [];
    corners.Count = 0;
    LayersOfFilteredImages = cat(3, cat(3,Ix2, Iy2), Ixy);
    for i = 100:11:X-100
        for j = 100:11:Y-100
            p = [i, j];
            if isCorner(LayersOfFilteredImages, p, k, Rthres)
                corners.Location = [corners.Location; p];
                x_sum = sum(Ix2(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
                y_sum = sum(Iy2(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
                xy_sum = sum(Ixy(p(1)-6:p(1)+6, p(2)-6:p(2)+6), 'all');
                M = [x_sum xy_sum;xy_sum y_sum];
                corners.Metric = [corners.Metric;det(M) - k*trace(M).^2];
                corners.Count = corners.Count + 1;
            end
        end
    end
    
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
    toc
end

