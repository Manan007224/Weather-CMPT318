clc;
clear;
close all;

FILENAME = 'CMPT412_blackcup.mat';
load('CMPT412_blackcup.mat');





previous_frame = blackcup(:,:,:,1);
previous_gray_frame = rgb2gray(previous_frame);

figure,imshow(previous_gray_frame);
hold on;
[mx,my] = ginput(4);
e_image = get_im(previous_gray_frame,mx,my);
ex = size(e_image,1);
ey = size(e_image,2);

R=40; % random guess

if ex>ey
    R=ex/2;
elseif ey>ex
    R=ey/2;
end

f = find_loc(previous_gray_frame,e_image,10,R,1);
px = floor(f(1));
py = floor(f(2));




for i=(1:40)
    pause(0.01);
   
    % get new centers
    f = find_loc(previous_gray_frame,e_image,10,R,1);
    px = floor(f(1));
    py = floor(f(2));
    L = find_loc(previous_gray_frame,e_image,10,R,0);
    subplot(1,3,2),imshow(L),title('Peaks in frame for model Image');
    subplot(1,3,1),imshow(previous_gray_frame),title('GrayFrame');
    hold on;
    
    current_frame = blackcup(:,:,:,i);
    current_gray_frame = rgb2gray(current_frame);
    hold on;
    
    % with new px,py center, extract new e_image (modelimage) 
    rec_arg=[px-ex/2 py-ey/2 ex ey];
    Rec = rectangle('Position',rec_arg, 'EdgeColor','red');
    [e_next_x,e_next_y] = get_c_rect_coordinates(rec_arg);
    
    e_image = get_im1(current_gray_frame,floor(e_next_x),floor(e_next_y));
    e_peak = max(e_image(:));
    
    subplot(1,3,3),imshow(e_image),title('model Image');
    

    previous_gray_frame = current_gray_frame;
   
    
    
end





