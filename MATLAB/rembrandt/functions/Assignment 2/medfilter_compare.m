function medfilter_compare(img)


subplot(2,3,1),imshow(img);
subplot(2,3,2),imshow(medfilt2(img(:,:,1),[3 3]));
subplot(2,3,3),imshow(medfilt2(img(:,:,1),[5 5]));
subplot(2,3,4),imshow(medfilt2(img(:,:,1),[7 7]));
subplot(2,3,5),imshow(medfilt2(img(:,:,1),[10 10]));
subplot(2,3,6),imshow(medfilt2(img(:,:,1),[20 20]));



end