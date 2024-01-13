# CZ4003 Computer Vision Project
The aim of this project to develop explore and develop various image binarization algorithms targeting the optimal character recognition accuracy.

## Objectives
1. Convert Text Image Binarization from colour or grayscale image into a binary image with multiple foreground region (usually characters)
2. Connected component labeling that detects each binarized character region
3. Character recognition by using a classifier

## Scope
1. Implement the ‘Ostu’ global thresholding algorithm for binarizing the sample text images and feed the binarized images to the OCR software to evaluate the OCR accuracy. Discuss any problems with the Otsu global thresholding algorithm.
2. Design your algorithms to address the problem of the ‘Otsu’ global thresholding algorithm, and evaluate OCR accuracy for the binary images as produced by your algorithms. You may explore different approaches such as adaptive thresholding, image enhancement, etc., and the target is to achieve the best OCR accuracy.
3. Discuss how to improve recognition algorithms for more robust and accurate character recognition while document images suffer from different types of image degradation. This is an open and optional task. There will be bonus points if you have good ideas on it.

## How to use?
1. Navigate to main.py using an python supported IDE
2. Configure the rights settings to execute the respective algorithms as shown below:

(**Run Test OCR Accuracy**)

i.	Set ‘test_mode’ as **True** 

(**Run Otsu Algorithm**)

i.	Set ‘base_mode’ as **True**

ii.	Set ‘test_mode’ as **False** 


(**Run Enhanced Algorithm**)

i.	Set ‘base_mode’ as **True**

ii.	Set ‘test_mode’ as **False** 

## Contributor
1. Sam Jian Shen

## Version
1.0
