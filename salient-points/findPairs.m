function pairs = findPairs(descriptor_im1, descriptor_im2, total_best_points)
%FINDPAIRS finds matching descriptors between two images
%   @param descriptor_im1 the descriptor of first image's salient points
%   @param descriptor_im2 the descriptor of seconds image's salient points
%   @param total_best_points how many pairs to find
    pairs = zeros(total_best_points,2);
    
    for i=1:total_best_points
        pairs(i,1) = i;
        vector1 = descriptor_im1(:,i);
        mse = [];
        for j=1:size(descriptor_im2, 2)
            vector2 = descriptor_im2(:,j);
            mse = [mse immse(vector1, vector2)];
        end
        [~, id_temp] = min(mse);
        tic
        while 1
            if any(ismember(pairs(:,2),id_temp),'all')
                mse(id_temp) = 1e9;
                [~, id_temp] = min(mse);
            else
                break
            end
            if toc > 10
                return
            end
        end
        pairs(i,2) = id_temp;
    end
end

