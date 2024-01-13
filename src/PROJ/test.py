###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
#  Import main python file
from main import *

# [OCR Integrity Test]
## Directory 
path_test_main  = 'CZ4003_CV_PROJ/test/'
path_test_img   = path_test_main + 'assets/'
path_test_act   = path_test_main + 'output/actual/'
path_test_pre   = path_test_main + 'output/predict/'
path_test_W     = path_test_main + 'output/word/'
path_test_res   = path_test_main + 'output/result/'
path_test_fig   = path_test_main + 'output/figure/'
path_test_imgOP = path_test_main + 'output/image/'
path_test_best  = path_test_main + 'output/best/'

## Reduce Operation Time (For Test Mode Only)
run_plotnfig       = True 

def run_integrity_check():
    start = time.time()
    # Initialization
    clear_JSON(path_test_pre)
    clear_Result(path_test_res)
    clear_dir(path_test_best)
    #clear_Result(path_test_best)
    clear_dir(path_test_imgOP)
    clear_dir(path_test_W)
    clear_dir(path_test_fig)

    # Static Settings
    dist_default = 0
    threshold    = 0

    # Read Test Assets
    items = read(path_test_img)
    for item in items:
        image, filename = item
        best_dist       = math.inf

        # Get Predict Result
        if(run_plotnfig == True):
            data_word       = ocr_word(image)
        data_str_Pre    = ocr_string(image)

        # Display Predict Result
        if(display_predict == True):
            if(run_plotnfig == True):
                ocr_word_display(data_word)
            ocr_string_display(data_str_Pre)

        # Get Actual Result
        data_str_Act    = get_text('test', path_test_act)

        # Display Actual Result
        if(display_actual == True):
            get_text_display(data_str_Act)

        # Post Processing
        data_str_Pre    = clean_String(data_str_Pre)
        data_str_Act    = clean_String(data_str_Act)

        # Display Preprocessing
        if(display_preprocess == True):
            clean_String_display(data_str_Pre)
            clean_String_display(data_str_Act)

        # Result
        dist, score     = similarity(data_str_Pre,data_str_Act, dist_default)

        # Display Result
        if(display_result == True):
            result_display(filename,'test',dist,score)

        # Visualisation
        if(run_plotnfig == True):
            image_plotW     = plot_word(image,data_word,threshold)
            fig             = plot_hist_conf(data_word)

        # Save Result
        image_save(image,filename,path_test_imgOP,'test','result')
        result_save(path_test_res,path_test_pre,filename,'test',dist,score,data_str_Pre)
        if(run_plotnfig == True):
            image_save(image_plotW,filename,path_test_W,'test','process')
            fig_save(fig,filename,path_test_fig,'test')

        # Update Best Result
        if(dist <= best_dist):
            best_dist = dist
        
        # Store all result to be choose later
        temp_result.append([filename,'test',dist,score,image])

    # Find Best Result
    for filename_,param_,dist_,score_,image_ in temp_result:
        if(dist_ == best_dist):
            best_result.append([filename_,param_,dist_,score_,image_])
    
    # Save Best Result
    best_result_save(best_result,path_test_best)
    end = time.time()
    print('Total Time Taken: ',round(end - start,3),'s')
    print('End of Integrity Test Operation')