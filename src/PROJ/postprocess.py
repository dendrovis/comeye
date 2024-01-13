###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import re                       # Clear noise data
import os                       # Files and Directory operation
import json                     # Read and Write JSON operation

# Display clean string without tabs and newlines
def clean_String_display(text):
    print('---------------------Clean Text--------------------------')
    print(text)
    print('---------------------------------------------------------')

# Clean String without tabs and newlines
def clean_String(text):
    text = re.sub(' {2,}', ' ', text)
    text = " ".join(text.split())
    # Fixed Encoding Issues (python dont support)
    text = text.replace(u"\u2018", "'").replace(u"\u2019", "'").replace(u"\u201d", "\"").replace(u"\u201c", "\"")
    return text

# Display JSON Content
def get_text_display(data):
    print('---------------------------------------------------------')
    print('-------------------------Actual--------------------------')
    print(data)
    print('---------------------------------------------------------')
    print('---------------------------------------------------------')

# Get Text from JSON File
def get_text(filename, path):
    name, _ = os.path.splitext(filename)
    name = name[ 0 : 8 ]
    try:
        print('Loading... ', path + 'dataset.json')
        # Open Json File
        f = open(path + 'dataset.json')
        # Load Json as Dict
        data = json.load(f)
    except Exception as e:
        print('[Error] Missing ''dataset.json'' not found!' )
        print(e)
    return data[name]

