function min_h(img,n)
I1 = imread(img);
I = imhmin(I1,n);
figure;
subplot(1,2,1),imshow(I1);
subplot(1,2,2),imshow(I);
imwrite(I,'min_h.jpg');
end