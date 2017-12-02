clc;
clear;
close all;


IMAGE_FILENAME = 'all_shapes_final.jpg';
OUTPUT_FILENAME = 'all_shapes_final_matrix.txt'
OUTPUT_FILE = fopen(OUTPUT_FILENAME,'w');
I = imbinarize(imread(IMAGE_FILENAME)); %% binary image

M = size(I,1);
N = size(I,2);

for i=(1:M)
    for j=(1:N)
        elem = I(i,j);
        fprintf(OUTPUT_FILE,'%d,',elem);
    end
    fprintf(OUTPUT_FILE,'\n');
end