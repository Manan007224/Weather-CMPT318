% average color
clc;
clear;
close all;
FILENAME = 'man.jpg'; % rgb filenmae
I = imread(FILENAME);

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

m=3;
n=3;
alpha=2;

RM = medfilt2(R,alpha);
GM = medfilt2(G,alpha);
BM = medfilt2(B,alpha);

IM = false(size(I));
IM(:,:,1) = RM;
IM(:,:,2) = GM;
IM(:,:,3) = BM;

figure;
subplot(1,3,1),imshow(RM)
subplot(1,2,2),imshow(GM);
subplot(1,2,3),imshow(BM);

