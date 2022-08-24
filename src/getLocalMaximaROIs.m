function mni = getLocalMaximaROIs

    CriticalTs = [4 4 4] ;

    maskFn = {'NeurosynthMasks/hMT.nii'
          'NeurosynthMasks/parietalCortex.nii'
          'NeurosynthMasks/somatosensoryCortex.nii'};
     
    mni = cell(1,length(maskFn) );
    
    for iMask = 1:length(maskFn)
        
        fprintf('Running Mask %.0f \n\n',iMask)
        CriticalT = CriticalTs(iMask);

        for iSub=1:length(data)
            
            fprintf('Running Subject %.0f \n',iSub)
            
            SubName = data(iSub).id{1}{1}(14:end) ; 
            
            %%
            
            maskFile = fullfile(pwd,'NeurosynthMasks',maskFn{iMask});
            r = load_nii(result_file);
            m = load_nii(maskFile);
            
            r.img(~m.img)=0;
            
            maxVal = max(r.img(:))
            mx(iSub, iMask)=maxVal;
            if maxVal > CriticalT %|| maxVal < CriticalT
                
                voxel_idx= find(r.img==maxVal) ;
                [x, y, z] = ind2sub(size(r.img),voxel_idx)
                mni{1,iMask}(iSub,:) = cor2mni([x y z],maskFile)         
                mni{1,iMask}(iSub,1) = mni{1,iMask}(iSub,1)* -1;   % I dont know why, but fixes the the -1 error in the x axis
                
                mni{1,iMask}(iSub,:)
                
            else
                mni{1,iMask}(iSub,1:3) = nan ;
            end
            
        end
    end

    save(['mni_coordinates_VisualLoc',num2str(CriticalTs(1)),'.mat'],'mni','maskFn','data')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% cor2mni
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mni = cor2mni(cor,nifti_image)
% function mni = cor2mni(cor, T)
% convert matrix coordinate to mni coordinate
%
% cor: an Nx3 matrix
% T: (optional) rotation matrix
% mni is the returned coordinate in mni space
%
% caution: if T is not given, the default T is
% T = ...
%     [-4     0     0    84;...
%      0     4     0  -116;...
%      0     0     4   -56;...
%      0     0     0     1];
%
% xu cui
% 2004-8-18
% last revised: 2005-04-30

% if nargin == 1
%     T = ...
%         [-4     0     0    84;...
%          0     4     0  -116;...
%          0     0     4   -56;...
%       0     0     0     1];
% end

V=spm_vol(nifti_image);
T = V.mat;

cor = round(cor);
mni = T*[cor(:,1) cor(:,2) cor(:,3) ones(size(cor,1),1)]';
mni = mni';
mni(:,4) = [];
end
