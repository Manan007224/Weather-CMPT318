clc;
clear;
close all;

FILENAME = 'thresh.jpg';
OUTPUT_FILENAME = 'thresh_matrix.txt';
I = imread(FILENAME);
J = imbinarize(I);

output_image_matrix(J,OUTPUT_FILENAME);
