clc;
clear; 
close all;

FILENAME = 'all_shapes.jpg';
OUTPUT_FILENAME = 'new_shape_matrix.txt';

M = floor(175);
N = floor(220);

I = imread(FILENAME);
J = rgb2gray(I);

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
subplot(1,3,1),imshow(J),title('original');
subplot(1,3,2),imshow(R),title('rotated');
subplot(1,3,3),imshow(S),title('scaled');

OUT_S = imcomplement(imbinarize(S));
imwrite(OUT_S,'scaled_bin.jpg')
%%output_image_matrix(S,OUTPUT_FILENAME) 