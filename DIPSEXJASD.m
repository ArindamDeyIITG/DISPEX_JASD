clc;
clear all;
close all;
warning off;
RGB=imread('Sample_Disp_Image.jpg'); % Reads the image from a spcified filename in the RGB format

RGB = imresize(RGB, [1000 4000]); % Resizes the image to a particular scale defined by number of rows and columns
[m n p]=size(RGB);
Map=zeros(m,n);

% Convert RGB image to chosen color space, HSV in this case
I = rgb2hsv(RGB);

% Blue ranges
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.566;
channel1Max = 0.832;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.274;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

for i=1:m
    for j=1:n
        if (BW(i,j)==1)
            Map(i,j)=30*I(i,j,2);
        end
    end
end

% aqua colour
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.103;
channel1Max = 0.565;
diff=channel1Max-channel1Min;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.274;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

for i=1:m
    for j=1:n
        if (BW(i,j)==1)
            Map(i,j)=30+40*((channel1Max-I(i,j,1))/diff);
        end
    end
end

% Red zone
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.897;
channel1Max = 0.102;
diff=channel1Max-channel1Min;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.230;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.314;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
BW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

for i=1:m
    for j=1:n
        if (BW(i,j)==1)
            Map(i,j)=70+20*((channel1Max-I(i,j,1))/diff);
        end
    end
end


% Black zone
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.897;
channel1Max = 0.102;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.230;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 0.364;

% Create mask based on chosen histogram thresholds
BW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
for i=1:m
    for j=1:n
        if (BW(i,j)==1)
            Map(i,j)=100;
        end
    end
end

Map2=zeros(m,n);
for i=1:m
    for j=1:n
        Map2(i,j)=Map(m-i+1,j);
    end
end

Map3 = medfilt2(Map2,[10 10 ]);
[row,col]  = find(Map3==100);
contourf(Map2)
c = struct('rr', [0.9047, 0.1918, 0.1988], ...  %Your required color
    'bb', [0.2941, 0.5447, 0.7494], ... %Your required color
    'um', [0.0824, 0.1294, 0.4196], ... %ultra marine
    'br', [0.6510, 0.5725, 0.3412], ... %bronze
    'gl', [0.8314, 0.7020, 0.7843] );   %greyed lavender
figure1=figure;
axes1 = axes('Parent',figure1);
view(axes1,[-33.5 64]);
hold(axes1,'all');
surf(Map3,'LineStyle', 'none');
Map4=zeros(m,n);

omega=0.025:0.025:100; % Chosen frequency interval and the maximum frequency as provided in the dispersion image
pvel_max=[];
omega_final=[];

for i=1:4000
   [max_amp,pvel_locs]=findpeaks(Map3(:,i),'MINPEAKHEIGHT',99.9);
    if any(pvel_locs)==1
        count=size(pvel_locs,1);
        for j=1:count
            omega_final=[omega_final omega(i)];
        end
        pvel_max=[pvel_max pvel_locs'];
    end
end
figure;
plot(omega_final,pvel_max,'*') % Plotting the extracted dispersion curve

A=[omega_final' pvel_max']; % Data file for the points of dispersion curve

