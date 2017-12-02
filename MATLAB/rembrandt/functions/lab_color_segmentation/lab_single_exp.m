
% This program creates lab sects and each sect is assigned a unique color
% code and stored in matrix SUM_MAT

clc;
clear;
close all;

FILENAME = 'skinlady.bmp';
I = imread(FILENAME);
n=6;
L = lab_segmentation(n,I);


figure;

ALL_MAT = zeros([size(I,1) size(I,2) n]);


K = scale_image(L(:,:,:,1));
SUM_MAT = zeros([size(K,1) size(K,2)]);

for i=(1:n)
    
    K = L(:,:,:,i);
    M = imbinarize(rgb2gray(K));
    SCALED_M = scale_image(M);
    
    N = SCALED_M * i;
    %ALL_MAT(:,:,i) = N;
    SUM_MAT = imadd(SUM_MAT,N);
    
    subplot(3,n,i),imshow(L(:,:,:,i));
    subplot(3,n,i+n),imshow(M);
    subplot(3,n,i+2*n),imshow(SCALED_M);
    
end
%translation_workflow(SUM_MAT,'final_matrix.txt')
print_two_dim_matrix(SUM_MAT,'final_matrix.txt')
