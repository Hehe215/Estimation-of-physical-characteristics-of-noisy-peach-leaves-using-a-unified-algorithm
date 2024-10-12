clear all;
close all;
% Step 1: Read the Image
img = imread('leaf.JPG');
% Step 2: Apply Bilateral filter for denoising and show the result
denoised_image = imbilatfilt(img);
figure;
imshow(denoised_image);
title('Denoised Image');
img=denoised_image;
% Step 2: Convert the Image to L*a*b* Color Space
lab_img = rgb2lab(img);

% Step 3: Reshape the Image Data
[nrows, ncols, nchannels] = size(lab_img);
ab = double(lab_img(:,:,2:3)); % Only use 'a' and 'b' channels
ab = reshape(ab, nrows*ncols, 2);

% Step 4: Apply K-means Clustering
nColors = 2; % We expect two clusters (leaf and background)
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', ...
                                       'Replicates', 3);

% Step 5: Reshape the Clustered Data
pixel_labels = reshape(cluster_idx, nrows, ncols);

% Step 6: Create Binary Masks for Clusters
binary_mask1 = pixel_labels == 1;
binary_mask2 = pixel_labels == 2;

% Apply Morphological Operations
se = strel('disk', 5);
binary_mask1 = imopen(binary_mask1, se);
binary_mask1 = imclose(binary_mask1, se);

binary_mask2 = imopen(binary_mask2, se);
binary_mask2 = imclose(binary_mask2, se);

% Step 7: Determine which mask corresponds to the leaf
% (Assume the leaf is the larger connected component)
mask1_area = sum(binary_mask1(:));
mask2_area = sum(binary_mask2(:));
if mask1_area > mask2_area
    leaf_mask = binary_mask1;
else
    leaf_mask = binary_mask2;
end

% Step 8: Extract the exact leaf from the original image
leaf_mask_3channel = cat(3, ~leaf_mask, ~leaf_mask, ~leaf_mask); % Create a 3-channel mask
segmented_leaf = uint8(leaf_mask_3channel) .* img; % Apply the mask to the original image

% Step 9: Change the background to white
white_background = 255 * uint8(~leaf_mask_3channel); % Create a white background
segmented_leaf_white_bg = segmented_leaf + white_background; % Combine leaf with white background

% Display the original image
figure;
imshow(img);
title('Original Image');

% Display the mask
figure;
imshow(leaf_mask);
title('Leaf Mask');

% Display the segmented leaf with white background
figure;
imshow(segmented_leaf_white_bg);
title('Segmented Leaf with White Background');
figure;
imshow(segmented_leaf);
title('Segmented Leaf ');
% Measure properties of the leaf region
stats = regionprops(~leaf_mask, 'MajorAxisLength', 'MinorAxisLength', 'Area', 'Perimeter');

% Length: Major axis length of an ellipse that fits the leaf region
leaf_length = stats.MajorAxisLength;

% Width: Minor axis length of an ellipse that fits the leaf region
leaf_width = stats.MinorAxisLength;

% Area: Sum of all pixels within the segmented leaf region
leaf_area = stats.Area;

% Perimeter: Length of the outer boundary of the leaf region
leaf_perimeter = stats.Perimeter;

% Display the estimated physical characteristics
fprintf('Estimated Physical Characteristics of the Leaf:\n');
fprintf('Length: %.2f pixels\n', leaf_length);
fprintf('Width: %.2f pixels\n', leaf_width);
fprintf('Area: %.2f pixels\n', leaf_area);
fprintf('Perimeter: %.2f pixels\n', leaf_perimeter);