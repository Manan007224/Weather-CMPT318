clc;
clear;
close all;

FILENAME1 = 'images/sweater.bmp';
FILENAME2 = 'images/collection.bmp';
I = imread(FILENAME2); % collection image
M = imread(FILENAME1); % model image
GI = rgb2gray(I);
GM = rgb2gray(M);
n=10;
R=57;

%[x y] = ginput(4);
f = find_loc(GI,GM,n,R,0);
%ix = floor(f(1));
%iy = floor(f(2));
%J = double(zeros(size(GI)));
%J(ix,iy)=1;

figure,imshow(f)
