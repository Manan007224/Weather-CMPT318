function AVG_ELEM=average_color(J)
% I = 3d image in RGB

I = rgb2lab(J);

R1 = I(:,:,1);
G1 = I(:,:,2);
B1 = I(:,:,3);

R = R1(R1~=0);
G = G1(R1~=0);
B = B1(R1~=0);

mR = mean(R);
mG = mean(G);
mB = mean(B);


%AVG = [mR,mG,mB];
AVG_ELEM = [mR,mG,mB];



end