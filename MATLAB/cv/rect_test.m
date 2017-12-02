clc;
clear;
close all;

I = zeros([500 500]);
center_x = 250;
center_y = 250;
I(250,250)=255;
figure;
subplot(1,2,1),imshow(I)
[RX,RY] = get_c_rect_coordinates([center_x center_y 50 50]);

for i=1:4
    I(floor(RX(i)),floor(RY(i)))=255;
end

subplot(1,2,2),imshow(I);