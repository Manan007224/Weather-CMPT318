function FINAL=lab_segmentation(n,I)

    load regioncoordinates;
   
    nColors = n;
    sample_regions = false([size(I,1) size(I,2) nColors]); % 3d matrix; third dimension = color to be assigned

    for count = 1:nColors % sample_regions(:,:,n) contains coordinates for sample color space
      sample_regions(:,:,count) = roipoly(I,region_coordinates(:,1,count),...
                                          region_coordinates(:,2,count));

    end

    %imshow(sample_regions(:,:,2)),title('sample region for red');

    lab_fabric = rgb2lab(I);

    a = lab_fabric(:,:,2);
    b = lab_fabric(:,:,3);
    color_markers = zeros([nColors, 2]);

    for count = 1:nColors % take mean of a and b for 6 identified regions
      color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
      color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
    end

    % classify each pixel using k-means rule 

    color_labels = 0:nColors-1;

    a = double(a);
    b = double(b);
    distance = zeros([size(a), nColors]);

    % classification 

    for count = 1:nColors % calculates distance; distance is 3d matrix; third dimension is distance of each pixel from 
      distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                          (b - color_markers(count,2)).^2 ).^0.5;
    end

    [~, label] = min(distance,[],3);
    
    label = color_labels(label);
    clear distance;

    % k-means clustering

    rgb_label = repmat(label,[1 1 3]);
    segmented_images = zeros([size(I), nColors],'uint8');

    for count = 1:nColors
      color = I;
      color(rgb_label ~= color_labels(count)) = 0;
      segmented_images(:,:,:,count) = color;
    end
    FINAL=segmented_images;
end