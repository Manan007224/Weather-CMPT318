clc;
clear;
close all;


% for this, try I have setup the webcam and experimented. Please do the
% same for the results
cam = webcam('Logitech HD Webcam C525');
% extracting figure

previous_frame = rgb2gray(snapshot(cam));
P=previous_frame;


% acuire model image
figure,imshow(previous_frame);
hold on;
[m_x,m_y] = ginput(4);
e_image = get_im(P,m_x,m_y);
ex = size(e_image,1);
ey = size(e_image,2);

R=40; % random guess

if ex>ey
    R=ex/2;
elseif ey>ex
    R=ey/2;
end

figure;
%subplot(1,2,1),imshow(previous_frame),title('Image');
%subplot(1,2,2),imshow(e_image),title('Model');

pause(2);
figure;
for idx=1:400
    % define
    
    current_frame = snapshot(cam);
    current_gray_frame = double(rgb2gray(current_frame));
    
    % current center
    l = find_loc(previous_frame,e_image,10,R,0);
    
   
    
    subplot(1,2,1),imshow(l),title('Peak found');
    subplot(1,2,2),imshow(previous_frame);
    
    
    previous_frame = current_gray_frame;
     
    
    
end
clear('cam');
close all;
