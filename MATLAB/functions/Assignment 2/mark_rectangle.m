function  mark_rectangle(img,arr,orig_img) % arr =  ccindex array
cc = bwconncomp(img);
r = regionprops(cc,'BoundingBox');
r_mat = cat(1,r.BoundingBox);

figure;
imshow(img);

hold on;
for i=1:size(arr,2)
    left = r_mat(arr(i),1)
    top = r_mat(arr(i),2)
    width = r_mat(arr(i),3)
    height = r_mat(arr(i),4)
    rectangle('Position',[left top width height],'EdgeColor','red','LineWidth',2);
    
    hold on;
end
end