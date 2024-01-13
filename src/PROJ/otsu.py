###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import matplotlib.pyplot as plt # Visual Analysis Purpose
import numpy as np              # Manipulation data and histogram
import cv2 as cv                # Image processing operation
import math                     # Math Functions

# Implement Otsu algorithms
def otsu(image):
    # Find total number of pixels in the image
    total_pixels = image.shape[0] * image.shape[1]

    # Get the weight factor with respect to 1
    mean_weight = 1.0/float(total_pixels)

    # Get # of bins and hist array
    hist, bins = np.histogram(image, np.arange(257)) # inconsistent in bins and hist shape , bins + offset value of 1 is needed

    # Set Initial Values
    optimal_thresh = -math.inf
    optimal_value  = -math.inf
    intensity_arr = np.arange(256)
    index = 0
    var_values = []

    # Iterate through all the intensity values from 0 to 255
    for t in range(len(bins)-1):
        # Sum foreground and background classification with a given threshold t
        pcb = np.sum(hist[:t])
        pcf = np.sum(hist[t:])

        # Probability of foreground and background classification
        Wb = pcb * mean_weight
        Wf = pcf * mean_weight

        # Calculate the means of foreground and background
        if(pcb != 0): # Prevent Undefined case
            mub = np.sum(intensity_arr[:t]*hist[:t]) / float(pcb)
        else:
            mub = 0
        if(pcf != 0): # Prevent Undefined case
            muf = np.sum(intensity_arr[t:]*hist[t:]) / float(pcf)
        else:
            muf = 0

        # Calculate the variance
        value = Wb * Wf * ((mub - muf) ** 2)

        
        # Find the maximum variance value
        if value > optimal_value:
            optimal_thresh = t
            optimal_value = value

        # Store Values
        var_values.append(value)
        index += 1
    
    # Binarization Image base on optimal threshold value
    otsu_image = image.copy()
    otsu_image[image > optimal_thresh] = 255
    otsu_image[image <= optimal_thresh] = 0

    return otsu_image, optimal_thresh, hist, var_values

# Display Threshold Result
def threshold_display(otsu_image, optimal_thresh, hist, var_values):
    for value in var_values:
        print('['+str(index).zfill(3)+']',value)   
    print('Optimal Threshold is',optimal_thresh) 


# Display Histogram with Thresholding result
def plot_hist_threshold(opt_var,hist,var_values):
    fig = plt.figure(figsize=(20,10))
    fig.canvas.set_window_title('Threshold Result')
    plt.xticks(np.arange(0, 255, step=10))
    plt.bar(np.arange(0,opt_var+1),hist[:opt_var+1],color = 'lightgreen',label = 'Below Threshold Value')
    plt.bar(np.arange(opt_var+1,256),hist[opt_var+1:], color = 'lightsalmon',label = 'Above Threshold Value')
    plt.axvline(opt_var,linewidth = 1 ,color = 'darkorange',label = 'Optimal Variance Value')
    plt.plot(var_values, linestyle = '--', color =  'blue', label = 'Variance Values')
    plt.legend(loc = 'best')
    plt.title('Image Histogram and Threshold Values (Optimal Threshold Value = '+ str(opt_var)+')',fontsize=14,figure = fig)
    plt.ylabel('Count', fontsize=14,figure = fig)
    plt.xlabel('Pixel Intensity',fontsize=14, figure = fig)
    #plt.show()
    return fig






