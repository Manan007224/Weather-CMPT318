function differences = rectangle_ratio(img)  

    cc = bwconncomp(img);
    actual_area = regionprops(cc,'Area');
    actual_perimeter = regionprops(cc,'Perimeter');

    % actual
    a_area = cat(1,actual_area.Area);
    a_perimeter = cat(1,actual_perimeter.Perimeter);

    actual_ratio = double(double(a_area.')./double(a_perimeter.'));
    % theoretical

    r = regionprops(cc,'BoundingBox');
    r_mat = cat(1,r.BoundingBox);

    widths = r_mat(:,3);
    heights = r_mat(:,4);
    t_area = widths .* heights;
    t_perimeter = 2*(widths + heights);

    theoretical_ratio = double(double(t_area.')./double(t_perimeter.'));
    differences = actual_ratio - theoretical_ratio;
    
end