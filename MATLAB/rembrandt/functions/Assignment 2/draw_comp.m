function r = draw_comp(img,i) %i = ith connected component % img = 2d image
conn_img = zeros([size(img,1) size(img,2)]);

cc = bwconncomp(img);
pl = cc.PixelIdxList{i}
mat = reshape(pl,[1 size(pl,1)]);

conn_img(mat)=1

figure,imshow(conn_img);
r = conn_img;
end