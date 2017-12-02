function s=sharp_img(img) 
OFILENAME='sharp.jpg'
I = imread(img);
J = imsharpen(I);
imwrite(J,OFILENAME);
end