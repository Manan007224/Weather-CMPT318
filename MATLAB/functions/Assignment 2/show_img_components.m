function show_img_components(img_file) 
img = imread(img_file)

img1 = img(:,:,1)
img2 = img(:,:,2)
img3 = img(:,:,3)

figure,
subplot(1,4,1),imshow(img);
subplot(1,4,2),imshow(img1);
subplot(1,4,3),imshow(img2);
subplot(1,4,4),imshow(img3);
end