function pixel_labels=cluster(img_matrix)


cform = makecform('srgb2lab')
lab_he = applycform(img_matrix,cform)

ab = double(lab_he(:,:,2:3))
x = size(ab,1)
y = size(ab,2)

ab = reshape(ab,x*y,2)

ncolors=5
[cluster_idx cluster_center] = kmeans(ab,ncolors,'distance','sqEuclidean','Replicates',3)


pixel_labels = reshape(cluster_idx,x,y)
figure,imshow(pixel_labels,[])

end