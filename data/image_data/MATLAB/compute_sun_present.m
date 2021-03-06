tic
clc;
clear;
close all;

n=1;

FILEPATH = 'sun';
katkam = dir(strcat('./',FILEPATH));
SUN_LIST = zeros((size(katkam,1)-2) * 4,2);

counter=1;

for i=(3: size(katkam,1)) 
    
    image_filename = strcat(FILEPATH,'/',katkam(i).name);
    I = imread(image_filename); % colored-image
    b = im2bw(I,0.99);
    sky_mask = imread(strcat('masks/1.jpg'));
    b(sky_mask==0)=0;
    
    subplot(1,5,1),imshow(I);
    subplot(1,5,2),imshow(b);
    subplot(1,5,3),imshow(sky_mask);
    
    %%% creating mask for convolution 
    
    cs=15;   %generate disks of radius 13.5  (must always be something + 1/2)
    border=0;  %border to go around the disk
    ms=2*(cs+border);   %define masksize for circular disk. Must be odd.
    msh=floor(ms/2)+1;  %midway point to use as center
    mask=-ones(ms,ms);  %initialize mask with -1 everywhere

    for ii=1:ms
        for j=1:ms
            if (ii-msh)^2+(j-msh)^2<=cs^2 mask(ii,j)=1;
            end;
        end;
    end;
    subplot(1,5,4),imshow(mask);
    pause(0.5);
    
    convolved_image = conv2(mask,double(b));
    c = convolved_image-min(convolved_image(:));
    c=c/max(c(:));
    final = c;
    final(c<0.99)=0;
    final(c>0.99)=1;
    subplot(1,5,5),imshow(final);
    
    SUN_PRESENT = 0;
    
    if max(final(:))==1  
        SUN_PRESENT = 1;
    end
    SUN_PRESENT;
    SUN_LIST(counter,1) = i;
    SUN_LIST(counter,2) = SUN_PRESENT;
    counter = counter + 1;
end
csvwrite('SUB_PRESENT.csv',SUN_LIST);
toc