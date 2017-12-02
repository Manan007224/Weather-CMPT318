clc;
clear;
close all;

FILENAME = 'p1.jpg';
I = imread(FILENAME);

Range_mat = get_range(10,1,255);
Map_mat = map_to_bin(I,Range_mat);
m = Map_mat(:,:,3);

%% 
clc;
clear;
close all;

a = [1 1 2 2 3 3 4 4 5 5 5 5 5 5 5];
b = meshgrid(a,a);

B(:,:,1) = b;
B(:,:,2) = b;
B(:,:,3) = b;

B
Range_mat = get_range(2,1,6);
map_mat = map_to_bin(B,Range_mat);
