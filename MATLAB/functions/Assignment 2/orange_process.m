% preprocessing steps : 

orig_image = imread('orange.jpg');
figure,imshow(orig_image);
make_img = makecform('srgb2lab');
lab_img = applycform(orig_image,make_img);
figure,imshow(lab_img);
comp_lab_image = lab_img(:,:,2);
figure,imshow(comp_lab_image);

T = 0.55
img = im2bw(comp_lab_image,T);
figure,imshow(img);
img = imcomplement(img);
figure,imshow(img);


% finding ciagrette buds 
cs = comp_size(img) % contains numper of pixels for each identified connected components

% after finding out manually, I found at that range[2000,4000], it catches
% all three ciagrette buds 

cc_bud_index = find(cs>=1000 & cs<=4000); % finds out the ith connected component for ciagreet buds 

c1 = draw_comp(img,cc_bud_index(1))
c2 = draw_comp(img,cc_bud_index(2))
c3 = draw_comp(img,cc_bud_index(3))

% plots identified ciagrette buds 
figure;
subplot(1,3,1),imshow(c1);
subplot(1,3,2),imshow(c2);
subplot(1,3,3),imshow(c3);

S = regionprops(img,'Centroid');
c = cat(1,S.Centroid);

cig_1 = c(cc_bud_index(1),:)
cig_2 = c(cc_bud_index(2),:)
cig_3 = c(cc_bud_index(3),:)

figure;
subplot(1,3,1),imshow(cig_1(1),cig_2(2),'r.','marksize','20');
subplot(1,3,2),imshow(cig_2(1),cig_2(2),'r.','marksize','20');
subplot(1,3,3),imshow(cig_3(1),cig_3(2),'r.','marksize','20');


