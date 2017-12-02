% CREATE ROICOLOR TRANSFORMATION
clc;
clear;
close all;

FILENAME = 'desert.bmp';
OUTPUT_FILENAME = 'desert_sky';
I = imread(FILENAME);


%%
L = lab_segmentation(3,I);
figure;
subplot(1,2,1),imshow(L(:,:,:,1));
subplot(1,2,2),imshow(L(:,:,:,2));
subplot(1,2,3),imshow(L(:,:,:,3));

%imwrite(BWC,OUTPUT_FILENAME);
%%
[X,map]  = rgb2ind(I,500);
subplot(1,2,1),imshow(X,map);


BWC = roicolor(X,50,100);
subplot(1,2,2),imshow(BWC);
imwrite(BWC,OUTPUT_FILENAME);
