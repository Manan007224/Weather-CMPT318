clc;
clear;
close all;

FILENAME = 'tomatoes.bmp'
I = imread(FILENAME);
n=2;
L1 = lab_segmentation(n,I);
s1 = L1(:,:,:,1);
s2 = L1(:,:,:,2);
figure;
subplot(1,2,1),imshow(s1);
subplot(1,2,2),imshow(s2);

L2 = lab_segmentation(n,s2);
s3 = L2(:,:,:,1);
s4 = L2(:,:,:,2);

figure;
subplot(1,2,1),imshow(s3);
subplot(1,2,2),imshow(s4);

L3 = lab_segmentation(n,s4);
s5 = L3(:,:,:,1);
s6 = L3(:,:,:,2);

figure;
subplot(1,2,1),imshow(s5);
subplot(1,2,2),imshow(s6);

L4 = lab_segmentation(n,s6);
s7 = L4(:,:,:,1);
s8 = L4(:,:,:,2);

figure;
subplot(1,2,1),imshow(s7);
subplot(1,2,2),imshow(s8);