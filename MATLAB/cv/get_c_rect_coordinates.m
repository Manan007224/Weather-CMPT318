function [FINAL_X,FINAL_Y]=get_c_rect_coordinates(A)

rx = A(1);
ry = A(2);
rw = A(3);
rh = A(4);

x1 = rx-rh/2;
x2 = rx-rh/2;
x3 = rx+rh/2;
x4 = rx+rh/2;

y1 = ry-rw/2;
y2 = ry+rw/2;
y3 = ry+rw/2;
y4 = ry-rw/2;

FINAL_X=[x1;x2;x3;x4];
FINAL_Y=[y1;y2;y3;y4];

end