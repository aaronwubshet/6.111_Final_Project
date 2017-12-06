width = 640;
height = 480;
RGB = imread('decahedral.png');  %24 bit data. Each color is specified by 8 bits.
RGB = imresize(RGB, [height, width]);
figure
image(RGB)

max_index = width*height;
x = 1;
y = 1;
array = zeros(width,height,'uint16');

for x = 1:width
    for y = 1:height
        %all values are in 8 (255) bits, we want total 9 bits
        %so, want R = 4, G = 4, B = 4

        R = uint16(RGB(y, x, 1)); 
        G = uint16(RGB(y, x, 2)); 
        B = uint16(RGB(y, x, 3));
        
        for t = 1:4
            if R ~= 0
                R = bitshift(R, -1);
            end
            if G ~= 0
                G = bitshift(G, -1);
            end
            if B ~= 0
                B = bitshift(B, -1);
            end
            
        end
                
        array(y,x) = bitshift(R, 8) + bitshift(G, 4) + B;
    end
    
   
end



flattened_array = zeros(1,width*height);
i = 1;
for y = 1:height
    for x = 1:width
        flattened_array(i) = array(y,x);
        i = i + 1;
    end
end


data = dec2bin(flattened_array, 12);

%open a file
output_name = 'image_rgb.coe';
file = fopen(output_name,'w');

%write the header info
fprintf(file,'memory_initialization_radix=2;\n');
fprintf(file,'memory_initialization_vector=\n');
fclose(file)

%put commas in the data
rowxcolumn = size(data);
rows = rowxcolumn(1);
columns = rowxcolumn(2);
output = data;
for i = 1:(rows-1)
    output(i,(columns+1)) = ',';
end
output(rows,(columns+1)) = ';';

%append the numeric values to the file
dlmwrite(output_name,output,'-append','delimiter','', 'newline', 'pc');

%You're done!
