function FINAL = find_loc(I,M,n,rad,d)



    GI = double(I);
    GM = double(M);
    range_matrix = get_range(n,1,256);

    % HISTOGRAMS ---------

    I_hist = get_hist(n,GI,1,256); % dim = [1,n]
    M_hist = get_hist(n,GM,1,256); % dim = [1,n]

    r_hist = ratio_histogram(I_hist,M_hist); % dim = [1,n]

    % BACKPROPAGATION ---------

    X = bin_map(GI,r_hist,range_matrix);
    %figure;
    %imshow(X);


    % MASKING --------- : implementation borrowed from circlefinder.m

    cs=rad;   
    border=4;  
    ms=2*(cs+border);   
    msh=floor(ms/2)+1;  
    mask=-ones(ms,ms);  

    for i=1:ms
        for j=1:ms
            if (i-msh)^2+(j-msh)^2<=cs^2 
                mask(i,j)=1;
            end
        end
    end
    %figure; imshow(mask)

    % CONVOLUTION ---------

    CONV = conv2(double(mask),X);
    CONV1 = CONV-min(CONV(:)); CONV1=CONV1/max(CONV1(:));


    % LOCATION COORDINATES ---------
    % MEAN SHIFT SHOULD COME HERE : RETURNS PEAK POINT

    high_vals = find(CONV1>0.9);
    high_val_mat = double(zeros(size(CONV1)));
    high_val_mat(high_vals)=1;

    % find centroid of this peak group 

    S = regionprops(high_val_mat,'centroid');
    centroid = cat(1,S.Centroid);
    x_c=1;
    y_c=1;

    if isempty(centroid)
        x_c=1;
        y_c=1;
    else
        x_c = centroid(1);
        y_c = centroid(2);
    end

    %OUTPUT

    FINAL=0;
    if d==1

        FINAL = [x_c,y_c]; % output centroid coordinates of first group.

    elseif d==0

        FINAL = high_val_mat; % output peak group
    end



end



