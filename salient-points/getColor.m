function color = getColor(img, x, y, X, Y)
%GETCOLOR Summary of this function goes here
%   Detailed explanation goes here
    xy = [x+1 y+1 ;...
          x+1 y-1 ;...
          x-1 y+1 ;...
          x-1 y-1 ];%pixel neighbours
              
    color = [];
    for i = 1:4
        if xy(i,1) >= 1 && xy(i,1) < X && xy(i,2) >= 1 && xy(i,2) < Y 
            color = [color;[img(xy(i,1), xy(i,2), 1) ...
                            img(xy(i,1), xy(i,2), 2) ...
                            img(xy(i,1), xy(i,2), 3)]];
        end
    end
    color = mean(color);
end

