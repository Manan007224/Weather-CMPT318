clc;
clear;

BWIMAGE = 'bd.jpg';


COLORED_IMAGE = 'rocks.JPG'; 
MORPHED_IMAGE = 't1_fill.jpg' 

C = imread(COLORED_IMAGE);
M = imread(MORPHED_IMAGE);

L = watershed_segmentation(C,M);

