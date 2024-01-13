###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import os                       # Retrieve dataset
import cv2 as cv                # Image Processing Operation
from PIL import Image           # DPI Operation
import numpy as np              # Data manipulation
import matplotlib               # Fixed unknown error
matplotlib.use('Agg')

# Add DPI into images
def dpi(value,path,newpath,foldername,filename):
    # Create new folder (to be save directory)
    if(os.path.exists(newpath+foldername) == False):
        os.mkdir(newpath + foldername) 
        print('Created',foldername,'folder')
    # Check if it is a file
    for filename_ in os.listdir(path):

        if(os.path.isfile(path + '/' + filename_)):
            im = Image.open(path + '/' + filename_)
            fname , _ = os.path.splitext(filename_)
            newfname , _ = os.path.splitext(filename)
            im.save(newpath + foldername + '/' + fname[0:8] + '_'+ newfname +'.jpg', dpi=(value,value))

# Convert Image to Grayscale
def grayscale(image):
    print('Before Convert to Grayscale Image Dimension = ', image.shape)
    image_gray = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
    print('After  Convert to Grayscale Image Dimension = ', cv.cvtColor(image, cv.COLOR_BGR2GRAY).shape)
    return image_gray

# Scale Image
def scale(image,scale_percent):
    print('Original Dimensions : ',image.shape)
    width = int(image.shape[1] * scale_percent / 100)
    height = int(image.shape[0] * scale_percent / 100)
    dim = (width, height)
    # Resize image
    image_resized = cv.resize(image, dim, interpolation = cv.INTER_AREA)
    print('Resized Dimensions : ',image_resized.shape)
    return image_resized

# Dilation
def dilate(image,value):
    kernel = np.ones((value,value),np.uint8)
    return cv.dilate(image, kernel, iterations = 1)
    
# Erosion
def erode(image,value):
    kernel = np.ones((value,value),np.uint8)
    return cv.erode(image, kernel, iterations = 1)

# Opening - erosion followed by dilation
def opening(image,value):
    kernel = np.ones((value,value),np.uint8)
    return cv.morphologyEx(image, cv.MORPH_OPEN, kernel)

# Skew correction
def deskew(image):
    coords = np.column_stack(np.where(image > 0))
    angle = cv.minAreaRect(coords)[-1]
    if angle < -45:
        angle = -(90 + angle)
    else:
        angle = -angle
    (h, w) = image.shape[:2]
    center = (w // 2, h // 2)
    M = cv.getRotationMatrix2D(center, angle, 1.0)
    rotated = cv.warpAffine(image, M, (w, h), flags=cv.INTER_CUBIC, borderMode=cv.BORDER_REPLICATE)
    return rotated

# Apply Gaussian Blur
def gaussianBlur(image,value):
    return cv.GaussianBlur(image,(value,value),0)

# Calculate skew angle of an image
def getSkewAngle(image) -> float:

    # Find all contours
    contours, hierarchy = cv.findContours(image, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)
    contours = sorted(contours, key = cv.contourArea, reverse = True)

    # Find largest contour and surround in min area box
    largestContour = contours[0]
    minAreaRect = cv.minAreaRect(largestContour)

    # Determine the angle. Convert it to the value that was originally used to obtain skewed image
    angle = minAreaRect[-1]
    if angle < -45:
        angle = 90 + angle
    return -1.0 * angle

# Rotate the image around its center
def rotateImage(image, angle: float):
    new_image = image.copy()
    (h, w) = new_image.shape[:2]
    center = (w // 2, h // 2)
    M = cv.getRotationMatrix2D(center, angle, 1.0)
    new_image = cv.warpAffine(new_image, M, (w, h), flags=cv.INTER_CUBIC, borderMode=cv.BORDER_REPLICATE)
    return new_image