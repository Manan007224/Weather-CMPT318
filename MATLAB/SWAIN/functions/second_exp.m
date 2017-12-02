clc;
clear;
close all;


FILENAME1 = 'roll.bmp';
FILENAME2 = 'collection.bmp';

N = 10; % number of histogram bins

I = imread(FILENAME1);
J=I;
M = imread(FILENAME2);

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

[yr,x] = imhist(R);
[yg,x] = imhist(G);
[yb,x] = imhist(B);

figure;
plot(x,yr,'Red',x,yg,'Green',x,yb,'Blue');