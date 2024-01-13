%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Course : CZ4003 Computer Vision
% Subject : Assignment 1
% Name : Sam Jian Shen
% Matrix Number : U1821296L
% Version : 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function run
    clearvars -global;
    close all;
    
    while true
        prompt = 'Selection: \n[1] Q2.1/2.2 Contrast Stretch and Histogram Equalization\n[2] Q2.3 Linear Spatial Filtering\n[3] Q2.4 Median Filtering\n[4] Q2.5 Suppressing Noise Interference Patterns\n[5] Q2.6 Undoing Perspective Distortion of Planar Surface\n[0] Exit\nOption: ';
        str = input(prompt,'s');
        if str == '0'
            break
        elseif str == '1'
            % Set Input Image
            URL = 'assets\mrttrainbland.jpg';
            Lab1.ini(URL);
            % Apply GrayScale Function
            Lab1.op_greyScale;
            % Apply Contrast Stretch Function
            Lab1.op_contrastStretch;
            % Apply Histogram Equalization Function
            Lab1.op_histogram_Equalization;
            % Display the Output from the above functions
            Lab1.show_Nonfilter;
        elseif str == '2'
            % Set Input Image
            while true
                prompt = 'Please choose a image: \n[1] Gaussian Noise Image\n[2] Speckle Noise Image\n[0] Exit\nOption: ';
                str = input(prompt,'s');
                if str == '0'
                    return
                elseif str == '1'
                    URL = 'assets\ntugn.jpg';
                    break
                elseif str == '2'
                    URL = 'assets\ntusp.jpg';
                    break
                else
                    disp('Invalid Input Please Try Again!')
                    continue
                end
            end
            Lab1.ini(URL);
            % Compute  Gaussian Average Filter(Kernel) Function
            x = 5;
            y = 5;
            sigma = 1;
            kernel1 = Lab1.op_filter_Linear_Spatial(x,y,sigma); % Default Question Value
            Lab1.op_convolution(kernel1,x,y,sigma)
            sigma = 2;
            kernel2 = Lab1.op_filter_Linear_Spatial(x,y,sigma); % Default Question Value
            Lab1.op_convolution(kernel2,x,y,sigma)
            % Display Function
        elseif str == '3'
            % Set Input Image
            while true
                prompt = 'Please choose a image: \n[1] Gaussian Noise Image\n[2] Speckle Noise Image\n[0] Exit\nOption: ';
                str = input(prompt,'s');
                if str == '0'
                    return
                elseif str == '1'
                    URL = 'assets\ntugn.jpg';
                    break
                elseif str == '2'
                    URL = 'assets\ntusp.jpg';
                    break
                else
                    disp('Invalid Input Please Try Again!')
                    continue
                end
            end
            Lab1.ini(URL);
            Lab1.op_filter_Median(3); %3x3 median filter
            Lab1.op_filter_Median(5); %5x5 median filter
        elseif str == '4'
            while true
                % Set Input Image
                prompt = 'Please choose a image: \n[1] Parallel Pattern Image\n[2] Non-Parallel Pattern Image\n[3] Segmentation Image Experiment - PCK\n[4] Segmentation Image Experiment - Cage\n[0] Exit\nOption: ';
                str = input(prompt,'s');
                if str == '0'
                    return
                elseif str == '1'
                    URL = 'assets\pckint.jpg';
                    id = 1;
                    break
                elseif str == '2'
                    URL = 'assets\primatecaged.jpg';
                    id = 2;
                    break
                elseif str == '3'
                    URL = 'assets\pckint_p1.jpg';
                    id = 3;
                    break
                elseif str == '4'
                    URL = 'assets\primatecaged_p1.jpg';
                    id = 4;
                    break
                else
                    disp('Invalid Input Please Try Again!')
                    continue
                end
            end
            Lab1.ini(URL);
            % Execute Filter noise function
            Lab1.op_filter_Noise(id);
        elseif str == '5'
            % Set Input Image
            URL = 'assets\book.jpg';
            Lab1.ini(URL);
            % Execute distortion function
            Lab1.op_adjust_Distortion
            
        else
            % If user display wrong input, show them invalid message
            disp('Invalid Input Please Try Again!')
            continue
        end
    end