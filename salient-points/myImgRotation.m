function rotImg = myImgRotation(img, angle)
%MYIMGROTATION Rotates an image in a certain angle
%   @param img the image to be rotated
%   @param angle the angle to rotate the image
    [M, N] = size(img); %M for rows, N for columns
    R = [cosd(angle) -sind(angle); sind(angle) cosd(angle)];
    newSize = round(sqrt(M^2 + N^2 + 2*cos(angle)*N*M));
    rotImg = uint8(zeros(newSize, newSize,3));
    tic
    for i = 1:newSize
        for j = 1:newSize
            [x, y] = coordTransform(i, j, R, M, N);
            if y < 1 || y > M || x < 1 || x > N
                continue
            else
                rotImg(i, j, :) = getColor(img, y, x);
            end
        end
    end
    toc
    
    
end

