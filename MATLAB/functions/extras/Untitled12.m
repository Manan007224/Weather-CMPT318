myImage = imread('desert.bmp');
set(handles.axes7,'Units','pixels');
resizePos = get(handles.axes7,'Position');
myImage= imresize(myImage, [resizePos(3) resizePos(3)]);
axes(handles.axes7);
imshow(myImage);
set(handles.axes7,'Units','normalized');