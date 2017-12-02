% this program segments the objects from background using roipoly select

% INPUT = RGB color
clc;
clear ;
close all;

% inputs

FILENAME = 'desert.bmp';
OUTPUT_FILENAME = 'cig.JPG';

I = imread(FILENAME);
[BW ,xi,yi] = roipoly(I);

%%
I2 = I;
BW_i = find(BW~=1);
BW_i = BW_i.';

R = I2(:,:,1);
G = I2(:,:,2);
B = I2(:,:,3);

R(BW_i)=0;
G(BW_i)=0;
B(BW_i)=0;

I2(:,:,1) = R;
I2(:,:,2) = G;
I2(:,:,3) = B;

%%
p = patch('xData',xi,'yData',yi);
p.FaceColor = [1 1 1];
p.FaceAlpha = 0;
p.EdgeAlpha = 0;

% Hatching

hatchfill2(p,'HatchStyle','cross','HatchAngle',0);


%%
figure;
subplot(2,2,1),imshow(I);
subplot(2,2,2),imshow(BW);
subplot(2,2,3),imshow(I2);

imwrite(I2,OUTPUT_FILENAME);
