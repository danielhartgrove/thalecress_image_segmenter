
plants_rgb = imread('plant223_rgb.png');
% Import the images in the RGB default colour space
% 001, 002(j), 003, 004(j), 005(j) 017, 223 - list of plants as png or jpg (j)

plants_hist_rgb = histeq(plants_rgb);
% Equalise the histogram
plants_xyz = rgb2xyz(plants_hist_rgb);
% convert to the xyz colour space
plants_xyz = imgaussfilt(plants_xyz, 2);
% apply a small gaussian filter to the image

[X,Y,Z] = imsplit(plants_xyz);
% split the image into xyz channels

plants_xyz =  Y - 0.95 * X;
%remove the value of the red information in the X channel
%i found the best results to be with xyz as it was consistent. Another
%method that was also good was to HSV but unfortunately the purple was

threshold = graythresh(plants_xyz);
% calculate the threshold using otsu's method
binaryplants = imbinarize(plants_xyz, threshold);
% convert the image to a binary image
filteredplants = bwareafilt(binaryplants,1,'largest');
% select the biggest white area (ROI) in the image


Distance = bwdist(~filteredplants);
Distance = -Distance;
% calculate the gradient of the binary image
watershedplants = watershed(Distance);
% perform the watershed algorithm
watershedplants(~filteredplants) = 0;
segmentedplants = label2rgb(watershedplants,'jet',[0 0 0]);
% show the segmentation

figure();
imshow(plants_rgb);
title("Original Image")
figure();
imshow(segmentedplants);
title("Segmented Binary Image")
% output the original and final images
