function [FINAL_X,FINAL_Y]=get_rect_coordinates(A)

rx = A(1);
ry = A(2);
rw = A(3);
rh = A(4);

x1 = rx;
x2 = rx+rw;
x3 = rx+rw;
x4 = rx;

y1 = ry+rh;
y2 = ry+rh;
y3 = ry;
y4 = ry;

FINAL_X = [x1;x2;x3;x4];
FINAL_Y = [y1;y2;y3;y4];
end