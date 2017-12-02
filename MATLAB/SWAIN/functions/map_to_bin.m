function bin_mat=map_to_bin(I,M,R)


    N = size(R,1);
    bin_mat = double(zeros(size(I)));
    
    red = double(I(:,:,1));
    green = double(I(:,:,2));
    blue = double(I(:,:,3));
    
    size_X = size(I,1);
    size_Y = size(I,2);
 

    
    for i=(1:size(R,1)) % ith bin
        
        null_mat = ones([size_X size_Y]);
        
        l=R(i,1);
        u=R(i,2);
        
        lower = null_mat.* l;
        upper = null_mat.* u;
        
        r = ratio_histogram(I,M,i,N);
        %r(1)
        %r(2)
        %r(3)
        red(red>=lower & red<upper) = r(1);
        green(green>=lower & green<upper) = r(2);
        blue(blue>=lower & blue<upper) = r(3);
        
        
        bin_mat(:,:,1) = red;
        bin_mat(:,:,2) = green;
        bin_mat(:,:,3) = blue;
        
    end
    
    
end