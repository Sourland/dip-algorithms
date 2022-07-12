clear;clc;close all;
addpath('src');
Image1 = imread('TestIm1.png');
Image1 = myImgRotation(Image1, 360);
Image2 = imread('TestIm2.png');
Image2 = myImgRotation(Image2, 360);
warning off
tic

stitchedImage = uint8(myStitch(Image2, Image1));
toc
imwrite(stitchedImage, 'STITCHED.png');