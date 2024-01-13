%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Course : CZ4003 Computer Vision
% Subject : Assignment 1
% Name : Sam Jian Shen
% Matrix Number : U1821296L
% Version : 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef Lab1
    methods (Static)   
        
        function ini(URL)
        % Checking Input
        disp('Executing Ini...')
        if isempty(URL)
            print('Empty String')
            return
        end
        % Read and convert image operation 
        Pc = imread(URL);
        whos Pc;
        disp('Sucessfully - Read Img ');

        % Store image into workspace
        assignin('base','img_Origin',Pc)
        disp('Store Origin Image into Workspace');
        disp('End Ini');
        end

        function show_Nonfilter
            try 
                % Read various images from workspace
                img_Origin = evalin('base','img_Origin');
                img_GreyScale = evalin('base','img_GreyScale');
                img_ContrastStretch = evalin('base','img_ContrastStretch');
                whos;
                img_AltContrastStretch = evalin('base','img_AltContrastStretch');
                img_HistEq = evalin('base','img_HistEq');
                img_HistEq2ndRound = evalin('base','img_HistEq2ndRound');

            catch e
                % Show error if does not exist
                disp(e);
                disp('Please key in "Lab1.ini"');
            end
            figure('Name','2.1 Constrast Stretching Experiment','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            subplot(2,3,1), imshow(img_Origin); 
            title('Origin Image', 'FontSize', 14); 
            subplot(2,3,2), imshow(img_GreyScale); 
            title('Grey-Scale Image', 'FontSize', 14);
            subplot(2,3,3), imshow(img_ContrastStretch);
            title('After Contrast Stretched', 'FontSize', 14);
            subplot(2,3,4), imshow(img_AltContrastStretch,[]);
            title('After Contrast Stretched (Alternative)', 'FontSize', 14);
            subplot(2,3,5), imhist(img_GreyScale,256);
            [count,binLoc] =  imhist(img_GreyScale,256); % get image bin count and location,output is vertical matrix
            count = transpose(count); %transpose matrix from vertical to horizontal(normal 2d array)
            maxY = ceil(max(count))+ 100; 
            mergedVariable = {'Grey-Scale Histogram' -10 265 0  maxY 1 0 0 'on'}; % plot configuration
            Lab1.configure_HistPlot(mergedVariable{:});
            subplot(2,3,6), imhist(img_ContrastStretch,256);
            mergedVariable = {'After Contrast Stretch Histogram' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            disp('Display Image(s) details...');
            %get and show max&min greyscale and constrastStretch intensity
            show_MinMax_Intensity_GreyScale = [min(img_GreyScale(:)),max(img_GreyScale(:))] ;
            show_MinMax_Intensity_ContrastStretch = [min(img_ContrastStretch(:)),max(img_ContrastStretch(:))] ;
            disp('    min  max (pixel(s))')
            disp(show_MinMax_Intensity_GreyScale);
            disp(show_MinMax_Intensity_ContrastStretch);
            
            
            figure('Name','2.2 Histogram Equalization Experiment','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            
            subplot(2,3,1),  imhist(img_GreyScale,10);  % 10 bins
            [count_10b,binLoc_10b] =  imhist(img_GreyScale,10); % get image bin count and location,output is vertical matrix
            count_10b = transpose(count_10b); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_10b = transpose(binLoc_10b);
            maxY = ceil(max(count_10b))+ 100; 
            mergedVariable = {'Grey-Scale Histogram (10 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            
            subplot(2,3,4), imhist(img_GreyScale,256); % 256 bins
            [count_256b,binLoc_256b] =  imhist(img_GreyScale,256); % get image bin count and location,output is vertical matrix
            count_256b = transpose(count_256b); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_256b = transpose(binLoc_256b);
            maxY = ceil(max(count_256b))+100; 
            mergedVariable = {'Grey-Scale Histogram (256 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            
            subplot(2,3,2), imhist(img_HistEq,10);  % 10 bins
            [count_10b_E,binLoc_10b_E] =  imhist(img_HistEq,10); % get image bin count and location,output is vertical matrix
            count_10b_E = transpose(count_10b_E); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_10b_E = transpose(binLoc_10b_E);
            maxY = ceil(max(count_10b_E))+100; 
            mergedVariable = {'After Histogram Equalization (10 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            
            subplot(2,3,5), imhist(img_HistEq,256); % 256 bins
            [count_256b_E,binLoc_256b_E] =  imhist(img_HistEq,256); % get image bin count and location,output is vertical matrix
            count_256b_E = transpose(count_256b_E); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_256b_E = transpose(binLoc_256b_E);
            maxY = ceil(max(count_256b_E))+100; 
            mergedVariable = {'After Histogram Equalization (256 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            subplot(2,3,3), imhist(img_HistEq2ndRound,10);  % 10 bins
            [count_10b_E2,binLoc_10b_E2] =  imhist(img_HistEq2ndRound,10); % get image bin count and location,output is vertical matrix
            count_10b_E2 = transpose(count_10b_E2); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_10b_E2 = transpose(binLoc_10b_E2);
            maxY = ceil(max(count_10b_E))+100; 
            mergedVariable = {'After (2nd) Histogram Equalization (10 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            
            subplot(2,3,6), imhist(img_HistEq2ndRound,256); % 256 bins
            [count_256b_E2,binLoc_256b_E2] =  imhist(img_HistEq2ndRound,256); % get image bin count and location,output is vertical matrix
            count_256b_E2 = transpose(count_256b_E2); %transpose matrix from vertical to horizontal(normal 2d array)
            binLoc_256b_E2 = transpose(binLoc_256b_E2);
            maxY = ceil(max(count_256b_E))+100; 
            mergedVariable = {'After (2nd) Histogram Equalization (256 bins)' -10 265 0  maxY 1 0 0 'on'};
            Lab1.configure_HistPlot(mergedVariable{:});
            
            % Display information related to histogram
            disp('[Grey-Scale Histogram (10 bins)]');
            disp('  Bin Count      Bin Location ');
            disp(' (pixel(s))       (greyness) ');
            fprintf('%10.2f \t\t %10.2f \n',[count_10b;binLoc_10b]);
            fprintf('\n\n');
            disp('[Grey-Scale Histogram (256 bins)]');
            disp('  Bin Count      Bin Location ');
            disp(' (pixel(s))       (greyness) ');
            fprintf('%10.2f \t\t %10.2f \n',[count_256b;binLoc_256b]);
            
            disp('[After Histogram Equalization (10 bins)]');
            disp('  Bin Count      Bin Location ');
            disp(' (pixel(s))       (greyness) ');
            fprintf('%10.2f \t\t %10.2f \n',[count_10b_E;binLoc_10b_E]);
            fprintf('\n\n');
            disp('[After Histogram Equalization (256 bins)]');
            disp('  Bin Count      Bin Location ');
            disp(' (pixel(s))       (greyness) ');
            fprintf('%10.2f \t\t %10.2f \n',[count_256b_E;binLoc_256b_E]);
            
            
            fprintf('\n\n');
            disp('  2nd Histogram Equalization (10 bins)');
            disp('       [Before]                           [After]');
            disp('  Bin Count Bin Location          Bin Count    Bin Location ');
            disp(' (pixel(s))   (greyness)         (pixel(s))      (greyness) ');
            fprintf('%10.2f \t %10.2f \t|\t %10.2f \t %10.2f \n',[count_10b_E;binLoc_10b_E;count_10b_E2;binLoc_10b_E2]);
            fprintf('\n\n');
            disp('  2nd Histogram Equalization (256 bins)');
            disp('       [Before]                           [After]');
            disp('  Bin Count Bin Location          Bin Count    Bin Location ');
            disp(' (pixel(s))   (greyness)         (pixel(s))      (greyness) ');
            fprintf('%10.2f \t %10.2f \t|\t %10.2f \t %10.2f \n',[count_256b_E;binLoc_256b_E;count_256b_E2;binLoc_256b_E2]);
            fprintf('\n\n');
        end
        
        function configure_HistPlot(description, rangeX_Min, rangeX_Max,rangeY_Min, rangeY_Max, color_R,color_G,color_B, grid_Mode)
            % Configure Histrogram Plotting Parameter
            title(description, 'FontSize', 14);
            ylim([rangeY_Min, rangeY_Max]);
            xlim([rangeX_Min, rangeX_Max]); 
            curHist = findobj(gca, 'Type', 'Stem');
            curHist.Color = [color_R color_G color_B];  % Change the color to red
            if isequal(grid_Mode,'on')
                grid on;
            end
  
        end
        
        function op_greyScale
            % Read Origin Image from workspace
            img_Origin = evalin('base','img_Origin');
            % Convert to grey-scale image
            P = rgb2gray(img_Origin);
            disp('Sucessfully - Convert GrayScale Img ')
            % Store Origin Image into workspace
            assignin('base','img_GreyScale',P);
            disp('Store Grey Scale Image into Workspace');
            
        end
        
        function op_contrastStretch
            % Read Gray Image from workspace
            img_GreyScale = evalin('base','img_GreyScale');
            
            % Convert to double and re-scale between 0 to 1 range
            img_GreyScale_double = im2double(img_GreyScale);
            img_GreyScale_min = im2double(min(img_GreyScale(:))); %min(img_GreyScale(:));
            img_GreyScale_max = im2double(max(img_GreyScale(:))); %max(img_GreyScale(:));
            % Apply contrast stretch formula
            P2_double = (255*(imsubtract(img_GreyScale_double,img_GreyScale_min)))/(img_GreyScale_max-img_GreyScale_min); % left minus right           
            % Alternative method which ignore byte or double-valued images.
            %% Figure settings
            figure('Name','2.1 Constrast Stretching Experiment (Using imshow(P2,[]))','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            subplot(1,2,1), imshow(P2_double,[]);
            title('Contrast Stretching Alternative Image','FontSize', 14);
            subplot(1,2,2), histogram(P2_double,'FaceColor','r','NumBins',256);
            title('Contrast Stretching Alternative Histogram', 'FontSize', 14);
            ylim([0, 3000]);
            xlim([-10, 255]); 
            grid on;
            show_MinMax_Alt = [min(P2_double(:)),max(P2_double(:))] ;
            disp( show_MinMax_Alt );
            % Store Alternative Contrast Stretch Image into workspace
            assignin('base','img_AltContrastStretch',P2_double);
            % Convert back to uint8
            P2 = uint8(P2_double);
            whos P2;
            disp('Sucessfully - Contrast Stretch Img ')
            % Store Contrast Stretch Image into workspace
            assignin('base','img_ContrastStretch',P2);
            disp('Store Contrast Stretch Image into Workspace');
        end
        
        function op_histogram_Equalization
            % Read Gray Image from workspace
            img_GreyScale = evalin('base','img_GreyScale');
            % Apply Histogram Equalization
            P3 = histeq(img_GreyScale,255);
            % Store into workspace
            assignin('base','img_HistEq',P3);
            
            % Read Hist Image from workspace
            img_HistEq = evalin('base','img_HistEq');
            % Apply Histogram Equalization again
            img_HistEq2ndRound = histeq(img_HistEq,255);
            % Store into workspace
            assignin('base','img_HistEq2ndRound',img_HistEq2ndRound);
            
        end
        
        function result = op_filter_Linear_Spatial(x,y,sigma)
            % There exist pre-build libraries that generate gaussian filter
            % called fspeical('gaussian',[x-dimension,y-dimension],sigma)
            result = fspecial('gaussian',[x,y],sigma);
            % Show Intensity in 2D View (Gray-Level)
            %% Figure Settings
            figure('Name','Gaussian Average Kernel (X = ' + string(x) + ' Y = ' + string(y) + ' Sigma = ' + string(sigma) + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display Kernel in 2D Gray
            subplot(1,2,1), imshow(result);
            title('2D View (Gray-Level)','FontSize', 14);
            %% Display Intensity in 3D View with mesh function
            subplot(1,2,2), meshView = mesh(result);
            title('3D View (Mesh-Flat)','FontSize', 14);
            %% Adjust mesh view setting
            meshView.FaceColor = 'flat';
            meshView.FaceAlpha = 0.5000;
            % Display the pixel intensity value, it is already normalize to 1
            disp('Individual Pixel(s)/Element(s) Intensity Value:');
            disp(result);
            disp('Sum of all Pixel(s)/Element(s) in Y-Axis (Column):');
            disp(sum(result)); % sum of all elements in column
            disp('Sum of all Pixel(s)/Element(s):');
            disp(sum(sum(result))); % sum of all elements
        end
        
        function op_convolution(kernel,x,y,sigma)
            % Read Origin Image from workspace
            img_Origin = evalin('base','img_Origin');
            % Apply default convolution kernel
            %% Figure Settings
            figure('Name','Gaussian Average Filtering (X = ' + string(x) + ' Y = ' + string(y) + ' Sigma = ' + string(sigma) + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display origin of the image before gaussian filter
            subplot(1,3,1), imshow(img_Origin);
            title('Before Gaussian Average Filtering','FontSize', 14);
            %% Conver to double
            img_Origin_double = im2double(img_Origin);
            %% Apply customize convolution
            img_conv = conv2(kernel, img_Origin_double);
            %% Display After Gaussian Ave filter
            subplot(1,3,2), imshow(img_conv);
            title('After Gaussian Average Filtering', 'FontSize',14);
            %% Apply imfilter with replicate as padding of the image
            img_filter = imfilter(img_Origin_double,kernel, 'replicate');
            %% Display After Gaussian Ave filter  w/ imfilter
            subplot(1,3,3), imshow(img_filter);
            title('After Gaussian Average Filtering using imfilter Function', 'FontSize',14);
            
            % Mesh View
            %% Figure Settings
            figure('Name','[Mesh Mode]Gaussian Average Filtering (X = ' + string(x) + ' Y = ' + string(y) + ' Sigma = ' + string(sigma) + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display Accordingly
            subplot(1,2,1), meshView = mesh(img_Origin);
            title('Before Gaussian Average Filtering', 'FontSize',14);
            meshView.FaceColor = 'flat';
            meshView.FaceAlpha = 0.5000;
            subplot(1,2,2), meshView = mesh(img_filter);
            title('After Gaussian Average Filtering', 'FontSize',14);
            meshView.FaceColor = 'flat';
            meshView.FaceAlpha = 0.5000;
            
            % Cross Section of Mesh [1st row of pixel only]
            %% Figure settings
            figure('Name','[Cross Section Mode]Gaussian Average Filtering (X = ' + string(x) + ' Y = ' + string(y) + ' Sigma = ' + string(sigma) + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen

            %% Display accordingly
            subplot(1,2,1), plot(img_Origin(1,:));
            title('Before Gaussian Average Filtering', 'FontSize',14);
            subplot(1,2,2), plot(img_filter(1,:));
            title('After Gaussian Average Filtering', 'FontSize',14);
            
            % Using 1D kernel to see the true effect of noise in 2D plot (this is hard coded [Using reference from sum of col 5x5 kernel in average gaussian filter where dimension = 5x5 and sigma = 2])
            %% Apply 1D Kernel with approx average gaussian values 5x1
            img_filter2 = imfilter(img_Origin_double,[0.1525 0.2218 0.2514 0.2218 0.1525], 'replicate');
            %% Figure Settings
            figure('Name','[1D Kernel]Gaussian Average Filtering [0.25 0.5 0.25]','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display Accordingly
            subplot(1,2,1), plot(img_Origin(1,:));
            title('Before Gaussian Average Filtering', 'FontSize',14);
            subplot(1,2,2), plot(img_filter2(1,:));
            title('After Gaussian Average Filtering', 'FontSize',14);

        end
        
        function op_filter_Median(dimension)
            % Read Image from workspace
            img_Origin = evalin('base','img_Origin');
            
            % Figure Settings
            figure('Name','Median Filtering (' + string(dimension) + 'x' +  string(dimension)  + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Display Before Median
            subplot(1,2,1), imshow(img_Origin);
            title('Before Median Filtering','FontSize', 14);
            
            % Apply Median Filter
            img_med = medfilt2(img_Origin, [dimension,dimension]); % this use the default 3x3
            
            % Display After Median Filter
            subplot(1,2,2), imshow(img_med);
            title('After Median Filtering', 'FontSize',14);
            
            % Mesh View
            %% Figure Settings
            figure('Name','[Mesh Mode]Median Filtering (' + string(dimension) + 'x' +  string(dimension)  + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display accordingly
            subplot(1,2,1), meshView = mesh(img_Origin);
            title('Before Median Filtering', 'FontSize',14);
            meshView.FaceColor = 'flat';
            meshView.FaceAlpha = 0.5000;
            subplot(1,2,2), meshView = mesh(img_med);
            title('After Median Filtering', 'FontSize',14);
            meshView.FaceColor = 'flat';
            meshView.FaceAlpha = 0.5000;
            
            % Cross Section of Mesh [1st row of pixel only]
            %% Figure Settings
            figure('Name','[Cross Section Mode]Median Filtering (' + string(dimension) + 'x' +  string(dimension)  + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            %% Display accordingly
            subplot(1,2,1), plot(img_Origin(1,:));
            title('Before Median Filtering', 'FontSize',14);
            subplot(1,2,2), plot(img_med(1,:));
            title('After Median Filtering', 'FontSize',14);
             
            % Using 1D median 1xdimension kernel
            %% Figure Settings
            figure('Name','[1D Kernel]Median Filtering (1x' +  string(dimension)  + ')','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            img_med1d = medfilt2(img_Origin,[dimension,1]); % this use the default 3x3
            %% Display accordingly
            subplot(1,2,1), plot(img_Origin(1,:));
            title('Before Median Filtering', 'FontSize',14);
            subplot(1,2,2), plot(img_med1d(1,:));
            title('After Median Filtering', 'FontSize',14);
        end

        function op_filter_Noise(id)
            % Read the origin image from workspace
            img_Origin = evalin('base','img_Origin');
            
            % Convert the RGB image to Gray image if not done so
            try
               img_Origin = rgb2gray(img_Origin); 
            catch
               disp('Image is already gray-level');
            end
            
            % Display the image size
            [row,col,~] = size(img_Origin);
            disp('Image Size (Row,Col)')
            disp(string(row) + '  ' + string(col));
            
            % Figure settings
            figure('Name','Suppressing Noise Interence Pattern (Spectrum Domain)','NumberTitle','off'); % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Convert spatial domain to spectrum domain using FFT
            img_FFT = fft2(img_Origin);
            
            % Get the absolute value of FFT
            S = abs(img_FFT);
            
            % Adjust power spectrum to power of 0.1
            fft_power = S.^0.1;
            
            % Display FFT
            subplot(1,3,1), imagesc(fft_power) , colorbar, axis image ;
            title('Convert to (FFT2D)', 'FontSize',14);
            
            % Display FFTShift
            subplot(1,3,2), imagesc(fftshift(fft_power)), colorbar, axis image; 
            title('Convert to (FFTShift)', 'FontSize',14);
            
            % Offset 2 of the target coordinates such that the surrounding 5by5 will be set zeros is plus minus 2 offset
            offset = 2;
            fft_suppress = img_FFT;
            if id == 1
                % 5 Peaks coordinates (1,1)(9, 241)(249,17)(255,1)(255,256)
                x1 = 1; % DC value
                y1 = 1;
                x2 = 9;
                y2 = 241;
                x3 = 249;
                y3 = 17;
                x4 = 255;
                y4 = 1;
                x5 = 255;
                y5 = 256;

                % Increase to min dimension of threshold (zero or neg value)
                x1min = max(x1-offset,1);
                x1max = max(x1+offset,1);
                y1min = max(y1-offset,1);
                y1max = max(y1+offset,1);
                x2min = max(x2-offset,1);
                x2max = max(x2+offset,1);
                y2min = max(y2-offset,1);
                y2max = max(y2+offset,1);
                x3min = max(x3-offset,1);
                x3max = max(x3+offset,1);
                y3min = max(y3-offset,1);
                y3max = max(y3+offset,1);
                x4min = max(x4-offset,1);
                x4max = max(x4+offset,1);
                y4min = max(y4-offset,1);
                y4max = max(y4+offset,1);
                x5min = max(x5-offset,1);
                x5max = max(x5+offset,1);
                y5min = max(y5-offset,1);
                y5max = max(y5+offset,1);
            
                % Reduce to max dimension of threshold
                x1min = min(col,x1min);
                x1max = min(col,x1max);
                y1min = min(row,y1min);
                y1max = min(row,y1max);
                x2min = min(col,x2min);
                x2max = min(col,x2max);
                y2min = min(row,y2min);
                y2max = min(row,y2max);
                x3min = min(col,x3min);
                x3max = min(col,x3max);
                y3min = min(row,y3min);
                y3max = min(row,y3max);
                x4min = min(col,x4min);
                x4max = min(col,x4max);
                y4min = min(row,y4min);
                y4max = min(row,y4max);
                x5min = min(col,x5min);
                x5max = min(col,x5max);
                y5min = min(row,y5min);
                y5max = min(row,y5max);

                % Apply the coordinates and set zeros accordingly
                %fft_suppress(y1min:y1max,x1min:x1max) = 0;
                fft_suppress(y2min:y2max,x2min:x2max) = 0;
                fft_suppress(y3min:y3max,x3min:x3max) = 0;
                fft_suppress(y4min:y4max,x4min:x4max) = 0;
                fft_suppress(y5min:y5max,x5min:x5max) = 0;
            elseif id == 2
                % Top 7 Peaks coordinates
                % (1,1)(3,256)(11,252)(22,248)(236,10)(247,6)(255,2)
                x1 = 1; % DC value
                y1 = 1;
                x2 = 3;
                y2 = 256;
                x3 = 11;
                y3 = 252;
                x4 = 22;
                y4 = 248;
                x5 = 236;
                y5 = 10;
                x6 = 247;
                y6 = 6;
                x7 = 255;
                y7 = 2;


                % Increase to min dimension of threshold (zero or neg value)
                x1min = max(x1-offset,1);
                x1max = max(x1+offset,1);
                y1min = max(y1-offset,1);
                y1max = max(y1+offset,1);
                x2min = max(x2-offset,1);
                x2max = max(x2+offset,1);
                y2min = max(y2-offset,1);
                y2max = max(y2+offset,1);
                x3min = max(x3-offset,1);
                x3max = max(x3+offset,1);
                y3min = max(y3-offset,1);
                y3max = max(y3+offset,1);
                x4min = max(x4-offset,1);
                x4max = max(x4+offset,1);
                y4min = max(y4-offset,1);
                y4max = max(y4+offset,1);
                x5min = max(x5-offset,1);
                x5max = max(x5+offset,1);
                y5min = max(y5-offset,1);
                y5max = max(y5+offset,1);
                x6min = max(x6-offset,1);
                x6max = max(x6+offset,1);
                y6min = max(y6-offset,1);
                y6max = max(y6+offset,1);
                x7min = max(x7-offset,1);
                x7max = max(x7+offset,1);
                y7min = max(y7-offset,1);
                y7max = max(y7+offset,1);
            
                % Reduce to max dimension of threshold
                x1min = min(col,x1min);
                x1max = min(col,x1max);
                y1min = min(row,y1min);
                y1max = min(row,y1max);
                x2min = min(col,x2min);
                x2max = min(col,x2max);
                y2min = min(row,y2min);
                y2max = min(row,y2max);
                x3min = min(col,x3min);
                x3max = min(col,x3max);
                y3min = min(row,y3min);
                y3max = min(row,y3max);
                x4min = min(col,x4min);
                x4max = min(col,x4max);
                y4min = min(row,y4min);
                y4max = min(row,y4max);
                x5min = min(col,x5min);
                x5max = min(col,x5max);
                y5min = min(row,y5min);
                y5max = min(row,y5max);
                x6min = min(col,x6min);
                x6max = min(col,x6max);
                y6min = min(row,y6min);
                y6max = min(row,y6max);
                x7min = min(col,x7min);
                x7max = min(col,x7max);
                y7min = min(row,y7min);
                y7max = min(row,y7max);

                
                % Apply the coordinates and set zeros accordingly
                %fft_suppress(y1min:y1max,x1min:x1max) = 0; % DC value not
                %used
                fft_suppress(y2min:y2max,x2min:x2max) = 0;
                fft_suppress(y3min:y3max,x3min:x3max) = 0;
                fft_suppress(y4min:y4max,x4min:x4max) = 0;
                fft_suppress(y5min:y5max,x5min:x5max) = 0;
                fft_suppress(y6min:y6max,x6min:x6max) = 0;
                fft_suppress(y7min:y7max,x7min:x7max) = 0;
            elseif id == 3
                % Top 5 Peaks coordinates exclude DC)
                x1 = 1; 
                y1 = 95;
                x2 = 4;
                y2 = 90;
                x3 = 94;
                y3 = 95;
                x4 = 93;
                y4 = 7;
                x5 = 94;
                y5 = 1;


                % Increase to min dimension of threshold (zero or neg value)
                x1min = max(x1-offset,1);
                x1max = max(x1+offset,1);
                y1min = max(y1-offset,1);
                y1max = max(y1+offset,1);
                x2min = max(x2-offset,1);
                x2max = max(x2+offset,1);
                y2min = max(y2-offset,1);
                y2max = max(y2+offset,1);
                x3min = max(x3-offset,1);
                x3max = max(x3+offset,1);
                y3min = max(y3-offset,1);
                y3max = max(y3+offset,1);
                x4min = max(x4-offset,1);
                x4max = max(x4+offset,1);
                y4min = max(y4-offset,1);
                y4max = max(y4+offset,1);
                x5min = max(x5-offset,1);
                x5max = max(x5+offset,1);
                y5min = max(y5-offset,1);
                y5max = max(y5+offset,1);
            
                % Reduce to max dimension of threshold
                x1min = min(col,x1min);
                x1max = min(col,x1max);
                y1min = min(row,y1min);
                y1max = min(row,y1max);
                x2min = min(col,x2min);
                x2max = min(col,x2max);
                y2min = min(row,y2min);
                y2max = min(row,y2max);
                x3min = min(col,x3min);
                x3max = min(col,x3max);
                y3min = min(row,y3min);
                y3max = min(row,y3max);
                x4min = min(col,x4min);
                x4max = min(col,x4max);
                y4min = min(row,y4min);
                y4max = min(row,y4max);
                x5min = min(col,x5min);
                x5max = min(col,x5max);
                y5min = min(row,y5min);
                y5max = min(row,y5max);

                
                % Apply the coordinates and set zeros accordingly
                fft_suppress(y1min:y1max,x1min:x1max) = 0;
                fft_suppress(y2min:y2max,x2min:x2max) = 0;
                fft_suppress(y3min:y3max,x3min:x3max) = 0;
                fft_suppress(y4min:y4max,x4min:x4max) = 0;
                fft_suppress(y5min:y5max,x5min:x5max) = 0;
            elseif id == 4
                % Top 7 Peaks coordinates
                x1 = 4;
                y1 = 85;
                x2 = 4;
                y2 = 84;
                x3 = 7;
                y3 = 83;
                x4 = 85;
                y4 = 85;
                x5 = 80;
                y5 = 4;
                x6 = 83;
                y6 = 3;
                x7 = 83;
                y7 = 2;


                % Increase to min dimension of threshold (zero or neg value)
                x1min = max(x1-offset,1);
                x1max = max(x1+offset,1);
                y1min = max(y1-offset,1);
                y1max = max(y1+offset,1);
                x2min = max(x2-offset,1);
                x2max = max(x2+offset,1);
                y2min = max(y2-offset,1);
                y2max = max(y2+offset,1);
                x3min = max(x3-offset,1);
                x3max = max(x3+offset,1);
                y3min = max(y3-offset,1);
                y3max = max(y3+offset,1);
                x4min = max(x4-offset,1);
                x4max = max(x4+offset,1);
                y4min = max(y4-offset,1);
                y4max = max(y4+offset,1);
                x5min = max(x5-offset,1);
                x5max = max(x5+offset,1);
                y5min = max(y5-offset,1);
                y5max = max(y5+offset,1);
                x6min = max(x6-offset,1);
                x6max = max(x6+offset,1);
                y6min = max(y6-offset,1);
                y6max = max(y6+offset,1);
                x7min = max(x7-offset,1);
                x7max = max(x7+offset,1);
                y7min = max(y7-offset,1);
                y7max = max(y7+offset,1);
            
                % Reduce to max dimension of threshold
                x1min = min(col,x1min);
                x1max = min(col,x1max);
                y1min = min(row,y1min);
                y1max = min(row,y1max);
                x2min = min(col,x2min);
                x2max = min(col,x2max);
                y2min = min(row,y2min);
                y2max = min(row,y2max);
                x3min = min(col,x3min);
                x3max = min(col,x3max);
                y3min = min(row,y3min);
                y3max = min(row,y3max);
                x4min = min(col,x4min);
                x4max = min(col,x4max);
                y4min = min(row,y4min);
                y4max = min(row,y4max);
                x5min = min(col,x5min);
                x5max = min(col,x5max);
                y5min = min(row,y5min);
                y5max = min(row,y5max);
                x6min = min(col,x6min);
                x6max = min(col,x6max);
                y6min = min(row,y6min);
                y6max = min(row,y6max);
                x7min = min(col,x7min);
                x7max = min(col,x7max);
                y7min = min(row,y7min);
                y7max = min(row,y7max);

                
                % Apply the coordinates and set zeros accordingly
                fft_suppress(y1min:y1max,x1min:x1max) = 0;
                fft_suppress(y2min:y2max,x2min:x2max) = 0;
                fft_suppress(y3min:y3max,x3min:x3max) = 0;
                fft_suppress(y4min:y4max,x4min:x4max) = 0;
                fft_suppress(y5min:y5max,x5min:x5max) = 0;
                fft_suppress(y6min:y6max,x6min:x6max) = 0;
                fft_suppress(y7min:y7max,x7min:x7max) = 0;
              
            end
              
           
            
            % Get the absolute value of FFT
            newS = abs(fft_suppress);
            
            % Adjust power spectrum to power of 0.1
            fft_power_suppress = newS.^0.1;
            
            % Show FFT in spectrum domain after mask
            subplot(1,3,3), imagesc(fft_power_suppress), colorbar, axis image;
            title('Top Peaks coordinates with mask (5x5) 0s', 'FontSize',14);
            
            % Show the highest intensity value of FFT
            disp('Highest Intensity Value: ' +  string(max(fft_power(:))));
            
            % Figure Setting
            figure('Name','Identify Peaks in Mesh','NumberTitle','off'); % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Duplicate a copy for mesh display
            fft_power_copy = fft_power;
            subplot(1,1,1), mesh(fft_power_copy);
            
            % Figure Settings
            figure('Name','Suppressing Noise Interence Pattern (Spatial Domain)','NumberTitle','off'); % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Show Origin Image
            subplot(1,3,1), imshow(img_Origin);
            title('Before Fast Fourier Transform (FFT)', 'FontSize',14);
            
            % Apply ifft
            inverse_img = ifft2(fft_suppress);
            
            % Show the conversion the output of IFFT
            disp('Inverse Image Single Sample Output:')
            disp(inverse_img(1,1));
            disp('Inverse Image Single Sample Output (Real Number Component):')
            disp(real(inverse_img(1,1)));
            disp('Inverse Image Single Sample Output (Normalize to uint8 (int between 0 to 255):')
            disp(uint8(real(inverse_img(1,1))));
            
            % Conversion IFFT in order to display as a image
            inverse_img_real = uint8(real(inverse_img));
            
            % Display output
            subplot(1,3,2), imshow(inverse_img_real);
            title('After Inverse Fast Fourier Transform (IFFT)', 'FontSize',14);
            
                
            % Show the current intensity value
            disp('Minimum Intensity Value:');
            disp(min(inverse_img_real(:)));
            disp('Maximum Intensity Value:');
            disp(max(inverse_img_real(:)));
            % Apply Histogram Equalization again
            inverse_img_real_eq = histeq(inverse_img_real,255);
            subplot(1,3,3),imshow(inverse_img_real_eq);
            title('Image Enhancement with histeq', 'FontSize',14);
            
        end
        
        function op_adjust_Distortion
            % Read the origin Image from workspace
            img_Origin = evalin('base','img_Origin');

            % Figure Settings
            figure('Name','Undoing Perspective Distortion of Planar Surface','NumberTitle','off'); % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Show Origin Images
            subplot(1,2,1), imshow(img_Origin);
            title('Before Transform', 'FontSize',14);
            
            % Prompt User for Input
            [X, Y] = ginput(4);
            
            % Get the size images
            [row,col,~] = size(img_Origin);
            disp('Image Size (row,col):');
            disp(string(row) + '   ' + string(col));
            
            % Pin-Point the 4 coordinates correct orientation top-left then move clockwise
            disp('X and Y Coordinate: ');
            disp([X,Y]);
            
            % Specify the coordinates for the output 
            x = [0; 210; 210; 0];
            y = [0; 0; 297; 297];
            
            % Formulate the formulate
            v = zeros(8, 1);
            A = zeros(8, 8);
            for i = 1:4
                A(2*i-1 : 2*i, :) = [X(i) Y(i) 1 0 0 0 -x(i)*X(i) -x(i)*Y(i); 0 0 0 X(i) Y(i) 1 -y(i)*X(i) -y(i)*Y(i)];
                v(2*i-1 : 2*i) = [x(i), y(i)];
            end
            
            disp('Transformation Matrix Values:')
            disp(A);

            u = A\v;
            
            % Calculate U
            U = reshape([u;1],3,3)'; 
            
            % Show U
            disp('U 2d-array values:')
            disp(U);
            
            % Calculate w
            w = U*[X'; Y'; ones(1,4)];
            w = w./ (ones(3,1) * w(3,:));
            
            % Show w
            disp('w 2d-array values:')
            disp(w); 
            
            % Transform the image
            T = maketform('projective', U'); 
            img_transform = imtransform(img_Origin, T, 'XData', [0 210], 'YData', [0 297]);

            % Update the output in the existing figure
            subplot(1,2,2), imshow(img_transform) , axis normal;
            title('After Transform', 'FontSize',14);
        end
    end
end