clear;clc;close all
addpath('src');
img = imread('TestIm1.png');

angle1 = 15;
angle2 = 225;

tic
rotImg = myImgRotation(img, angle1);
toc
figure()
image(rotImg);
imwrite(rotImg, append('rotated_img_',num2str(angle1),'_deg.png'));

% tic
% rotImg = myImgRotation(img, angle2);
% toc
% figure()
% image(rotImg);
% imwrite(rotImg, append('rotated_img_',num2str(angle2),'_deg.png'));


