%% Create ROIs based on peak coordinates from thesingle subjects
%
% Script from Iqra: tmpCreateROIs and marsbar_create_ROIs merged together
%
% Steps:
% 1 - open bspmview Manually get the peak coordinates in each subject for each ROI
% 2 - load sub-XXX_contrast_spmT.nii
% 3 - go near your ROI and right-click to "nearest peak"
% 3B- for LOC and pFS, applied coordinates from Neurosynth and
%     chose the highest peak 
%     * (LOC: -46 -70 -5  and 42 -50 -20)
%     * (pFS: -40 -54 -18 and 42 -50 -20)
% 4 - save coordinates below
% 5 - run section-by-section
%
% sub-001
% vwfa  [-46.8  -70.4   -12.8]
% LOC-L [-46.8  -67.8    0.2]
% PFS-L [-33.8  -57.4   -20.6]
% LOC-R [ 49.4  -62.8   -5]
% PFS-R [ 36.4  -57.4   -20.6] 
%
% sub-002
% vwfa  [-49.4  -57.4   -12.8]
% LOC-L [-46.8  -62.6   -7.6]
% PFS-L [-46.8  -80.8   -2.4]
% LOC-R [ 46.8  -70.4   -5]
% PFS-R [ 41.6  -65.2   -15.4]
%
% sub-003
% vwfa  [-49.4  -60     -20.6]
% LOC-L [-39    -73     -2.4] 
% PFS-L [-28.6  -52.2   -15.4] 
% LOC-R [ 44.2  -80.8   -5]    
% PFS-R [ 31    -47     -20.6]
%
% mni{sub_number}(contrast number, coordinates)
% mni{1}= [-46 64 4]

