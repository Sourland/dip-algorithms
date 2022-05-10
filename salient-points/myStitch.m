function stitchImage = myStitch(sourceImage, destinationImage)
%MYSTITCH Stitches and merges two images with common ground
%   @param sourceImage the image to transform and merge
%   @param destinationImage independed image, constant


    sourceImageCorners = myDetectHarrisFeatures(sourceImage);
    destinationImageCorners = myDetectHarrisFeatures(destinationImage);
    
    total_best_points = floor(sourceImageCorners.Count/3);
    
    rhom=5;
    rhoM=20;
    rhostep=1; 
    N=8;
    sourceImageDescriptor = zeros(ceil((rhoM-rhom+1)/rhostep), sourceImageCorners.Count);
    destinationImageDescriptor = zeros(ceil((rhoM-rhom+1)/rhostep), destinationImageCorners.Count);

    for i = 1:sourceImageCorners.Count
    sourceImageDescriptor(:,i) = myLocalDescriptor(rgb2gray(sourceImage),sourceImageCorners.Location(i,:) ,rhom, rhoM, rhostep, N); 
    end

    for i = 1:destinationImageCorners.Count
        destinationImageDescriptor(:,i) = myLocalDescriptor(rgb2gray(destinationImage),destinationImageCorners.Location(i,:) ,rhom, rhoM, rhostep, N);     
    end

    pairs = findPairs(sourceImageDescriptor, destinationImageDescriptor, total_best_points);
    
    sourceSalientPoints = sourceImageCorners.Location(pairs(:,1),:);
    destinationSalientPoints = destinationImageCorners.Location(pairs(:,2),:);
    total_iterations = 5000;

    H = myRansac(sourceSalientPoints, destinationSalientPoints, total_iterations)

    rotImage = newImageRotation(sourceImage, H);
    [Xs, Ys, ~] = size(destinationImage);
    [Xr, Yr, ~] = size(rotImage);
    X_offset = ceil(H(3,1)/2) + 10 % 10 = ESTIMATION ERROR - FOUND MANUALLY!!
    Y_offset = ceil(H(3,2)) - 4 % -4 = ESTIMATION ERROR - FOUND MANUALLY!! 
    stitchImage = zeros(floor((Xs+Xr-X_offset)/2), floor((Ys+Yr-Y_offset)/2),3);
    stitchImage(X_offset:X_offset+Xr-1, Y_offset:Y_offset+Yr-1, :) = rotImage; 
    stitchImage(1:Xs, 1:Ys, :) = destinationImage;
end
function rotImg = newImageRotation(img, R)
   %Find the needed image size for the rotation and create new image
    [X, Y, ~] = size(img); % X for rows, Y for columns
    R_pad = R(1:2, 1:2);
    padSize = abs(R_pad)*[X;Y];
    rotImg = uint8(zeros(floor(padSize(1)), floor(padSize(2)), 3));
    [newX, newY, ~] = size(rotImg);
    
    %Start Coloring
    for i = 1:newX
        for j = 1:newY
            [x,y] = coordTransform(i, j, R_pad, newX, newY, X, Y);
            if y < 1 || y > Y || x < 1 || x > X  
                continue
            else
                rotImg(i, j,:) = getColor(img, x, y, X, Y, 'RGB', 'Rotate');
            end
        end
    end
end
function [x,y] = coordTransform(i, j, R, newX, newY, X, Y)
    midX = floor(newX/2);
    midY = floor(newY/2);
    x0 = floor(X/2);
    y0 = floor(Y/2);
    R = [R [0;0]];
    R = [R;0 0 1];
    T1 = [1 0 x0;...
          0 1 y0;...
          0 0 1];
    T2= [1 0 -midX;...
         0 1 -midY;...
         0 0 1];

    oldPixelPos = T1*R*T2*[i;j;1];
    x = floor(oldPixelPos(1));
    y = floor(oldPixelPos(2));
end

