function color = getColor(img, x, y, X, Y, greyOrRGB, rotateMode)
%GETCOLOR Get color of a pixel using its neighbours
%   @param img the image to source the color
%   @param x, y the coordinates of the pixel
%   @param X, Y the size of the image
%   @param greyOrRGB, rotateMode the mode of operation
    xy = [x+1 y+1 ;...
          x+1 y-1 ;...
          x-1 y+1 ;...
          x-1 y-1 ];%pixel neighbours
              
    color = [];
    
    if nargin == 6
        for i = 1:4
            if xy(i,1) >= 1 && xy(i,1) <= X && xy(i,2) >= 1 && xy(i,2) <= Y 
                color = [color; img(xy(i,1), xy(i,2))];
            end
        end
        color = floor(mean(color));
        if isnan(color)
            color = [];
        end
        return
    end 
    
    color = [];
    
    for i = 1:4
        if xy(i,1) >= 1 && xy(i,1) < X && xy(i,2) >= 1 && xy(i,2) < Y 
            color = [color;[img(xy(i,1), xy(i,2), 1) ...
                            img(xy(i,1), xy(i,2), 2) ...
                            img(xy(i,1), xy(i,2), 3)]];
        end
    end
    
    if nargin == 7
        color = mean(color);
    else
        color = mean(color, 2);
    end
    
    if isnan(color)
        color = [];
    end
    
       
end

