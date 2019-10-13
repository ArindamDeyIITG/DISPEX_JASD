clc;
clear all;
close all;
warning off;

area=1; %change the area to smaller values to get small regions (Can be changed)
RGB=imread('Sample_Disp_Image.jpg'); % Reads the image from a spcified filename in the RGB format

% Convert RGB image to chosen color space, yCbCr in this case
I = rgb2ycbcr(RGB);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 19.000;
channel1Max = 32.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 119.000;
channel2Max = 126.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 134.000;
channel3Max = 155.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
BW = im2bw(maskedRGBImage, .001);

BW2 = bwareaopen(BW,area);
imshow(BW2);
NPDB=nnz(BW2); % Numbers of pixels in dispersion band

[m n]=size(BW2);
Y=zeros(n,3);
for j=1:n
    max=0;
    min=0;
    flag1=1;
    count=1;
    Y(j,count)=j;
    for i=1:m
        if(BW2(i,j)==1 &&  flag1==1)
            min=i;
            Y(j,count+1)=min;
            flag1=0;
        end
        if( flag1==0 && BW2(i,j)==0 && max<i)
             max=i-1;
             flag1=1;             
             Y(j,count+2)=max;
        end
    end
end

dlmwrite('FrequencyBlack.txt', Y, 'delimiter', '\t', 'newline', 'pc');