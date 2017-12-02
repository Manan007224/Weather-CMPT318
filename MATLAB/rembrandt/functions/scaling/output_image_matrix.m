function output_image_matrix(I,OFILENAME)

% I = 2d image
size_X = size(I,1);
size_Y = size(I,2);

o_file = fopen(OFILENAME,'w');

fprintf(o_file,strcat('%d\n'),size_X);
fprintf(o_file,strcat('%d\n'),size_Y);

I2 = reshape(I.',[size_X*size_Y 1]);
fprintf(o_file,'%d\n',I2); 
   


end