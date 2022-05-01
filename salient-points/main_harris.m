close all;clc;clear;
I_RGB = imread('TestIm1.png');
img = rgb2gray(I_RGB);

% [dx, dy] = meshgrid(-1:1, -1:1); %gradient masks
dx=[-1 0 1];
dy = dx';

Ix = conv2(double(img), dx, 'same');
Iy = conv2(double(img), dy, 'same');

sigma = 2;

h = fspecial('gaussian', 9, sigma); %gaussian filter

Ix2 = conv2(double(Ix.^2), h, 'same');
Iy2 = conv2(double(Iy.^2), h, 'same');
IxIy = conv2(double(Ix.*Iy), h, 'same');

 

R = (Ix2.*Iy2 - IxIy.^2) ./ (Ix2+Iy2);





