###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import pytesseract.pytesseract as tes       # Get Tersseract Operation
from shutil import get_terminal_size        # Control terminal output limit
import matplotlib.pyplot as plt             # Visual Analysis Purpose
import pandas as pd                         # Display and manipulate data
import numpy as np                          # Manipulate data
import math                                 # Ceil and Floor Operation

# Directory to Run Tesseract Command Prompt
tes.tesseract_cmd = 'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
index_W = 0
index_S = 0


# Display OCR Return Word-Level
def ocr_word_display(data):
    global index_W
    data_copy = data.copy()
    data_copy.index += 1 # Start index from 1 instead of 0
    display_round = math.ceil(data.shape[0]/50)
    print('Processing Image Index (Word)     = ', index_W + 1)
    print('---------------------------------------------------------')
    print('--------------------------start--------------------------')
    for i in range(display_round):
        print(data[(i*50):50*(i+1)])
    print('---------------------------end---------------------------')
    print('---------------------------------------------------------')
    index_W += 1

# Retrieve all information from OCR algorithm
def ocr_word(image):
    data = tes.image_to_data(image, output_type='data.frame', config = '--psm 3 --oem 3')
    return data

# Display OCR Return Strings
def ocr_string_display(data):
    global index_S
    print('Processing Image Index (Full Strings) = ', index_S + 1)
    print('---------------------------------------------------------')
    print('--------------------------start--------------------------')
    print(data)
    print('---------------------------end---------------------------')
    print('---------------------------------------------------------')
    index_S += 1

# Retrieve the detected strings from OCR algorithm
def ocr_string(image):
    text = tes.image_to_string(image, config = '--psm 3 --oem 3')
    return text
            
            


