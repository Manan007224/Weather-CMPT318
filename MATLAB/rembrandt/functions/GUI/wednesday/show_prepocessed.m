function show_prepocessed()
    global axes3
    New = imread('image_preprocessed.jpg');
    axes(axes3);
    set(axes3, 'Visible', 'on');
    imshow(New);