function color = getColor(img, y, x)
%GETCOLOR Summary of this function goes here
%   Detailed explanation goes here
    [M, N] = size(img);
    xy = [x+1 y+1;...
          x-1 y+1;...
          x+1 y-1;...
          x-1 y-1]; %pixel neighbours
              
    color = [];
    for i = 1:4
        if ~(sum(xy(i,:) < 1) > 0 || sum(xy(i,:) > [N ,M]) > 0)
            color = [color;squeeze(img(xy(i,1),xy(i,2),:))'];
        end
    end
    color = mean(color);
end

