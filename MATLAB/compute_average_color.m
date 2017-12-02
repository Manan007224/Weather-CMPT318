clc;
clear;
close all;

n=1;

katkam = dir('./KATKAM - Copy');
RGB_LIST = zeros((size(katkam,1)-2) * 4,5);

counter=1;
for i=(3: size(katkam,1))
    
    
            image_filename = strcat('KATKAM - Copy/',katkam(i).name);
            I = imread(image_filename); % colored-image
     		
            for j=(1:4)
                
                BW = imread(strcat('masks/',int2str(j),'.jpg'));
                BW = im2bw(BW,0.1);
                I2 = I;
                BW_i = find(BW~=1);
                BW_i = BW_i.';

                % PREPARING THE COLORED-SEGMENT
                R = I2(:,:,1);
                G = I2(:,:,2);
                B = I2(:,:,3);

                R(BW_i)=0;
                G(BW_i)=0;
                B(BW_i)=0;

                I2(:,:,1) = R;
                I2(:,:,2) = G;
                I2(:,:,3) = B;

                
                % COMPUTING AVERAGE COLOR
                a = average_color(I2);
                rgb = lab2rgb(a);
                
                patch = zeros([50 50 3]);
                
                patch(:,:,1) = rgb(1,1);
                patch(:,:,2) = rgb(1,2);
                patch(:,:,3) = rgb(1,3);
                
                
                % SAVE RGB DETAILS
                RGB_LIST(counter,1) = i;
                RGB_LIST(counter,2) = j;
                RGB_LIST(counter,3) = rgb(1,1);
                RGB_LIST(counter,4) = rgb(1,2);
                RGB_LIST(counter,5) = rgb(1,3);

                
                % VISUALIZE
                subplot(1,4,1),imshow(BW);
                subplot(1,4,2),imshow(I);
                subplot(1,4,3),imshow(I2);
                subplot(1,4,4),imshow(patch);
                pause(0.0001);
                counter=counter+1;
                
            end
    
 
            
end
csvwrite('KATKAM_colors.csv',RGB_LIST);

