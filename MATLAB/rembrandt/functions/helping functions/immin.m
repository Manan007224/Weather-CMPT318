function A = immin(img,n) 
 % input binary image
I = imread(img)
J = imhmin(I,n)
figure;
subplot(1,3,1),imshow(I);
subplot(1,3,2),imshow(J);
A = imadjust(J)
subplot(1,3,3),imshow(A);
end