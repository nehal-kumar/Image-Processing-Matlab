myFolder = 'C:\Users\Akshat Mishra\Documents\MATLAB\Rice PVA 500\Amp';

filePattern = fullfile(myFolder, '*.bmp');
filenames = dir(filePattern);
count = 0;
for k = 1 : length(filenames)
  thisFileName = filenames(k).name;
  if exist(thisFileName, 'file')
    thisImage = double(imread(thisFileName));
    if k == 1
      sumImage = thisImage;
    else
      sumImage = sumImage + thisImage;
    end
    count = count + 1;
  end
end

meanImage = sumImage / 100;

Standardimage = stdfilt(meanImage);
img = rescale(Standardimage);
img(randperm(numel(img), round(numel(img)/100))) = NaN;
figure;
imshow(img,[]);
title('Original Image');
%% labeling
label = zeros(size(img), 'uint8');
label(~isfinite(img)) = 0;
label(img < 0.02) = 1;
label(img >= 0.02 & img < 0.04) = 2;
label(img >= 0.04 & img < 0.06) = 3;
label(img >= 0.06 & img < 0.08) = 4;
label(img >= 0.08 & img < 0.1) = 5;
label(img >= 0.1 & img < 0.12) = 6;
label(img >= 0.12 & img < 0.14) = 7;
label(img >= 0.14 & img < 0.16) = 8;
label(img >= 0.16 & img < 0.18) = 9;
label(img>=0.18 & img <= 0.2) = 10;
label( img > 0.2) = 11;
figure;
imshow(label,[]);

colorbar
title('Default Colormap');
 colormap(hsv);
%% make colormap
map = [0.9 0.9 0
    0.9 0.9 0
    0.9 0.9 0
    0.9 0.9 0
    0.9 0.9 0
    0.30 0.75 0.93
    0 0.45 0.74
    0.93 0.69 0.13
    0.47 0.67 0.19
    0.85 0.33 0.10
    1 0 0
    ];

%% converting to rgb image
rgb = ind2rgb(label, map);
figure;
imshow(rgb,[]);

colorbar
title('Our Colormap');

colorbar