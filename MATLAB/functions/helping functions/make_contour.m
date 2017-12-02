function  C = make_contour(img)

I = imread(img);
G = rgb2gray(I);
C = imcontour(G);
figure,imshow(C);
end