clc;
clear;
close all;

FILENAME = 'rain.jpg'
I = imread(FILENAME);
n=5;
L = lab_segmentation(n,I);


figure;
subplot(2,3,1),imshow(L(:,:,:,1))
subplot(2,3,2),imshow(L(:,:,:,2))
subplot(2,3,3),imshow(L(:,:,:,3))
subplot(2,3,4),imshow(L(:,:,:,4))
subplot(2,3,5),imshow(L(:,:,:,5))
