clc;
clear; 
close all;

FILENAME = 'all_shapes.jpg';
OUTPUT_IMAGE_FILENAME = 'all_shapes_final.jpg'
OUTPUT_FILENAME = 'MATRIX.txt';

M = 220;
N = 280;

I = imread(FILENAME);
J = rgb2gray(I);
J = imbinarize(J);
R = zeros(size(J));

m = size(J,1);
n = size(J,2); 

% rotation
if n>m
    R = J.';
    m = size(R,1);
    n = size(R,2); 
else
    R = J;
end


% scaling
k=1;
if (m>M && n>N)
    
    diff1 = M-m;
    diff2 = N-n;
    
    if diff1 > diff2
        k = N/n;
    elseif diff1 < diff2
        k = M/m;
    else % diff1 = diff2
        k = M/m; % take any
    end
    
    
elseif(m>M && n<N)
        k = M/m;
elseif(m<M && n>N)
        k = N/n;
elseif(m<M && n<N)
    diff1 = M-m;
    diff2 = N-n;
    
    if diff1 > diff2
        k = M/m;
    elseif diff1 < diff2
        k = N/n;
    else % diff1 = diff2
        k = M/m; % take any
    end
end

S = imresize(R,k);

S = imcomplement(S);
subplot(1,3,1),imshow(J),title('original')
subplot(1,3,2),imshow(R),title('rotated')
subplot(1,3,3),imshow(S),title('scaled')

imwrite(S,OUTPUT_IMAGE_FILENAME);

output_image_matrix(S,OUTPUT_FILENAME) ;
