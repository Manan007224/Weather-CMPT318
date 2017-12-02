function IMG=extract_color(img,arr)

% arr = [h_u, h_l, s_u, s_l, v_u, v_l]

hsv_img = rgb2hsv(img);
%subplot(1,2,1),imshow(img);

H_UPPER=arr(1);
H_LOWER=arr(2);

S_UPPER=arr(3);
S_LOWER=arr(4);

V_UPPER=arr(5);
V_LOWER=arr(6);

H = hsv_img(:,:,1);
S = hsv_img(:,:,2);
V = hsv_img(:,:,3);
figure,imshow(H)
X = find(H<=H_UPPER & H>=H_LOWER & S<=S_UPPER & S>=S_LOWER & V<=V_UPPER & V>=V_LOWER)
IMG = zeros(size(img,1),size(img,2));
IMG(X)=1;
%subplot(1,2,2),imshow(IMG);

end
