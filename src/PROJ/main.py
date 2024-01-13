###########################################################################
# Course Code     : CZ4003
# Course Title    : Computer Vision
# Subject Title   : Text Image Segmentation 
# Subject Subtitle: An Optimal Optical Character Recognition (OCR)
# Contributor     : Sam Jian Shen
# Version         : 1.0
###########################################################################
# Import other python files and libraries
from preprocess import *
from ocr import *
from postprocess import *
from result import *
from misc import *
from test import *
from otsu import *
import sys
import time                 # Elapsed Time

# Declared Path to Assets
path_main   = 'CZ4003_CV_PROJ/'
path_raw    = path_main + 'assets/'
path_pro    = path_main + 'process/'
path_act    = path_main + 'output/string/actual/'
path_pre    = path_main + 'output/string/predict/'
path_imgOP  = path_main + 'output/image/non_plot/'
path_imgPt  = path_main + 'output/image/plot/'
path_resB   = path_main + 'output/result/best/'
path_resA   = path_main + 'output/result/all/'
path_figC   = path_main + 'output/figure/conf/'
path_figT   = path_main + 'output/figure/th/'
path_figI   = path_main + 'output/figure/intensity/'

# Feature IDs
id_jpg    = '00'
id_dpi    = '01'
id_gray   = '02'
id_scale  = '03'
id_otsu   = '04'
id_gblur  = '05'
id_adapt  = '06'
id_mblur  = '07'
id_erode  = '08'

# Feature Settings
mode_jpg           = True
mode_dpi           = False
mode_scale         = True
mode_gblur         = True
mode_adapthreshold = True
mode_mblur         = True
mode_erode         = False

# Dynamic Declaration
scale_percent      = [200,250,300]
gBlur              = [5,7,11]
adapt_kernel       = [11,17,37]
adapt_const        = [2,3]
medBlur            = [1,5,7]
tuner              = [scale_percent,gBlur,adapt_kernel,adapt_const,medBlur]

# Static Declaration
dpi_value          = 300
erode_val          = 1
threshold          = 0
best_result        = []
best_img           = []
temp_result        = []

# Display Settings
pd.set_option("display.max_rows", 50, "display.max_columns",  None, 'display.width', get_terminal_size()[0])
display_predict    = False
display_actual     = False
display_preprocess = False
display_result     = True  

# Clear Settings 
remove_process     = False

# Mode
test_mode          = False
base_mode          = False

# Limiter (Control the number of combination execution)
limit              = math.inf