%% clear
clear;
clc;
%% coordinates
% 
%
% % SUB-001
% mni{1}(1,1:3)= [-5.720000e+01, -6.780000e+01, 1.999974e-01];  % visLV5
% mni{1}(2,1:3)= [5.720000e+01, -6.260000e+01, 5.399997e+00];  % visRV5
% mni{1}(3,1:3)= [-3.900000e+01, -3.400000e+01, 6.260000e+01];  % tacLS1
% mni{1}(4,1:3)= [ -5.720000e+01, -3.400000e+01, 4.700000e+01];  % tacLPC
% mni{1}(5,1:3)= [ ];  % tacRPC
% mni{1}(6,1:3)= [ 4.940000e+01, -6.280000e+01, -0.500000e+01];  % tacLV5
% mni{1}(7,1:3)= [ 5.720000e+01, -4.700000e+01, -2.400002e+00];  % tacRV5
% mni{1}(8,1:3)= [ 26, -58, 43];  % tacRVIP
% 
% % % SUB-002
% mni{2}(1,1:3)= [-4.940000e+01, -7.560000e+01, -5.000002e+00];  % visLV5
% mni{2}(2,1:3)= [4.160000e+01, -6.520000e+01, -2.400002e+00];  % visRV5
% mni{2}(3,1:3)= [-2.080000e+01, -2.620000e+01, 7.559999e+01];  % tacLS1
% mni{2}(4,1:3)= [ -2.080000e+01, -5.740000e+01, 6.000000e+01];  % tacLPC
% mni{2}(5,1:3)= [ ];  % tacRPC
% mni{2}(6,1:3)= [ -4.940000e+01, -4.440000e+01, -2.400002e+00];  % tacLV5
% mni{2}(7,1:3)= [ 5.720000e+01, -6.000000e+01, 5.399997e+00];  % tacRV5
% mni{2}(8,1:3)= [26, -58, 43];  % tacRVIP
% % 
% % 
% % SUB-003
% mni{3}(1,1:3)= [-5.720000e+01, -6.780000e+01, 5.399997e+00];  % visLV5
% mni{3}(2,1:3)= [5.200000e+01, -6.780000e+01, 2.799997e+00];  % visRV5
% mni{3}(3,1:3)= [-4.420000e+01, -2.880000e+01, 6.779999e+01];  % tacLS1
% mni{3}(4,1:3)= [ ];  % tacLPC
% mni{3}(5,1:3)= [ ];  % tacRPC
% mni{3}(6,1:3)= [ ];  % tacLV5
% mni{3}(7,1:3)= [ ];  % tacRV5
% mni{3}(8,1:3)= [ 26, -58, 43];  % tacRVIP
% 
% % SUB-004
mni{4}(1,1:3)= [-3.900000e+01, -6.520000e+01, 7.999997e+00];  % visLV5
mni{4}(2,1:3)= [5.460000e+01, -5.740000e+01, 1.999974e-01];  % visRV5
mni{4}(3,1:3)= [-3.120000e+01, -3.400000e+01, 7.299999e+01];  % tacLS1 
mni{4}(4,1:3)= [-3.120000e+01, -4.960000e+01, 6.520000e+01];  % tacLPC
mni{4}(5,1:3)= [3.120000e+01, -5.480000e+01, 5.740000e+01];  % tacRPC
mni{4}(6,1:3)= [-4.160000e+01, -5.740000e+01, 1.060000e+01];  % tacLV5
mni{4}(7,1:3)= [4.680000e+01, -4.960000e+01, 2.799997e+00];  % tacRV5 
mni{4}(8,1:3)= [-8, -56, 58];  % tacLSPL
mni{4}(9,1:3)= [ 26, -54, 42];  % tacRPPC
% 
% % SUB-005
mni{5}(1,1:3)= [-4.940000e+01, -6.260000e+01, 5.399997e+00];  % visLV5 
mni{5}(2,1:3)= [3.900000e+01, -5.740000e+01, 5.399997e+00];  % visRV5
mni{5}(3,1:3)= [3.380000e+01, -4.180000e+01, 7.039999e+01];  % tacLS1
mni{5}(4,1:3)= [-8, -56, 58 ];  % tacLPC%% ----
mni{5}(5,1:3)= [ 26, -54, 42 ];  % tacRPC%%  ----
mni{5}(6,1:3)= [-4.680000e+01, -6.520000e+01, 1.060000e+01];  % tacLV5
mni{5}(7,1:3)= [3.900000e+01, -5.740000e+01, 5.399997e+00];  % tacRV5 ---
mni{5}(8,1:3)= [-8, -56, 58];  % tacLSPL
mni{5}(9,1:3)= [ 26, -54, 42];  % tacRPPC
% 
% SUB-006 (visualised at p<0.05 for tactile)
mni{6}(1,1:3)= [-5.460000e+01, -4.700000e+01, 5.399997e+00];  % visLV5
mni{6}(2,1:3)= [4.420000e+01, -4.180000e+01, -2.400002e+00];  % visRV5
mni{6}(3,1:3)= [-3.120000e+01, -3.400000e+01, 5.740000e+01];  % tacLS1
mni{6}(4,1:3)= [-5.460000e+01, -4.440000e+01, 4.700000e+01];  % tacLPC 
mni{6}(5,1:3)= [2.600000e+01, -5.740000e+01, 5.220000e+01];  % tacRPC
mni{6}(6,1:3)= [-4.680000e+01, -3.400000e+01, -1.020000e+01];  % tacLV5 %%
mni{6}(7,1:3)= [4.160000e+01, -6.260000e+01, 5.399997e+00];  % tacRV5
mni{6}(8,1:3)= [-8, -56, 58];  % tacLSPL
mni{6}(9,1:3)= [ 26, -54, 42];  % tacRPPC

