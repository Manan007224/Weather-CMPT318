function FINAL = get_range(r,l,u)


    L = linspace(l,u,r+1);
    L1 = floor(L);
    R = zeros([r 2]);
    for i=(1:r)
        R(i,1) = L1(i);
        R(i,2) = L1(i+1);
    end
    FINAL = R;
end