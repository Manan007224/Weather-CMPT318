function IMG=get_white(img)



hsv_img = rgb2hsv(img);
%subplot(1,2,1),imshow(img);

H_UPPER=1;
H_LOWER=0;

S_UPPER=0.1;
S_LOWER=0;

V_UPPER=1;
V_LOWER=0.9;

H = hsv_img(:,:,1);
S = hsv_img(:,:,2);
V = hsv_img(:,:,3);

X = find(H<=H_UPPER & H>=H_LOWER & S<=S_UPPER & S>=S_LOWER & V<=V_UPPER & V>=V_LOWER)
IMG = zeros(size(img,1),size(img,2));
IMG(X)=1;
%subplot(1,2,2),imshow(IMG);

end
