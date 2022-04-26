clear;clc;close all

img = imread('TestIm1.png');
angle = 225;

tic
rotImg = myImgRotation(img, angle);
toc

imwrite(rotImg, append('rotated_img_',num2str(angle),'_deg.png'));
