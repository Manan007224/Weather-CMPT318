function R=ratio_histogram(A_hist,B_hist)
% A = model image(single) ; B = image


Ratio_hist = double(zeros(size(A_hist)));
Ratio_hist = double(B_hist./A_hist);
one_mat = ones(size(A_hist));
R = min(Ratio_hist,double(one_mat));


end