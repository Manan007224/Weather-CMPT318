clc;
clear;
img_file = 'texture.JPG';


morph = 12;
threshold = 0.75;


noOfCiagrettes = 1;
color = 'mustard';
lower=10;
upper=4000;


% color = white | mustard

img = imread(img_file);
CURRENT_IMG=img;
figure,imshow(img);
I = img(:,:,1);


%morphVal = morph % average of morph observations
%se = strel('rectangle',[morphVal morphVal]);
%morph_I = imopen(CURRENT_IMG,se);
%CURRENT_IMG=morph_I;
%figure,imshow(CURRENT_IMG);


color_arr=[]
if strcmp(color,'white')
    color_arr = [1 0 0.1 0 1 0.9]
elseif strcmp(color,'mustard')
    color_arr = [45/360 35/360 0.7 0.6 0.7 0.5]
end

white_I = extract_color(CURRENT_IMG,color_arr);
CURRENT_IMG = white_I;
figure,imshow(CURRENT_IMG);


%medianVal = [5 20];
%median_I = medfilt2(I,medianVal);
%CURRENT_IMG=median_I;
%figure,imshow(median_I);


% morph opening






threshVal = threshold
thresh_I = im2bw(CURRENT_IMG,threshVal);

CURRENT_IMG = thresh_I;

cs = comp_size(CURRENT_IMG);

% filter 1 : if cc no of pixels lies in bound [lower,upper]


bud_ind = find(cs>=lower & cs<=upper)

% filter 2 : take n minimum differences (lowest e) of error

diff = rectangle_ratio(CURRENT_IMG)
diff = diff.'
diff_bud_ind = diff(bud_ind)
x = sort(diff_bud_ind)
cig_bud_diff = x(size(diff_bud_ind)-noOfCiagrettes+1 : end)
cig_bud_diff = cig_bud_diff.'

% credits : https://www.mathworks.com/matlabcentral/answers/22926-finding-the-indices-of-the-elements-of-one-array-in-another
% for arrayfun formula

cig_bud_index = arrayfun(@(x) find(diff==x,1),cig_bud_diff)
%mark_buds(thresh_I,bud_ind);
 mark_rectangle(CURRENT_IMG,bud_ind,img); % only filter1
 mark_rectangle(CURRENT_IMG,cig_bud_index,img); % both filter1 and filter2


%mark_buds(CURRENT_IMG,bud_ind);
%mark_buds(thresh_I,cig_bud_index);

figure;
subplot(1,3,1),imshow(img),title('Original');
subplot(1,3,2),imshow(I),title('Binary');
subplot(1,3,3),imshow(white_I),title('WhiteObjects');









