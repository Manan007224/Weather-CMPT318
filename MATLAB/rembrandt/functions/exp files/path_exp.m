
clc;
clear ;
close all;

% inputs

FILENAME = 'desert_hill.JPG';


I = imread(FILENAME);
[BW ,xi,yi] = roipoly(I);

p = patch('xData',xi,'yData',yi);
p.FaceColor = [1 1 1];
p.FaceAlpha = 0;
p.EdgeAlpha = 0;

% Hatching

hatchfill2(p,'HatchStyle','cross','HatchAngle',0);

