clc;
clear;
close all;

% INITIALIZATION ---------

FILENAME1 = 'soup.bmp'; % model (target) :  M
FILENAME2 = 'collection.bmp'; % image (collections)  : I

M = imread(FILENAME1); % M
I = imread(FILENAME2); % I

GI = double(rgb2gray(I));
GM = double(rgb2gray(M));
n = 10;
range_matrix = get_range(n,1,256);

% HISTOGRAMS ---------

I_hist = get_hist(n,GI,1,256); % dim = [1,n]
M_hist = get_hist(n,GM,1,256); % dim = [1,n]

r_hist = ratio_histogram(I_hist,M_hist); % dim = [1,n]

% BACKPROPAGATION ---------

X = bin_map(GI,r_hist,range_matrix);
figure;
imshow(X);


% MASKING --------- : implementation borrowed from circlefinder.m

cs=50;   
border=4;  
ms=2*(cs+border);   
msh=floor(ms/2)+1;  
mask=-ones(ms,ms);  

for i=1:ms
    for j=1:ms
        if (i-msh)^2+(j-msh)^2<=cs^2 
            mask(i,j)=1;
        end
    end
end
figure; imshow(mask)

% CONVOLUTION ---------

CONV = conv2(double(mask),X);
CONV1 = CONV-min(CONV(:)); CONV1=CONV1/max(CONV1(:));
figure;
imshow(CONV1);

% LOCATION COORDINATES ---------


p = find(CONV1==1);
final_I = zeros(size(I));
final_I(p)=1;
figure;
imshow(final_I);

% coordinates of the location found.
[xcenter ycenter] = find(final_I>0)





