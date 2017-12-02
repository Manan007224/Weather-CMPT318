clc;
clear;
close all;

FILENAME = 'images/soup1.bmp';

I = imread(FILENAME)

figure,imshow(I);
g = get_im(rgb2gray(I),[23 101 94 37],[16 16 66 65]);
figure,imshow(g);