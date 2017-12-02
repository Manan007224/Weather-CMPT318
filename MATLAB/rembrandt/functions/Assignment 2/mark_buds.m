function mark_buds(img,arr) % arr =  ccindex array
cc = bwconncomp(img);
r = regionprops(cc,'Centroid');
r_mat = cat(1,r.Centroid);

figure;
imshow(img);
hold on;

for i=1:size(arr,2)
    x = r_mat(arr(i),1);
    y = r_mat(arr(i),2);
    plot(x,y,'r.','MarkerSize',20);
    hold on;
end


end