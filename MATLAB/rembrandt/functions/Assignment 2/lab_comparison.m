% orange.jpg
% lab componenets 
img = imread('leaves.JPG')
lab_img = applycform(img,makecform('srgb2lab'))

% got the idea of l*a*b
% compares the original image and l*a*b components 

figure('Name','Original and l*a*b components ')
subplot(2,2,1),imshow(img),title('Original');
subplot(2,2,2),imshow(lab_img(:,:,1)),title('l*a*b(1)');
subplot(2,2,3),imshow(lab_img(:,:,2)),title('l*a*b(2)');
subplot(2,2,4),imshow(lab_img(:,:,3)),title('l*a*b(3)');

% choose the second component for the thresholding


BW = imbinarize(lab_img(:,:,3))
figure,imshow(BW),title('threshold of third lab comp')
imwrite(lab_img(:,:,3),'lab_theshold.jpg')
