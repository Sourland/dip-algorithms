clear;clc;close all
addpath('src');
I = imread('TestIm1.png');
I_GREYSCALE = rgb2gray(I);
p = [100, 100];
q1 = [20.1, 25.5];
q2 = [202, 202];
rhom=5;
rhoM=20;
rhostep=1; 
N=8;

d_p = myLocalDescriptor(I_GREYSCALE, p, rhom, rhoM, rhostep, N);
d_p_upgrade = myLocalDescriptorUpgrade(I, p, rhom, rhoM, rhostep, N);

d_q1 = myLocalDescriptor(I_GREYSCALE, q1, rhom, rhoM, rhostep, N);
d_q1_upgrade = myLocalDescriptorUpgrade(I, q1, rhom, rhoM, rhostep, N);

d_q2 = myLocalDescriptor(I_GREYSCALE, q2, rhom, rhoM, rhostep, N);
d_q2_upgrade = myLocalDescriptorUpgrade(I, q2, rhom, rhoM, rhostep, N);