function FINAL=get_hist(n,I,x,y) 
%   LEGENDS : n = no.of bins, I = image, x = minimum bin value, y = max bin value
    I1 = I(:,:,1);
    I2 = I(:,:,2);
    I3 = I(:,:,3);
    
    BIN = get_range(n,x,y);
    
    B1 = BIN;
    B2 = BIN;
    B3 = BIN;

    for i=(1:n)
        
        lower = BIN(i,1);
        upper = BIN(i,2);
        
        R = I1(I1>=lower & I1<upper);
        G = I2(I2>=lower & I2<upper);
        B = I3(I3>=lower & I3<upper);
        
        s_R = size(R,1);
        s_G = size(G,1);
        s_B = size(B,1);
        
        B1(i,3) = s_R;
        B2(i,3) = s_G;
        B3(i,3) = s_B;
        
    end
    FINAL = zeros([3 n]);
    
    FINAL(1,:) = B1(:,3).';
    FINAL(2,:) = B2(:,3).';
    FINAL(3,:) = B3(:,3).';

end