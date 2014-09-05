function Dec=FraDec3D(A,D,L)

% function Dec=FraDec(A,D,L)
% This function implement framelet decomposition.
% A ==== the data to be decomposed, which are in a square matrix.
% D ==== is the decomposition filter in 1D. In 2D, it is generated by tensor
% product. The filter D must be symmetric or anti-symmetric, which
% are indicated by 's' and 'a' respectively in the last cell of D.
% L ==== is the level of the decomposition.
% Dec ==== is the framlet coefficient which are in a cell.

nD=length(D);
SorAS=D{nD};
Dec=cell(nD-1,nD-1,nD-1);
% A=single(A);
for i=1:nD-1
    M1=D{i};
        tempi=ipermute(ConvSymAsym3D(permute(A,[2 1 3]),M1,SorAS(i),L),[2 1 3]);
%         tempi=single(ipermute(ConvSymAsym3D(permute(A,[2 1 3]),M1,SorAS(i),L),[2 1 3]));
    for j=1:nD-1
        M2=D{j};        
        tempj=ConvSymAsym3D(tempi,M2,SorAS(j),L);
%         tempj=single(ConvSymAsym3D(tempi,M2,SorAS(j),L));
        for k=1:nD-1
            M3=D{k};        
            tempk=ipermute(ConvSymAsym3D(permute(tempj,[3 2 1]),M3,SorAS(i),L),[3 2 1]);
%             tempk=single(ipermute(ConvSymAsym3D(permute(tempj,[3 2 1]),M3,SorAS(i),L),[3 2 1]));
            Dec{i,j,k}=tempk;
        end
    end
end