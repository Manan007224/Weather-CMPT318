% INTENSITY SEGMENT
% performance can be boost if averaging is done; so do the median smoothing


FILENAME = 'desert_hill.JPG';
I = imread(FILENAME);
G2 = rgb2gray(I);
G = medfilt2(G2);
n = 5;
L = get_range(n,1,255);
O = zeros([size(I) n]);

figure;
for i=(1:n)
    lower = L(i,1);
    upper = L(i,2);
    Seg = O(:,:,i);
    ind = find(G >=lower & G <upper)
    Seg(ind) = 1; 
    subplot(1,n,i),imshow(medfilt2(Seg));
end

