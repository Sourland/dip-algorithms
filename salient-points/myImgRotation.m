function rotImg = myImgRotation(img, angle)
%MYIMGROTATION Rotates an image in a certain angle
%   @param img the image to be rotated
%   @param angle the angle to rotate the image

    if angle == 0
        rotImg = img;
        return
    end
    
    img = imagePad(img, angle); %Image zero-padding
    [X, Y, ~] = size(img); % X for rows, Y for columns
    R = [cosd(angle) sind(angle) 0; ...
        -sind(angle) cosd(angle) 0; ...
        0 0 1];
    rotImg = uint8(zeros(X, Y, 3));
    for i = 1:X
        for j = 1:Y
            [x,y] = coordTransform(i, j, R, X, Y);
            if y < 1 || y > Y || x < 1 || x > X  
                continue
            else
                rotImg(i, j,:) = getColor(img, x, y, X, Y);
            end
        end
    end
end

