close all;clc;clear;

I_RGB = imread('TestIm1.png');
img = rgb2gray(I_RGB);
[X, Y] = size(img);
% [dx, dy] = meshgrid(-1:1, -1:1); %gradient masks
dx=[-1 0 1];
dy = dx';

Ix = conv2(double(img), dx, 'same');
Iy = conv2(double(img), dy, 'same');

sigma = 2;

h = fspecial('gaussian', 9, sigma); %gaussian filter

Ix2 = conv2(double(Ix.^2), h, 'same');
Iy2 = conv2(double(Iy.^2), h, 'same');
Ixy = conv2(double(Ix.*Iy), h, 'same');

 



