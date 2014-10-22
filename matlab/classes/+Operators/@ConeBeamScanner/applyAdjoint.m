function y=applyAdjoint(this,object)
    %***Apply adjoint cone beam operator to an object of type
    %CTData('cone')
    
    if(isempty(fieldnames(this.para)))
        this.para = object.para; %If the scanner's parameters aren't set,import para from the object
        
    else
        if(~structcmp(this.para,object.para))
            error('Object scan parameters and scanner parameters do not agree!')
        end
    end

    X0 = object.dataArray(:);
    if gpuDeviceCount==0
        this.para.GPU = uint32(0);
        this.checkInputs(X0);
        if(this.verbose)
            disp('Computing forward cone beam transform with CPU');
            this.para
        end
        y = Atx_cone_mf(X0,this.para);
    elseif gpuDeviceCount>0
        this.para.GPU = uint32(1);
        this.checkInputs(X0);
        if(this.verbose)
            disp('Computing forward cone beam transform with GPU');
            this.para
        end
        y = Atx_cone_mf(X0,this.para);
    end
    
    y = DataTypes.ObjectData(3,reshape(y,[this.para.nx this.para.ny this.para.nz]),object.L);
end