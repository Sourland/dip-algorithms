close all;clc;clear;
addpath('src');
I_RGB = imread('TestIm1.png');
I_RGB = myImgRotation(I_RGB, 360);
corners = myDetectHarrisFeatures(I_RGB);

pos = corners.Location;
[X,Y,~] = size(I_RGB); 
 for i = 1:length(pos)
    x = pos(i,1);
    y = pos(i,2);
    if x-2 > 0 && y-2 > 0 && x+2 <= X && y+2 <=Y
        for q = x-2:x+2
            for r = y-2:y+2
                I_RGB(q, r, :) = [255 0 0];
            end
        end
    end
 end
imwrite(I_RGB, 'SALIENT.png');



