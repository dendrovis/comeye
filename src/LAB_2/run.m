%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Course : CZ4003 Computer Vision
% Subject : Assignment 2
% Name : Sam Jian Shen
% Matrix Number : U1821296L
% Version : 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function run
    clearvars -global;
    close all;
    
    while true
        prompt = 'Selection: \n[1] Q3.1 Edge Detection\n[2] Q3.2 Hough Transform\n[3] Q3.3 3D Stereo\n[4] Extras\n[0] Exit\nOption: ';
        str = input(prompt,'s');
        if str == '0'
            break
        % Question 1
        elseif str == '1'
            prompt = 'Selection: \n[1] Sobel Filter Image w/o Square\n[2] Sobel Filter Image w/ Square\n[3] Sobel Filter Image w/ Square and Root\n[4] Canny Edge Detection \n[0] Exit\nOption: ';
            str = input(prompt,'s');
            if str == '0'
                continue
            elseif str == '1'
                square = 0;
            elseif str == '2'
                square = 1;
            elseif str == '3'
                square = 2;
            elseif str == '4'
                square = -1;
            end
            
            % Set Input Image
            if square ~= -1 
                prompt = 'Selection: \n[1] Macritchie Image\n[2] Chopstick Image\n[3] Square Shape Image\n[4] [3x3] Diagonal\n[5] [3x3] Horizontal\n[6] [3x3] Vertical\n[7] [3x3] Partial Vertical 1\n[8] [3x3] Partial Vertical 2\n[9] [3x3] Horizontal Flip\n[10] [3x3] Vertical Flip\n[11] Gray Gradient Rectangle\n[12] Gray Gradient Circular\n[0] Exit\nOption: ';
                str = input(prompt,'s');
                input3by3 = [];
                if str == '0'
                    continue
                elseif str == "1"
                    URL = 'assets\macritchie.jpg';
                elseif str == "2"
                    URL = 'assets\chopstick.jpg';
                elseif str == "3"
                    URL = 'assets\square.jpg';
                elseif str == "4"
                    input3by3 = [255 0 0;0 255 0;0 0 255];
                elseif str == "5"
                    input3by3 = [255 255 255;0 0 0;0 0 0];
                elseif str == "6"
                    input3by3 = [255 0 0;255 0 0;255 0 0];
                elseif str == "7"
                    input3by3 = [255 0 0;0 0 0;0 0 0];
                elseif str == "8"
                    input3by3 = [255 0 0;255 0 0;0 0 0];
                elseif str == "9"
                    input3by3 = [0 0 0;0 0 0;255 255 255];
                elseif str == "10"
                    input3by3 = [0 0 255;0 0 255;0 0 255];
                elseif str == "11"
                    URL = 'assets\gray_gradient.jpg';
                elseif str == "12"
                    URL = 'assets\circular_gradient_gray.jpg';
                end
                if  str == "1" || str == "2" || str == "3" || str == "11" || str == "12"
                    % Get Image
                    Lab2.ini(URL);
                    disp('Reading path...');
                    disp(URL);
                    % Convert Image to Grayscale
                    Lab2.op_greyScale;
                    % Apply Sobel Mask
                    img_edge = Lab2.op_sobel(square);
                    % Threshold the image for edge detection
                    Lab2.op_threshold(img_edge);
                elseif str == "4" || str == "5" || str == "6" || str == "7" || str == "8" || str == "9" || str == "10"
                    % Apply Sobel Mask with specific inputs
                    Lab2.op_sobel_special(input3by3,square);
                end
            else
                URL = 'assets\macritchie.jpg';
                 % Get Image
                Lab2.ini(URL);
                disp('Reading path...');
                disp(URL);
                % Convert Image to Grayscale
                Lab2.op_greyScale;
                % Apply Canny Edge Detection
                th = 0.1;
                for tl = 0.01:0.01:0.09
                    Lab2.op_canny(tl,th);
                end
            end
        % Question 2
        elseif str == '2'
            % Set Input Image
            URL = 'assets\macritchie.jpg';
            Lab2.ini(URL);
            disp('Reading path...');
                disp(URL);
                % Convert Image to Grayscale
                Lab2.op_greyScale;
                % Apply Canny Edge Detection
                th = 0.1;
                tl = 0.09;
                sigma = 1;
                Lab2.op_cannyHT(tl,th,sigma);
                Lab2.op_radon
        % Question 3
        elseif str == '3'
            prompt = 'Selection: \n[1] Corridor Images\n[2] Triclops Images\n[0] Exit\nOption: ';
            str = input(prompt,'s');
            % Set Input Images
            if str == '0'
                continue
            elseif str == "1"
                URL_L = 'assets\corridorl.jpg';
                URL_R = 'assets\corridorr.jpg';
                URL_S = 'assets\corridor_disp.jpg';
            elseif str == "2"
                URL_L = 'assets\triclopsi2l.jpg';
                URL_R = 'assets\triclopsi2r.jpg';
                URL_S = 'assets\triclopsid.jpg';
            end    
            Lab2.ini2(URL_L,URL_R,URL_S);
            % Convert to Grayscale
            Lab2.op_greyScale2;
            % Run 3D Stereo Algorithm
            temp_x = 11;
            temp_y = 11;
            % Read Images
            imgL = evalin('base','img_LeftGray');
            imgR = evalin('base','img_RightGray');
            
            % Run 3D Stereo Functions
            dmap = Lab2.op_stereo3d(imgL,imgR,temp_x,temp_y);
            
            % Show the 3D Stereo Result
            Lab2.display_dmap(dmap);
            
        elseif str == '4'
            Lab2.op_Gaussian
        end
        
    end

end