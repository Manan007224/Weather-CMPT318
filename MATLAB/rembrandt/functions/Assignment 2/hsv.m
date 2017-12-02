img = imread('ground.JPG');

hsv_img = rgb2hsv(img)
figure;
subplot(1,2,1),imshow(img);
subplot(1,2,2),imshow(hsv_img);

figure;
subplot(1,3,1),imshow(hsv_img(:,:,1));
subplot(1,3,2),imshow(hsv_img(:,:,2));
subplot(1,3,3),imshow(hsv_img(:,:,3));

