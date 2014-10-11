function Rec=FraRecMultiLevel2D(C,R,L)
    % function Rec=FraRecMultiLevel(C,R,L)
    % This function implement framelet reconstruction up to level L.
    % C ==== the data to be reconstructed, which are in cells in C{i,j} with
    % C{1,1} being a cell.
    % R ==== is the reconstruction filter in 1D. In 2D, it is generated by tensor
    % product. The filter D must be symmetric or anti-symmetric, which
    % are indicated by 's' and 'a' respectively in the last cell of R.
    % L ==== is the level of the decomposition.
    % Rec ==== is the reconstructed data.

    % Written by Jian-Feng Cai.
    % email: tslcaij@nus.edu.sg
    % Added to FrameLab by Nick Henscheid 2014
    nR=length(R);
    for k=L:-1:2
        C{k-1}{1,1}=FraRec2D(C{k},R,k);
    end
    Rec=FraRec2D(C{1},R,1);
end


function Rec=FraRec2D(C,R,L)
    % function Rec=FraRec(C,R,L)
    % This function implement framelet reconstruction.
    % C ==== the data to be reconstructed, which are in cells in C{i,j} with
    % C{1,1} being a cell.
    % R ==== is the reconstruction filter in 1D. In 2D, it is generated by tensor
    % product. The filter D must be symmetric or anti-symmetric, which
    % are indicated by 's' and 'a' respectively in the last cell of R.
    % L ==== is the level of the decomposition.
    % Rec ==== is the reconstructed data.

    % Written by Jian-Feng Cai.
    % email: tslcaij@nus.edu.sg

    nR=length(R);
    SorAS=R{nR};
    ImSize=size(C{1,1});
    Rec=zeros(ImSize);
    for i=1:nR-1
        temp=zeros(ImSize);
        for j=1:nR-1
            M2=R{j};
            temp=temp+(ConvSymAsym2D((C{i,j})',M2,SorAS(j),L))';
        end
        M1=R{i};
        Rec=Rec+ConvSymAsym2D(temp,M1,SorAS(i),L);
    end
end