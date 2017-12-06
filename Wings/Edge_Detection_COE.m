RGB = imread('batman.png');
imshow(RGB)
I = rgb2gray(RGB);

width = 640;
height = 480;
I = imresize(I, [height, width]);

J = imgaussfilt(I,2.5);

BW1 = edge(J,'Sobel');

% flattened_BW1 = zeros(1,width*height);
% i = 1;
% for y = 1:height
%     for x = 1:width
%         if (BW1(y,x) == 0)
%             flattened_BW1(i) = 000;
%         else
%             flattened_BW1(i) = 001;
%         end
%         i = i+1;
%     end
% end
% 
% data = dec2bin(flattened_BW1, 3);
% 
% %open a file
% output_name = 'batman.coe';
% file = fopen(output_name,'w');
% 
% %write the header info
% fprintf(file,'memory_initialization_radix=2;\n');
% fprintf(file,'memory_initialization_vector=\n');
% fclose(file)
% 
% %put commas in the data
% rowxcolumn = size(data);
% rows = rowxcolumn(1);
% columns = rowxcolumn(2);
% output = data;
% for i = 1:(rows-1)
%     output(i,(columns+1)) = ',';
% end
% output(rows,(columns+1)) = ';';
% 
% %append the numeric values to the file
% dlmwrite(output_name,output,'-append','delimiter','', 'newline', 'pc');
% 
% %You're done!