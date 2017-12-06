RGB = imread('decahedral.png');
I = rgb2gray(RGB);
I = imresize(I, [480,640]);

J = imgaussfilt(I,2.5);

BW1 = edge(J,'Sobel');
figure
imshow(BW1)

hex_data = binaryVectorToHex(BW1);

dlmwrite('results_hex',hex_data,'delimiter','');