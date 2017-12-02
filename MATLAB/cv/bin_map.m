function FINAL = bin_map(I,R,r)
% LEGENDS : I(model image) , R(Ratio histogram)[1,n], r(range matrix)[n,2]

 
    m = I;
    
    for i=(1:size(R,2)) % ith bin
        
        null_mat = ones(size(I));
        l=r(i,1);
        u=r(i,2);
        lower = null_mat.* l;
        upper = null_mat.* u;        
        m(m>=lower & m<upper) = R(i);
        
    end

    FINAL = m; 

end