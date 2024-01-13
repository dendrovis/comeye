###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import Libraries
import cv2 as cv                # Display metrics value on image
import numpy as np              # Manipulate data
import editdistance             # Calculate similariity between 2 strings
import matplotlib.pyplot as plt # Visual Analysis Purpose
import json                     # Perform JSON operation
import os                       # Split Filename

index_R = 0

# Plot Histogram by Image Intensity Values
def plot_hist(image):
    hist, _ = np.histogram(image, np.arange(257)) 
    fig = plt.figure(figsize=(20,10))
    plt.xticks(np.arange(0, 255, step=10))
    plt.bar(np.arange(0,256),hist,color = 'red')
    plt.title('Image Intensity Histogram',fontsize=14,figure = fig)
    plt.ylabel('Count', fontsize=14,figure = fig)
    plt.xlabel('Pixel Intensity',fontsize=14, figure = fig)
    plt.close()
    return fig

# Plot Histogram by Word-Confidence
def plot_hist_conf(data):
    fig = plt.figure(figsize=(20,10))
    plt.xlim(0,100)
    plt.xticks(np.arange(0, 100, step=5))
    data = data[data['conf'] >= 0]
    if(len(data['conf']) == 0):
        print('[Error] No Confidence Found')
        return
    plt.hist(data['conf'], bins = len(data['conf'].unique()), color = 'red', figure = fig) # -1 because omit -1
    plt.title('Distribution of Confidence', fontsize = 14,figure = fig)
    plt.ylabel('Count', fontsize = 14,figure = fig)
    plt.xlabel('Confidence Rate (%)', fontsize = 14,figure = fig)
    plt.close()
    return fig

# Save Figures
def fig_save(fig,filename,path,param):
    #filename = filename.lower()
    if fig is None:
        print('[Error] No figure saved')
        return
    name,_ = os.path.splitext(filename)
    fig.savefig(path + name + '_' + param +'.jpg', pad_inches = 0)
    print('Successfully Saved Figure:         ', path + name + '_' + param +'.jpg')
    
# Plot Word-Level Detection into image with the given threshold for confidence
def plot_word(image,data,threshold):
    # Convert to BGR if it is a gray image for plotting colors
    try:
        image_ = cv.cvtColor(image,cv.COLOR_GRAY2BGR).copy()
    except:
        image_ = image.copy()

    for word in range(len(data['text'])):
        # Extract all the respective coordinates, width and height of the bounding boxes
        (x, y, w, h) = (data['left'][word], data['top'][word], data['width'][word], data['height'][word])
        # Plot all detected filled box as long it is not false value (-1)
        if(data['conf'][word] > 0):
            # Extract all bounding require values from the data
            
            # Create Mask
            sub_img = image_[y:y+h, x:x+w]
            overlay_rect = np.ones(sub_img.shape, dtype=np.uint8) 

            # Normalize and Produce to Green (conf = 100) to Red (conf = 0) gradient using 3 B,G,R channels
            b,g,r = overlay_rect[:, :, 0], overlay_rect[:, :, 1]*int((data['conf'][word]/100)*255), overlay_rect[:, :, 2]*int((1-(data['conf'][word]/100))*255) # For RGB image

            # Combine individual B,G,R masks into one
            overlay_rect2 = cv.merge((b,g,r))

            # Merge mask with the detected portion of the image
            res = cv.addWeighted(sub_img, 0.5, overlay_rect2, 0.5, 1.0) 

            # Overwrite this portion of image to the main copy of the image
            image_[y:y+h, x:x+w] = res

        # Plot Text and Bounding Box if beyond a threshold value
        if(int(data['conf'][word]) > threshold):
            image_ = cv.rectangle(image_, (x, y), (x + w, y + h), (255, 0, 0), 1)
            cur_text = data['text'][word].replace(u"\u2018", "'").replace(u"\u2019", "'").replace(u"\u201d", "\"").replace(u"\u201c", "\"")
            image_ = cv.putText(image_, text= cur_text, org=(x,y), fontFace= cv.FONT_HERSHEY_SIMPLEX, fontScale=0.5, color=(0,0,255), thickness=1, lineType=cv.LINE_AA)
    return image_

# Show Result
def result_display(filename,param,dist,score):
    global index_R
    print('Filename =',filename)
    print('Settings =',str(param))
    print('Distance =',dist)
    print('Score    =',score)
    index_R += 1

# Save Result
def result_save(path_res,path_pre,filename,param,dist,score,predict_content):
    # Save Result to Text File
    f = open(path_res + 'dataset.txt',"a")
    f.write(filename + '-' + str(param) + ' Distance:' + str(dist) + ' Score:' + str(score) + '\n')
    f.close()
    print('Successfully Saved Result:          ' + path_res + 'dataset.txt')

    # Save Predict Content to JSON File
    filename = filename.lower()
    name,_ = os.path.splitext(filename)
    f = open(path_pre + 'dataset.json','r+')

    # Try Load JSON file if exist content or else load new dictionary in
    try:
        data = json.load(f)
        f.close()
        data[name +'_'+ param] = predict_content
    except:
        print('[Warning] Update JSON Fail, ignore if this is the first warning')
        data = json.loads('{' + '"'+  name +'_' + param + '":"' + predict_content  + '"}')
    f = open(path_pre + 'dataset.json','w')
    json.dump(data, f, indent=4)
    f.close()
    print('Successfully Saved Predict Content: ' + path_pre  + 'dataset.json')
            
# Caculate Levenshtein distance and the relative score with respect to the actual text
def similarity(predict_string,act_string):
    d = editdistance.eval(predict_string,act_string)
    try:
        score = round((1 - d/len(act_string)) * 100,4)
    except:
        print('[Error] Empty Actual String')
        score = -1
    return d , score

# Save best result into directory
def best_result_save(best_result,path):
    # Open Text File
    f = open(path + 'best_result.txt',"a")
    # Save all best results and images
    for filename,param,dist,score,image in best_result:
        filename = filename.lower()
        name,ext = os.path.splitext(filename)
        f.write(name +'-'+param + '-' + ' Distance: ' + str(dist) + ' Score: ' + str(score) + '\n')
        cv.imwrite(path+name+'_'+param +ext, image)  
        print('Successfully Saved Image:', path+name+'_'+param+ext)
    f.close()
