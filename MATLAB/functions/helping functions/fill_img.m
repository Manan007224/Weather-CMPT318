function J=fill_img(img) 
O_FILENAME='fill.jpg';
I = imread(img);
J = imfill(I);
imwrite(J,O_FILENAME);
end