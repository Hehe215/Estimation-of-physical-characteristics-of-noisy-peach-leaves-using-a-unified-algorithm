# Estimation-of-physical-characteristics-of-noisy-peach-leaves-using-a-unified-algorithm
Estimation of physical characteristics of noisy peach leaves using a unified algorithm
Overview
This MATLAB code processes an image of a leaf to denoise, segment, and estimate its physical characteristics. The key steps include applying a bilateral filter for denoising, converting the image to the L*a*b* color space, performing K-means clustering to separate the leaf from the background, and finally calculating the leaf's length, width, area, and perimeter.

Prerequisites
MATLAB with Image Processing Toolbox.
An image of a leaf saved as leaf.JPG in the working directory.
Code Description
Step-by-Step Process
Read the Image: The code reads the input image of a leaf, which should be saved as leaf.JPG in the working directory.

Denoise the Image: A bilateral filter is applied to denoise the image, preserving important details like edges while reducing noise.

Convert Image to L*a*b* Color Space: The RGB image is converted to the L*a*b* color space, which separates color information from lightness. This step helps improve the accuracy of segmentation.

Reshape Image Data: The image data is reshaped to prepare it for the clustering algorithm, using only the 'a' and 'b' color channels from the L*a*b* color space.

K-means Clustering: K-means clustering is used to segment the image into two clusters: one representing the leaf and the other representing the background.

Create Binary Masks: After clustering, binary masks are created for each cluster. Morphological operations are applied to clean up noise in the masks.

Determine the Leaf Cluster: The larger connected component is assumed to be the leaf, and the corresponding binary mask is identified.

Extract Leaf: The identified leaf is extracted from the original image by applying the binary mask.

Change Background to White: The background of the segmented leaf is replaced with a white background, improving the visual clarity of the segmented leaf.

Display Results: The code displays several intermediate and final outputs, including the original image, the binary mask, and the segmented leaf with a white background.

Estimate Physical Characteristics: The code calculates the physical properties of the leaf, including:

Length: Measured as the major axis length of an ellipse that fits the leaf region.
Width: Measured as the minor axis length of an ellipse that fits the leaf region.
Area: The number of pixels in the segmented leaf region.
Perimeter: The length of the boundary surrounding the leaf region.
Print Results: The estimated physical characteristics of the leaf (length, width, area, and perimeter) are printed to the MATLAB console.

Outputs
The code will generate the following outputs:

Original Image: Displays the input leaf image.
Leaf Mask: Shows the binary mask corresponding to the segmented leaf.
Segmented Leaf with White Background: Displays the extracted leaf with a white background.
Physical Characteristics: Prints the estimated length, width, area, and perimeter of the leaf in pixels.
How to Run
Ensure that the image file leaf.JPG is located in the same directory as the MATLAB script.
Open the script in MATLAB and run it.
The script will process the image, display the outputs in figure windows, and print the estimated physical characteristics to the console.
Dependencies
MATLAB R2016b or later.
Image Processing Toolbox.
License
This code is provided for educational and research purposes only.
