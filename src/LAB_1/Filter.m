classdef Filter
    
    properties (Access = private)
        %initialize default value
        sigma;
        x;
        y;
        
    end
    
    methods (Static)
        function obj = Filter(xx,yy,sigmas)
            %FILTER Construct an instance of this class
            %   Detailed explanation goes here
            %obj.Property1 = inputArg1 + inputArg2;
            obj.x = xx;
            obj.y = yy;
            obj.sigma = sigmas;
            
            result2 = Filter.test(1,2,3);
            %result = ave_Gaussian_Filter(filter.x,filter.y,filter.sigma);
            %disp(result);
            result3 = Filter.test2(obj);
            disp('Hello World');
            disp(obj.sigma);
            disp(result2);
            disp(result3);
        end
        
        
        function [result] = ave_Gaussian_Filter(x,y,sigma)
            
            upper_Notation = -1*((x^2+y^2)/(2*sigma^2));
            
            result = (1/(2*pi*(sigma^2))) * exp(upper_Notation);
            
            return;
        end
        
        function result = test(a,b,c)
            
            result = a + b + c;
        end
        
        function result = test2(obj)
            
            result = obj.x + obj.y + obj.sigma;
        end
        
        %{
        function obj = Filter(inputArg1,inputArg2)
            %FILTER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        %}
    end
end

