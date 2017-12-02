clc;
clear;
close all;


FILENAME1 = 'roll.bmp';
FILENAME2 = 'collection.bmp';

N = 10; % number of histogram bins

I = imread(FILENAME1);
J=I;
M = imread(FILENAME2);


Range_mat = get_range(N,1,255);

%%
% b(x,y) = R(h(c(x,y)))
MAP = map_to_bin(I,M,Range_mat);
figure;
imshow(MAP);
 
%%
%borrowed from circlefinder.m
cs=40;   %generate disks of radius 13.5  (must always be something + 1/2)
 %border to go around the disk
ms_y= size(MAP,1);
ms_x = size(MAP,2); %define masksize for circular disk. Must be odd.
msh_x = ms_x/2;
msh_y = ms_y/2 ;  %midway point to use as center
mask=zeros(ms_y,ms_x);  %initialize mask with -1 everywhere


MASK = zeros(size(MAP));
M1 = MASK(:,:,1);
M2 = MASK(:,:,2);
M3 = MASK(:,:,3);

MP1 = MAP(:,:,1);
MP2 = MAP(:,:,2);
MP3 = MAP(:,:,3);


for i=1:ms_y
    for j=1:ms_x
        if (i-msh_y)^2+(j-msh_x)^2<=cs^2 
            mask(i,j)=1;
            M1(i,j) = MP1(i,j);
            M2(i,j) = MP2(i,j);
            M3(i,j) = MP3(i,j);
        end;
    end;
end;
%mask(mask==0)=-1; 
figure;
imshow(mask);

MASK(:,:,1) = M1;
MASK(:,:,2) = M2;
MASK(:,:,3) = M3;

figure;
imshow(MASK);
figure;
imshow(MASK(:,:,1));


%%
x = conv2(double(MASK(:,:,1)),double(M(:,:,1)));

%x01 = x - min(x(:));
%x01 = x01/max(x01(:));
%%

y = conv2(double(MASK(:,:,2)),double(M(:,:,2)));
z = conv2(double(MASK(:,:,3)),double(M(:,:,3)));
%%
figure;
imshow(M);
CONV = zeros([size(x,1) size(x,2) 3]);
CONV(:,:,1) = x;
%CONV(:,:,2) = y;
%CONV(:,:,3) = z;
figure;

imshow(CONV);
%%
mm = max(CONV);
C1 = CONV(:,:,1);
C2 = CONV(:,:,2);
C3 = CONV(:,:,3);
C1(mm(:,:,1)) = 1;
C2(mm(:,:,2)) = 0;
C3(MM(:,:,3)) = 0;

CCONV = zeros(size(CONV));
CCONV(:,:,1) = C1;
CCONV(:,:,2) = C2;
CCONV(:,:,3) = C3;
figure;imshow(CCONV);



