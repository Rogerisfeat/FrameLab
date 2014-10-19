classdef FanBeamScanner < handle
    properties (SetAccess = private)
        scanType = '2DFan'; %Support for other geometries later
        nd = 256; %Number of detectors
        nv = 256; %Number of views
        SO = single(54.1);%Source to isocenter
        OD = single(40.8);%Detector to isocenter
        dy_det =single(0.15/2); %Detector spacing  (!!!NEED DEFAULT VALUE!!!)
        para = struct; %struct of parameters to pass to Gao's methods
        y_os = single(0.0);
    end
    
    
    methods
        %***Constructor***%
        function obj = FanBeamScanner(nd,nv)
            %!!!Should check inputs and throw errors if invalid
            if nargin>0
                obj.nd = nd;
                obj.nv = nv;
            end
        end%Constructor
        
        %***Forward scan***%
        y = apply(this,object)
        
        %***Adjoint (Backprojection)***%
        y = applyAdjoint(this,object)
    end %Methods 
    
    methods (Static = true)
        %***Geometry Plotter***%
        function plotGeometry()
            %Do nothing 
        end
    end%Static methods
end