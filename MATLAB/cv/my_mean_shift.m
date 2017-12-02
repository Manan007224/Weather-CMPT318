clc;
clear;
close all;


cam = webcam('Logitech HD Webcam C525');
previous_frame = rgb2gray(snapshot(cam));
P=previous_frame;
figure,imshow(previous_frame);
hold on;
[m_x,m_y] = ginput(4);
e_image = get_im(P,m_x,m_y);
figure;
subplot(1,2,1),imshow(previous_frame);
subplot(1,2,2),imshow(e_image);
figure;

for idx=1:400
    
    current_frame = snapshot(cam);
    current_gray_frame = double(rgb2gray(current_frame));
    
    
    loc_obj = find_loc(previous_frame,e_image,10,57);
    
    subplot(2,1,1),imshow(current_frame);
    subplot(2,1,2),imshow(loc_obj);
    previous_frame = current_gray_frame;
    
    hold on;
    
end