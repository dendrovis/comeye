%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Course : CZ4003 Computer Vision
% Subject : Assignment 2
% Name : Sam Jian Shen
% Matrix Number : U1821296L
% Version : 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef Lab2
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
        
        function ini2(URL_L,URL_R,URL_Ans)
            % Checking Input
            disp('Executing Ini...')
            if isempty(URL_L)
                print('Empty String for Left Image')
                return
            end
            if isempty(URL_R)
                print('Empty String for Right Image')
                return
            end
            if isempty(URL_Ans)
                print('Empty String for Sample Outcome Image')
                return
            end
            % Read and convert image operation 
            img_Left = imread(URL_L);
            img_Right = imread(URL_R);
            img_Ans = imread(URL_Ans);
            disp('Left Image Properties');
            whos img_Left;
            disp('Right Image Properties');
            whos img_Right;
            disp('Sample Outcome Image Properties');
            whos img_Ans;
            disp('Sucessfully - Read Img ');
            
            % Store image into workspace
            assignin('base','img_Left',img_Left)
            assignin('base','img_Right',img_Right)
            assignin('base','img_Ans',img_Ans)
            disp('Store Left, Right, Given Solution Images into Workspace');
            disp('End Ini');
            
        end
        
        function op_greyScale
            % Read Origin Image from workspace
            img_Origin = evalin('base','img_Origin');
            % Convert the RGB image to Gray image if not done so
            try
               % Convert to grey-scale image
               img_Grayscale = rgb2gray(img_Origin); 
            catch
               disp('Image is already gray-level');
               img_Grayscale = img_Origin;
            end
            
            disp('Sucessfully - Convert GrayScale Img ')
            % Store Origin Image into workspace
            assignin('base','img_GreyScale',img_Grayscale);
            disp('Store Grey Scale Image into Workspace'); 
            % Figure Settings
            figure('Name','Conversion before Edge Detection','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display origin of the image before convert to gray-level image
            subplot(1,2,1), imshow(img_Origin);
            title('Origin','FontSize', 14);
            % Display gray-level of the image
            subplot(1,2,2), imshow(img_Grayscale);
            title('Grayscale','FontSize', 14);
        end
        
        function op_greyScale2
            % Read Left and Right Image from workspace
            img_Left = evalin('base','img_Left');
            img_Right = evalin('base','img_Right');
            % Convert the RGB image to Gray image if not done so
            try
               % Convert to grey-scale image for left
               img_LeftGray = rgb2gray(img_Left);            
            catch
               disp('[Warning] Left image is already gray-level');
               img_LeftGray = img_Left;
            end
            try
               % Convert to grey-scale image for right
               img_RightGray = rgb2gray(img_Right);            
            catch
               disp('[Warning] Right image is already gray-level');
               img_RightGray = img_Right;
            end
            
            disp('Sucessfully - Convert GrayScale Images ')
            % Store Origin Image into workspace
            assignin('base','img_LeftGray',img_LeftGray);
            assignin('base','img_RightGray',img_RightGray);
            disp('Store Left and Right Grey Scale Image into Workspace'); 
            % Figure Settings
            figure('Name','Grayscale Conversion','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display left and right origin of the image
            subplot(2,2,1), imshow(img_Left);
            title('Origin Left','FontSize', 14);
            subplot(2,2,2), imshow(img_Right);
            title('Origin Right','FontSize', 14);
            % Display left and right gray-level of the image
            subplot(2,2,3), imshow(img_LeftGray);
            title('Grayscale Left','FontSize', 14);
            subplot(2,2,4), imshow(img_RightGray);
            title('Grayscale Right','FontSize', 14);
        end
        
        function img_edge = op_sobel(square)
            %Declare sobel kernel (horizontal and vertical)
            kernel_x = [-1 0 1; -2, 0 2; -1 0 1];
            kernel_y = [-1 -2 -1; 0 0 0; 1 2 1];
            % Display sobel kernel arrays
            disp('Display Sobel X-Direction Kernel');
            disp(kernel_x);
            disp('Display Sobel Y-Direction Kernel');
            disp(kernel_y);

            % Read Gray Image from workspace
            img_GreyScale = evalin('base','img_GreyScale');
            
            % Figure Settings
            figure('Name','Sobel Masks','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Display x-direction sobel kernel in 3D
            subplot(1,2,1), mesh(kernel_x);
            title('X-Direction Kernel Mesh','FontSize', 14);
            % Display y-direction sobel kernel in 3D
            subplot(1,2,2), mesh(kernel_y);
            title('Y-Direction Kernel Mesh','FontSize', 14);

            % Apply filters with Gray-level Image (vertical and horizontal)
            % respectively
            if square == 0
                img_edge_x = conv2(img_GreyScale, kernel_x,'same');
                img_edge_y = conv2(img_GreyScale, kernel_y,'same');
                img_edge = img_edge_x + img_edge_y;
            elseif square == 1
                img_edge_x = conv2(img_GreyScale, kernel_x,'same').^2;
                img_edge_y = conv2(img_GreyScale, kernel_y,'same').^2;
                img_edge = img_edge_x + img_edge_y;
            else
                img_edge_x = sqrt(conv2(img_GreyScale, kernel_x,'same').^2);
                img_edge_y = sqrt(conv2(img_GreyScale, kernel_y,'same').^2);
                img_edge = img_edge_x + img_edge_y;
            end
            
            % Normalize to uint8 0-255 range
            img_edge_x_uint8 = uint8(img_edge_x);
            img_edge_y_uint8 = uint8(img_edge_y);
            img_edge_uint8 = uint8(img_edge);
            
            
            
            % Figure Settings
            figure('Name','Edge Detection','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display horizontal edge
            subplot(1,3,1), imshow(img_edge_y_uint8);
            title('Y-Direction Sobel Kernel','FontSize', 14);
            % Display vertical edge
            subplot(1,3,2), imshow(img_edge_x_uint8);
            title('X-Direction Sobel Kernel','FontSize', 14);
            % Display all edge
            subplot(1,3,3), imshow(img_edge_uint8);
            title('Combine','FontSize', 14);
            
            % Display max and min value of the image
            disp('Image Min Value before normalize:')
            disp(min(img_edge(:)));
            
            disp('Image Max Value before normalize:')
            disp(max(img_edge(:)));
            
            % Figure Settings
            figure('Name','Histogram Image before Normalize','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display the value distribution of the image before and after
            % normalize
            subplot(1,2,1), histogram(img_edge,200);
            title('Before Normalize','FontSize', 14);
            subplot(1,2,2), histogram(img_edge_uint8,200);
            title('After Normalize','FontSize', 14);
            
            

        end
        
        function op_threshold(image)

            % Get the range of intensity in the image
            min_t = min(image(:));
            range = max(image(:))-min(image(:));
            
            % Display max and min value of the binary image
            disp('Binary Image Min Value:')
            disp(min_t);
            
            disp('Binary Image Max Value:')
            disp(max(image(:)));
            
            disp('Range Image Intensity Value:')
            disp(range);
            
            % Apply threshold and return a binary image base on percentile
            % of the image intensity
            t10 = min_t + (range/100)*10;
            t15 = min_t + (range/100)*15;
            t20 = min_t + (range/100)*20;
            t25 = min_t + (range/100)*25;
            t50 = min_t + (range/100)*50;
            t75 = min_t + (range/100)*75;
            
            image_threshold1 = image > t10;
            image_threshold2 = image > t15;
            image_threshold3 = image > t20;
            image_threshold4 = image > t25;
            image_threshold5 = image > t50;
            image_threshold6 = image > t75;
            
            % Figure Settings
            figure('Name','Threshold Image','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display image when threshold with different range of values
            subplot(2,3,1), imshow(image_threshold1);
            title('Threshold 10% = ' + string(t10),'FontSize', 14);
            subplot(2,3,2), imshow(image_threshold2);
            title('Threshold 15% = ' + string(t15),'FontSize', 14);
            subplot(2,3,3), imshow(image_threshold3);
            title('Threshold 20% = ' + string(t20),'FontSize', 14);
            subplot(2,3,4), imshow(image_threshold4);
            title('Threshold 25% = ' + string(t25),'FontSize', 14);
            subplot(2,3,5), imshow(image_threshold5);
            title('Threshold 50% = ' + string(t50),'FontSize', 14);
            subplot(2,3,6), imshow(image_threshold6);
            title('Threshold 75% = ' + string(t75),'FontSize', 14);
        end
        
        
        function op_sobel_special(input,square)
            %Declare sobel kernel (horizontal and vertical)
            kernel_x = [-1 0 1; -2, 0 2; -1 0 1];
            kernel_y = [-1 -2 -1; 0 0 0; 1 2 1];
            
            % Apply filters with Gray-level Image (vertical and horizontal)
            % respectively
            if square == false
                x = conv2(input, kernel_x,'same');
                y = conv2(input, kernel_y,'same');
                edge = x + y;
            else
                x = conv2(input, kernel_x,'same').^2;
                y = conv2(input, kernel_y,'same').^2;
                edge = x + y;
            end 
            
            disp('Input')
            disp(input)
            
            disp('Before normalize Y-Direction Edge')
            disp(y)
            disp('Before normalize X-Direction Edge')
            disp(x)
            disp('Before normalize Combine Edge')
            disp(edge)
            
            % Normalize to uint8 0-255 range
            x = uint8(x);
            y = uint8(y);
            edge = uint8(edge);
            
            disp('After normalize Y-Direction Edge')
            disp(y)
            disp('After normalize X-Direction Edge')
            disp(x)
            disp('After normalize Combine Edge')
            disp(edge)

            
            % Figure Settings
            figure('Name','Edge Detection 3 by 3 Input','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            % Display input
            subplot(2,2,1), imshow(input);
            title('Input','FontSize', 14);
            % Display horizontal edge
            subplot(2,2,2), imshow(y);
            title('Y-Direction Sobel Kernel','FontSize', 14);
            % Display vertical edge
            subplot(2,2,3), imshow(x);
            title('X-Direction Sobel Kernel','FontSize', 14);
            % Display all edge
            subplot(2,2,4), imshow(edge);
            title('Combine','FontSize', 14);
            
            disp('end operation');
            
        end
        
        function op_canny(tl,th)
            % Read Gray Image from workspace
            img_GreyScale = evalin('base','img_GreyScale');
            % Figure Settings
            figure('Name','Canny Edge Detection Threshold Lower = ' + string(tl),'NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            subplot(3,3,1), imshow(img_GreyScale);
            title('Input','FontSize', 14);
            for sigma = 1:1:5
                image_canny = edge(img_GreyScale,'canny',[tl th],sigma); 
                % Display Image after canny edge detection algorithm
                subplot(3,3,sigma+1), imshow(image_canny);
                title('Threshold[' + string(tl) + ',' + string(th)+ '] Sigma: ' + string(sigma),'FontSize', 14);
            end
        end
        
        function op_cannyHT(tl,th, sigma)
            % Read Gray Image from workspace
            img_GreyScale = evalin('base','img_GreyScale');
            % Figure Settings
            figure('Name','Radon Transform','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            subplot(1,3,1), imshow(img_GreyScale);
            title('Input','FontSize', 14);
            image_canny = edge(img_GreyScale,'canny',[tl th],sigma); 
            % Display Image after canny edge detection algorithm
            subplot(1,3,2), imshow(image_canny);
            title('Threshold[' + string(tl) + ',' + string(th)+ '] Sigma: ' + string(sigma),'FontSize', 14);
            % Store image into workspace
            assignin('base','img_Canny',image_canny)
            disp('Store Canny Image into Workspace');
            disp('End Ini');
        end
        
        function op_radon
            % Read Canny Image from workspace
            img_Canny = evalin('base','img_Canny');
            [H, xp] = radon(img_Canny);
            subplot(1,3,3), imshow(uint8(H));
            title('Parameter Space','FontSize', 14);
            
            % Figure Settings
            figure('Name','Radon Transform Generation','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            [H1, xp1] = radon(img_Canny,0:1:59);
            [H2, xp2] = radon(img_Canny,60:1:119);
            [H3, xp3] = radon(img_Canny,120:1:179);
            H4 = radon(img_Canny,0);
            subplot(1,3,1), imshow(uint8(H1));
            title('Parameter Space (Deg 0 to 59)','FontSize', 14);
            subplot(1,3,2), imshow(uint8(H2));
            title('Parameter Space (Deg 60 to 119)','FontSize', 14);
            subplot(1,3,3), imshow(uint8(H3));
            title('Parameter Space (Deg 120 to 179)','FontSize', 14);
            subplot(1,3,3), imshow(uint8(H3));
            
            % Figure Settings
            figure('Name','Radon Transform Projection','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            plot(H4);
            title('Projection Shape (Deg 0)','FontSize', 14);
            
            % Figure Settings
            figure('Name','Radon Transform (Colorize) and Strongest Edge''s Line Plot','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            subplot(1,3,1), imagesc(uint8(H));
            title('Radon Transform (Color Map)','FontSize', 14);

            % Find maximum intensity value of parameter space (row and col)
            [y,in] = max(uint8(H));
            [value,col_maxI] = max(y);
            [~,row_maxI] = max(H(:,col_maxI));
            disp('Maximum Value for theta:');
            disp(col_maxI);
            disp('Maximum Value for radius: ');
            disp(row_maxI);
            
            % Find the theta and radial coordinate value
            theta = col_maxI;
            radius = xp(row_maxI);
            
            % Find Center of an Imagee
            center=size(img_Canny)/2+.5;
            disp('The center of the image coordinate (x,y)');
            disp(center);
            y_off = center(1);
            x_off = center(2);
            
            
            % Finding the line equation with given theta and radius
            % Line equation is represent by Ax + By = C , Let C = 0
            % Convert Polar to Cartesian Format
            [A, B] = pol2cart(theta*pi/180, radius);
            B = -B;
            C = A*(A+x_off) + B*(B+y_off);

            disp('Line Equation''s A is');
            disp(A);
            disp('Line Equation''s B is');
            disp(B);
            disp('Line Equation''s C is');
            disp(C); 
            
            % Compute yl and yr with xl and xr
            img_dimension = size(img_Canny);
            y = img_dimension(2); % width
            xl = 0;
            xr = y - 1;
            yl = (C - A* xl) / B;
            yr = (C - A* xr) / B;
            
            disp('yl is');
            disp(yl);
            disp('yr is');
            disp(yr);
            
            % Read Origin Image from workspace
            img_Origin = evalin('base','img_Origin');
            % Plot the line with origin images
            subplot(1,3,2),imshow(img_Origin);
            line([xl xr], [yl yr],'Color','red','LineWidth',2);
            title('Most Edge-like in the Origin image','FontSize', 14);
            
        end
        
        function op_Gaussian
            % Figure Settings
            figure('Name','Gaussian Filter','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            for size = 1:1:5
                N=5;M=5;dN=.01;dM=.01;
                [U,V] = meshgrid([0:dN:N],[0:dM:M]);
                s=size;
                H= exp(-1/s^2*((U-N/2).^2+(V-M/2).^2));
                % Display Image after canny edge detection algorithm
                subplot(3,3,size), hs=surf(U,V,H);
                title('Filter Size [' + string(size) + 'x' + string(size)+ ']','FontSize', 14);
                hs.EdgeColor='none';
            end
        end
        
        function D = op_stereo3d(imgL,imgR,Tx,Ty)
            %%------------------------------ Preprocess ------------------------------
            % Check if block size is odd number
            if(rem(Tx,2) == 0 || rem(Ty,2) == 0)
                disp('Please declare a odd number block size')
                return 
            end

            % Find the dimension of the images
            [yl,xl] = size(imgL);
            [yr,xr] = size(imgR);
            disp('Image Dimension (Width,Height) is')
            disp(string(xl) + ',' + string(yl))

            % Check if left and right image size is the same
            if(xl ~= xr || yl ~= yr)
                disp('[Error] Please ensure left and right dimension is the same. Try Again!')
                return
            end

            % Find center index value of the block
            center = ceil(Tx/2); % Use ceiling since matlab index start from 1
            disp('Center Size is')
            disp(center)
            
            % Create a canvas filled with value 1 (remove corner pixels that will not be
            % process) (Dimension X or Y - Block Size) w
            D = ones(yl - (Ty - 1), xl - (Tx -1));
            disp('Canvas Size:')
            disp(size(D));

            %%------------------------------ SSD Algorithms------------------------------
            % Define start and end pixel coordinate of SSD operation
            start_x = center;
            start_y = center;
            stop_x = xl - center + 1;
            stop_y = yl - center + 1;
            disp('X Start to End');
            disp(string(start_x) + '   ' + string(stop_x));
            disp('Y Start to End');
            disp(string(start_y) + '   ' + string(stop_y));

            % Constrain Search Space
            limitsearch = 14;
            disp('Limit Search Space (Pixels)');
            disp(limitsearch);
            
            % Create a template size of all 1 for SSD Eq1
            T_1 = ones(Tx, Tx);
            disp('1s Kernel for SSD Eq1');
            disp(T_1);

            % Tranverse y-axis (top-down)
            for cur_y = start_y:1:stop_y               
                % Tranverse x-axis (left-right)
                for cur_x = start_x:1:stop_x
                    % Extract the template from left imag  M = N(1:n,end-n+1:end)
                    T = double(imgL(cur_y-5:cur_y+5,cur_x-5:cur_x+5));

                    % Rotate by 180 degrees with 2 rot90 function
                    Tr = rot90(T,2);
                    
                    % Reset/Initialize minimum differences
                    min_diff = inf;
                    
                    % Initialize starting cordinates to be compare with ref
                    % coodinates
                    min_coor = cur_x;
                    % Search for similarity in the right image 
                    %(14 pixels to the left and right)
                    for cur_s = cur_x - limitsearch:1:cur_x + limitsearch
                        % Out of bound search area
                        if(cur_s > stop_x || cur_s < start_x)
                            continue
                        end
                        
                        % Get Right side as reference image
                        cur_r = double(imgR(cur_y - 5:cur_y+5,cur_s-5:cur_s+5));

                        % Calculate SSD with Decompose Formula (Note: One flip
                        % kernel will do)
                        SSD_eq1 = sum(conv2((cur_r).^2,T_1,'valid'),'all');
                        SSD_eq2 = sum(sum(((T).^2)));
                        SSD_eq3 = sum(2*conv2(cur_r,Tr,'valid'),'all');
                        
                        % Calculate SSD with all required equation
                        SSD = SSD_eq1 + SSD_eq2 - SSD_eq3;

                        % Find the minimum differences amongst all the SSD
                        % matching values
                        if(SSD < min_diff)
                            min_diff = SSD;
                            min_coor = cur_s;
                        end
                    end
                    
                    % Return the offset differences
                    D(cur_y-center+2,cur_x-center+2) = -(cur_x - min_coor);
                end 
            end
        end
        
        function display_dmap(imgS)
            %disp(imgS)
            % Read Answer Image for Comparison
            imgL = evalin('base','img_LeftGray');
            imgR = evalin('base','img_RightGray');
            imgA = evalin('base','img_Ans');
            
            % Figure Settings
            figure('Name','3D Stereo','NumberTitle','off') % change window name
            set(gcf, 'Position', get(0, 'Screensize')); % set figure fullscreen
            
            % Plotting
            subplot(2,2,1),imshow(imgL);
            title('Left image','FontSize', 14);
            subplot(2,2,2),imshow(imgR);
            title('Right image','FontSize', 14);
            subplot(2,2,3),imshow(-imgS,[-15,15]);
            title('Compute image','FontSize', 14);
            subplot(2,2,4),imshow(imgA);
            title('Given Answer image','FontSize', 14);

        end
        
    end
end

