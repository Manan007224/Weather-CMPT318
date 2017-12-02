function FINAL=get_hist(n,I,x,y) 
%   LEGENDS : n = no.of bins, I = grayscale image, x = minimum bin value, y = max bin value

    
    BIN = get_range(n,x,y);
    HIST = zeros(1,n);
    
    for i=(1:n)
        
        lower = BIN(i,1);
        upper = BIN(i,2);
        
        pixels = I(I>=lower & I<upper);
        pixel_size = size(pixels,1);

        HIST(1,i) = pixel_size;

        
        
    end
    FINAL = HIST;
    
    
    

end