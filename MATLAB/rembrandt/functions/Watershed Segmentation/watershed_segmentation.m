function L=watershed_segmentation(colored,morphed)
% morphed= fgm ,  colored = rg



% Calculating gradient of morphed image


gray_I = rgb2gray(colored);
sobelX = fspecial('sobel');
sobelY = sobelX';
Ix = imfilter(double(gray_I),sobelX,'replicate');
Iy = imfilter(double(gray_I),sobelY,'replicate');
gradient = sqrt(Ix.^2 + Iy.^2);
subplot(2,4,1),imshow(colored),title('Original RGB');
subplot(2,4,2),imshow(morphed),title('Morphed Image');
subplot(2,4,3),imshow(gradient,[]),title('Gradient Sobel');
L = gradient

% Caculating watershed of morphed image

I_bin = imbinarize(morphed);
[D,IDX] = bwdist(I_bin);
L = watershed(D);
subplot(2,4,4),imshow(L,[]),title('Watershed of morphed');

% ridge lines 
bgm = zeros(size(I_bin));
bgm(L==0) = 1;
subplot(2,4,5),imshow(bgm),title('Watershed ridge lines');

% overlap lines and foreground
I2 = gray_I(:,:,1);
I2(bgm==1)=255;
subplot(2,4,6),imshow(I2),title('Ridge lines on grayscale');

% gradience with imposemin
gradmag2 = imimposemin(gradient,bgm | bwareaopen(morphed,20) );
L2 = watershed(gradmag2);

I3 = gray_I(:,:,1);
I3(L==0) = 255;
%subplot(2,4,7),imshow(I3),title('');

% labelling for 

Lrgb = label2rgb(L,'jet','w','shuffle');

subplot(2,4,7),imshow(Lrgb),title('After LabelMatrix coloring');

end