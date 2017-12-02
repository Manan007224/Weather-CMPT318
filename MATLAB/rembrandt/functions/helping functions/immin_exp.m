IMAGE='fill.jpg'
OUTPUT_NAME = 'fill_min.JPG'

A = immin(IMAGE,100);
imwrite(A,OUTPUT_NAME);