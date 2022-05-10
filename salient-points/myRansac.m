function H = myRansac(XYs, XYd, iter)
%Fits a dataset within another dataset and removes outliers
%   @param XYs the source dataset
%   @param XYd the destination dataset
%   @iter max iterations
    total_inliers = 0;
    H = [];
    for i = 1:iter
        ind = randperm(size(XYs,1));
        ind_s = ind(1:3);
        ind_r = ind(4:end);
        
        temp_H = homographyFit(XYs(ind_s,:), XYd(ind_s,:));
        predict = pixelTransform(XYs(ind_r,:),temp_H);

        dists = sum((XYd(ind_r,:) - predict).^2,2);

        inlier_idx = find(dists < 0.3);
        temp_inliers = length(inlier_idx);

        if temp_inliers > total_inliers && temp_H(1,1) <=1 && temp_H(1,2) <=1 ...
                && temp_H(2,1) <=1 && temp_H(1,2) <= 1
            H = temp_H;
            total_inliers = temp_inliers;
        end
    end
end

function XYd = pixelTransform(XY, H)
     XYd = [XY, ones(size(XY,1),1)] * H ;
     XYd = [XYd(:,1), XYd(:,2)];
end

function H = homographyFit(XYs, XYd)
    A = [XYs(1,1) XYs(1,2) 1 0;...
        XYs(1,2) -XYs(1,1) 0 1;...
        XYs(2,1) XYs(2,2) 1 0;...
        XYs(2,2) -XYs(2,1) 0 1;...
        XYs(3,1) XYs(3,2) 1 0;...
        XYs(3,2) -XYs(3,1) 0 1];
    
    b = [XYd(1,1);XYd(1,2);XYd(2,1);XYd(2,2);XYd(3,1);XYd(3,2)];
    opts1=  optimset('display','off');
    M = lsqr(A, b);
    H = [M(1) M(2) M(3);...
        -M(2) M(1) M(4);...
        0 0 1]';
end
