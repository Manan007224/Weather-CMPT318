% SMOOTHING FILTERS

FILENAME = 'b1.jpg'
I = imread(FILENAME);

% GAUSSIAN FILTER

alpha=2
J1 = imgaussfilt(I,alpha);
OUTPUT_GAUSS = 'gauss.jpg'
imwrite(J1,OUTPUT_GAUSS);

% MEDIAN FILTER

J2 = medfilt2(I)
OUTPUT_MEDIAN = 'median.jpg'
imwrite(J2,OUTPUT_MEDIAN);

