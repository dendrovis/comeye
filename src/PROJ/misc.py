###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import os               # Read and Write Directory
import shutil           # Advanced Clear Directory 
import cv2 as cv        # Read Images
import itertools        # Create combination
import json             # Read and Write JSON operation
import numpy as np      # Execute patterns

# Generate all possible combination for max test
def generate_combi(param):
    combi_list = list(itertools.product(*param))
    #combi_list = list(itertools.product([0, 1], repeat=value))
    return combi_list

# Read Image from assets directory
def read(path):
    items = []
    for filename in os.listdir(path):
        print('Reading... ', str(path) +  str(filename))
        if(os.path.isfile(path + filename)):
            items.append([cv.imread(path + filename),filename])
    return items

# Clear the directory of the process space
def clear_dir(path):
    print('Clearing files for process...')
    for item in os.listdir(path):
        if(os.path.isdir(path+item)):
            shutil.rmtree(path+item)
            print('Removed', path+item)
        else:
            os.remove(path+item)
            print('Removed', path+item)

# Save an image into respective process directory
def image_save(image,filename,path,foldername,param,ext,newdir):
    # Create a directory if does not exist
    if(newdir == True):
        if(os.path.exists(path+foldername) == False):
            os.mkdir(path + foldername) 
            print('Created',foldername,'folder')
        fname , _ = os.path.splitext(filename)
        # Save Image
        cv.imwrite(path+foldername+'/'+fname+'_'+ param + ext, image)  
        print('Successfully Saved Image:          ', path +foldername+'/'+fname+'_'+ param + ext)
    else:
        fname , _ = os.path.splitext(filename)
        # Save Image
        cv.imwrite(path + fname+'_'+ param + ext, image)  
        print('Successfully Saved Image:          ', path  +fname+'_'+param + ext)

# Clear JSON content
def clear_JSON(path):
    f = open(path + 'dataset.json', 'w').close()
    print('Cleared:', path + 'dataset.json')

# Clear Result content
def clear_Result(path):
    open(path + 'dataset.txt', 'w').close()
    print('Cleared:', path + 'dataset.txt')

# Clear Result content (For Best Result)
def clear_ResultF(path):
    open(path + 'best_result.txt', 'w').close()
    print('Cleared:', path + 'best_result.txt')



