clear;clc;close all

img = imread('TestIm1.png');


%rotImg = myImgRotation(img, 15);
[M, N] = size(img)
for y = 1:M
    for x = 1:N
        [y x]
        getColor(img, y, x)
    end
end
image(rotImg)