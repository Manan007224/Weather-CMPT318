function v= ratio_histogram(A,B,j,N)
% A = model image(single) ; B = image


A_hist = get_hist(N,A,1,255);
B_hist = get_hist(N,B,1,255);


Ratio_hist = zeros(size(A));
Ratio_hist = A_hist./B_hist;
one_mat = ones(size(A_hist));
R = min(Ratio_hist,one_mat);
v = R(:,j);

end