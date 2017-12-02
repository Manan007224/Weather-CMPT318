clc;
clear;
close all;

FILENAME = 'desert.bmp';
I = imread(FILENAME);

i1 = I(:,:,1);
figure;
[X,h1] = contourf(i1);

i12 = medfilt2(i1);
figure;
[Y,h2] = contourf(i12);

hp1 = findobj(h1,'Type','patch');
hp2 = findobj(h2, 'Type' ,'patch');

hh1 = hatchfill(hp1,'single',-45,3);
hh2 = hatchfill(hp2,'cross',45,3);