def main(): 
    # OCR Integrity Checks
    if(test_mode == True):
        run_integrity_check()
        return
    
    # Run Main Algorithm
    start = time.time()
    print('Initialise')
    combi = generate_combi(tuner) # All sequence of parameters combination for processing

    # Clear All Directories
    if(remove_process == True):
        clear_dir(path_pro)
        clear_dir(path_imgOP)
        clear_dir(path_imgPt)
        clear_dir(path_figC)
        clear_dir(path_figT)
        clear_dir(path_figI)
        clear_dir(path_resB)
        clear_ResultF(path_resB)
        clear_Result(path_resA)
        clear_JSON(path_pre)

    # Get RAW Image
    print('[ Retriving RAW Images ]')
    items = read(path_raw)

    # Feature Enhancement
    if(base_mode == False):
        if(mode_jpg == True):
            print('[ Convert to JPG Format ]')
            for item in items:
                image, filename = item 
                image_save(image,filename,path_pro,id_jpg,'','.jpg', True)
            items = read(path_pro + id_jpg + '/')
        if(mode_dpi == True):
            print('[ Change Image DPI ]')
            dpi(dpi_value,path_pro + id_jpg ,  path_pro ,id_dpi,'') 
            items = read(path_pro + id_dpi + '/')
    # For every images in the asset directory
    for item in items:
        limit_ini       = 0
        best_dist       = math.inf
        index = 0
        temp_result = []
        # For every combination sequence
        for sc,gb,ak,ac,mb in combi:
            print('-----------------------Iteration:',index + 1,'-----------------------')
            code = str(sc).zfill(3) + '-' + str(gb).zfill(2) + '-' + str(ak).zfill(2) + '-' + str(ac).zfill(1) + '-' + str(mb).zfill(1)
            image, filename = item 
            print('[ Convert to GrayScale ]')
            image = grayscale(image)

            # Run Otsu
            if(base_mode == True):
                code = 'base'
                print('[ Run OTSU algorithm (Global Threshold)]')
                image, opt_th, hist, vacs = otsu(image)
                image_save(image,filename,path_pro,id_otsu,code,'.jpg',True)
                fig_otsu = plot_hist_threshold(opt_th,hist,vacs)

            # Feature Enhancement
            else:
                if(mode_scale == True):
                    print('[ Scale Image ]')
                    image = scale(image,sc)
                    image_save(image,filename,path_pro,id_scale,code,'.jpg',True)
                    fig_scale = plot_hist(image)
                if(mode_gblur == True):
                    print('[ Smooth Image (Gassian)]')
                    image = gaussianBlur(image,gb)
                    image_save(image,filename,path_pro,id_gblur,code,'.jpg',True)
                    fig_gblur = plot_hist(image)
                if(mode_adapthreshold == True):
                    print('[ Run Adaptive Threshold]')
                    image = cv.adaptiveThreshold(image,255,cv.ADAPTIVE_THRESH_GAUSSIAN_C,cv.THRESH_BINARY,ak,ac)
                    image_save(image,filename,path_pro,id_adapt,code,'.jpg',True)
                    fig_adapt = plot_hist(image)
                if(mode_mblur == True):
                    print('[ Smooth Image (Median)]')
                    image = cv.medianBlur(image,mb)
                    image_save(image,filename,path_pro,id_mblur,code,'.jpg',True)
                    fig_mblur = plot_hist(image)
                if(mode_erode == True):
                    print('[ Erode Image ]')
                    image = erode(image,erode_val)
                    image_save(image,filename,path_pro,id_erode,code,'.jpg',True)
                    fig_erode = plot_hist(image)

            print('[ Run OCR algorithm ]')
            # Get Predict Result
            data_word       = ocr_word(image)
            data_str_Pre    = ocr_string(image)

            # Get Actual Result
            data_str_Act    = get_text(filename, path_act)

            # Post Processing
            data_str_Pre    = clean_String(data_str_Pre)
            data_str_Act    = clean_String(data_str_Act)

            # Result
            dist, score     = similarity(data_str_Pre,data_str_Act)
            if(display_result == True):
                result_display(filename,code,dist,score)

            # Visualisation
            image_plotW     = plot_word(image,data_word,threshold)
            fig_conf        = plot_hist_conf(data_word)

            # Save Result
            print('[ Save Result ]')  
            image_save(image,filename,path_imgOP,'',code,'.jpg',False)                  # Save Image Non-Plot Image
            result_save(path_resA,path_pre,filename,code,dist,score,data_str_Pre)       # Save All Possible Outcome Image
            image_save(image_plotW,filename,path_imgPt,'',code,'.jpg',False)            # Save Plotting Image
            fig_save(fig_conf,filename,path_figC,code)                                  # Save Figure Confidence
            
            if(base_mode == True):
                fig_save(fig_otsu,filename,path_figT,code)                              # Save Figure Threshold
                break
            else:
                # Save Figure Intensity Distribution
                if(mode_scale == True):
                    fig_save(fig_scale,filename,path_figI,code + '-' + 'scale')             
                if(mode_gblur == True):
                    fig_save(fig_gblur,filename,path_figI,code + '-' + 'gblur')
                if(mode_adapthreshold == True):
                    fig_save(fig_adapt,filename,path_figI,code + '-' + 'adapt')
                if(mode_mblur == True):
                    fig_save(fig_mblur,filename,path_figI,code  + '-' + 'mblur')
                if(mode_erode == True):
                    fig_save(fig_erode,filename,path_figI,code + '-' + 'erode')

                # Update Best Result
                if(dist <= best_dist):
                    best_dist = dist

                # Store all result to be choose later
                temp_result.append([filename,code,dist,score,image])

                # Limit Iteration
                if(limit_ini >= limit):
                    break
                limit_ini += 1
            index += 1

        if(base_mode == False):
            print('Finding Best Score')
            # Find Best Result
            best_result = []
            for filename_,param_,dist_,score_,image_ in temp_result:
                if(dist_ == best_dist):
                    best_result.append([filename_,param_,dist_,score_,image_])
            
            print('Saved Best Result')
            # Save Best Result
            best_result_save(best_result,path_resB)

    end = time.time()
    print('Total Time Taken: ',round(end - start,3),'s')
    print('End of Operation')
    exit(0)
    
if __name__ == "__main__":
    main()