% SUB-007 
mni{7}(1,1:3)= [-4.160000e+01, -5.220000e+01, 7.999997e+00];  % visLV5
mni{7}(2,1:3)= [4.420000e+01, -6.000000e+01, 1.999974e-01];  % visRV5
mni{7}(3,1:3)= [-3.640000e+01, -2.620000e+01, 5.740000e+01];  % tacLS1
mni{7}(4,1:3)= [-3.640000e+01, -4.440000e+01, 5.480000e+01];  % tacLPC 
mni{7}(5,1:3)= [3.120000e+01, -4.440000e+01, 5.740000e+01];  % tacRPC
mni{7}(6,1:3)= [-5.200000e+01, -3.400000e+01, -2.400002e+00];  % tacLV5 %% 
mni{7}(7,1:3)= [4.420000e+01, -6.000000e+01, 1.999974e-01];  % tacRV5
mni{7}(8,1:3)= [-8, -56, 58];  % tacLSPL
mni{7}(9,1:3)= [ 26, -54, 42];  % tacRPPC



ROI_name_list = {'visLV5','visRV5','tacLS1','tacLPC','tacRPC', 'tacLV5','tacRV5','tacLSPL', 'tacRPPC'};

save('ROI_mni_coordinates.mat','ROI_name_list','mni')

%% MarsBar
% warning('off');
% addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% bspm fmri
% addpath(genpath('/Users/shahzad/Documents/MATLAB/bspmview'));


% add cpp repo
run ../visTacMotionDir_fMRI_analysis/src/../lib/CPP_SPM/initCppSpm.m;

% Radius of the sphere around the peak
radiusList = [6, 7, 8, 10, 12]; % mm

% Another manual step, apparently it does not work well code-wise
% In casewe want to give it a shot, run these:
% MARS.OPTIONS.spacebase.fname =  fullfile(pwd,'template.nii');
% MARS.OPTIONS.spacebase.fname =  t-contrast image

marsbar

%% Get the ROIs (actually just the spheres)
for iRadius=1:length(radiusList)
    radius=radiusList(iRadius);
    for iSub = 1:length(mni)

        % Get subject name, in our single ROI is the row with the coordinates
        subName = ['sub-00',num2str(iSub)];
        mkdir(subName)
%         subFolder= strcat('/Users/shahzad/Files/fMRI/visTacMotionDir/code/visTacMotionDir_ROIs_marsbar/',subName);

        % If there is actually something there
        if ~isnan(mni{iSub})

            for iReg = 1:size(mni{iSub},1) % for each region this subject has
                % Get the center
                ROI_center = mni{iSub}(iReg,:);

                switch iReg
                    case 1
                        modality='visual';
                        regHemi = 'L';
                        regName = 'V5';
                    case 2
                        modality='visual';
                        regHemi = 'R';
                        regName = 'V5';
                    case 3
                        modality='tactile';
                        regHemi = 'L';
                        regName = 'S1';
                    case 4
                        modality='tactile';
                        regHemi = 'L';
                        regName = 'PC';
                    case 5
                        modality='tactile';
                        regHemi = 'R';
                        regName = 'PC';
                    case 6
                        modality='tactile';
                        regHemi = 'L';
                        regName = 'V5';
                    case 7
                        modality='tactile';
                        regHemi = 'R';
                        regName = 'V5';
                    case 8
                        modality='tactile';
                        regHemi = 'L';
                        regName = 'SPL';
                    case 9
                        modality='tactile';
                        regHemi = 'R';
                        regName = 'PPC';
                end

                % Set up bids-like name
                % ROI_save_name = [subName,'_', regionName,'_',num2str(radius),'mm'];
                ROI_save_name = [subName,'_','hemi-',regHemi,'_','space-MNI','_','label-',regName,'_','desc-',modality,'_','radius-',num2str(radius),'mm','_mask'];

                % create the sphere with marsbar and save it
                params = struct('centre', ROI_center , 'radius', radius);
                roi = maroi_sphere(params);
                cd (convertCharsToStrings(subName))
                saveroi(roi, [ROI_save_name,'.mat']);
                mars_rois2img([ROI_save_name,'.mat'],[ROI_save_name,'.nii'])

                % Delete .mat files, not necessary
                delete([ROI_save_name,'_labels.mat']);
                delete([ROI_save_name,'.mat'])
                cd ..

            end
        end
    end
end

% end

%sub-01_space-individual_hemi-L_label-V1d_desc-wang_mask.nii

