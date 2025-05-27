% Original codes
clear;close all;

% Danny : start
% Open a UI window to select a directory
%% 
%% 
folder_name = uigetdir;
if folder_name == 0
    error('No folder selected, please select a valid folder.');
end
% Danny: end

% Danny : start
% List all TIFF files starting with 'segm_'
%% Files starting with 'segm_'
files_Segm = dir(fullfile(folder_name, 'segm_*.tif')); 

if isempty(files_Segm)
    error('No TIFF files with "segm_" prefix found in the selected directory.');
end
% Danny: end

% Danny: start
% Loop through each file in the directory
for idx = 1:length(files_Segm)
	% Read the image starting with 'segm_'
	segm_file_path = fullfile(files_Segm(idx).folder, files_Segm(idx).name);
    file_path = fullfile(files_Segm(idx).folder, files_Segm(idx).name);
    stacks = tiffRead(file_path, {'MONO'});
    s = stacks.MONO;
  
  	% Read another image matching with the prior 'segm_' prefixed tif image
    % Construct the corresponding non-prefixed file name by stripping 'segm_' prefix
    non_segm_file_name = strrep(files_Segm(idx).name, 'segm_', '');
    non_segm_file_path = fullfile(files_Segm(idx).folder, non_segm_file_name);
    stacks = tiffRead(non_segm_file_path, {'MONO'});
    image = stacks.MONO; %read image
    
    % Set filter length. 'filtersize' is the standard deviation corresponding to the main axis of the anisotropic Gaussian filter. Length is approximately 3*filtersize 
	filtersize=6; 
	% Set number of directions. 
	num_direction=10;
	[dirRatio, firstSomaParts, mask,s2]=Main_Anigauss_2d(s,filtersize,num_direction);

	figure; subplot(2,2,1); imshow(image,[]); axis off;title('Original image'); colormap('Gray'); freezeColors
	subplot(2,2,2); imshow(s2,[]);  axis off; title('Segmented image'); freezeColors;
	subplot(2,2,3); imshow(dirRatio,[]);  axis off; title('Directional Ratio'); colormap('jet'); freezeColors;
	subplot(2,2,4); imshow(mask,[]);  axis off; title('Extracted somas'); colormap('Gray'); 
	
	 %% Save the mask to a text file having the same name with the prior non_segm file but including mask_ as prefix
    mask_file_name = fullfile(folder_name, ['mask_', strrep(non_segm_file_name, '.tif', '.txt')]);
    writematrix(mask, mask_file_name);
end
% Danny: end

% Original codes
% file_path=pwd;
% fileName='segm_MAX_24h_CHIR99021_FGF14_488_PanNav_568_MAP2_647_10_blue.tif';
% stacks = tiffRead(fullfile(file_path,'data',fileName),{'MONO'});
% s = stacks.MONO; %read image
% fileName='MAX_24h_CHIR99021_FGF14_488_PanNav_568_MAP2_647_10_blue.tif';
% stacks = tiffRead(fullfile(file_path,'data',fileName),{'MONO'});
% image = stacks.MONO; %read image
%% Set filter length. 'filtersize' is the standard deviation corresponding to the main axis of the anisotropic Gaussian filter. Length is approximately 3*filtersize 
% filtersize=9; 
%% Set number of directions. 
% num_direction=10;
% [dirRatio, firstSomaParts, mask,s2]=Main_Anigauss_2d(s,filtersize,num_direction);

% figure; subplot(2,2,1);  imshow(image,[]); axis off;title('Original image'); colormap('Gray'); freezeColors
% subplot(2,2,2); imshow(s2,[]);  axis off; title('Segmented image'); freezeColors;
% subplot(2,2,3); imshow(dirRatio,[]);  axis off; title('Directional Ratio'); colormap('jet'); freezeColors;
% subplot(2,2,4); imshow(mask,[]);  axis off; title('Extracted somas'); colormap('Gray'); 

% CREATED: 
% - Date: 2016-07-13
% - By: Cihan Bilge Kayasandik and Demetrio Labate.
% 
