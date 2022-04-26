function paddedImg = imagePad(img, angle)
    [X, Y, ~] = size(img); 
    
    R = [cosd(angle) sind(angle); ...
    sind(angle) cosd(angle)];
    padSize = abs(R)*[X;Y];
    X_pad_size = floor(padSize(1)) - X;
    Y_pad_size = floor(padSize(1)) - Y;
    
    XY_pad = zeros(floor(X_pad_size/2), floor(Y_pad_size/2), 3);
    X_pad = zeros(floor(X_pad_size/2), Y, 3);
    Y_pad = zeros(X, floor(Y_pad_size/2), 3);
    
    im1 = cat(2,cat(2,XY_pad, X_pad), XY_pad);
    
    im2 = cat(2, cat(2, Y_pad, img), Y_pad);
    paddedImg = cat(1,cat(1, im1, im2), im1);
end