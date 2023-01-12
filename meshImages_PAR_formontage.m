function [img_final] = meshImages_PAR_formontage(inputz)
% Produce images of response amplitudes (estimated one of a number of
% different ways) on a single-subject mesh, for new Localizer block
% data.
%
% ras, 03/2008.
% kgs 03/2008
% jv 2008/04 evolved into sub-function with related main
% vn 2014 - changed for the kids study.
% bj 2016 - montage for thickness study

%% this needs to be parameterized as some maps such as eccentricity bias we
%% want layer 1 and not all layers
setpref('mesh', 'layerMapMode', 'all');
setpref('mesh', 'overlayLayerMapMode', 'mean');

% go to the session directory
for i =1:size(inputz.sess,2)
     cd([inputz.blockdir,'/', inputz.sess{i}]);
     % initialize mesh with scan number
     hG=initHiddenGray('GLMs',inputz.scan);
     %hG=initHiddenGray('MotionComp_RefScan1',inputz.scan);
     
     %% load the ROI, get ready for the main loop
     for r=1:length(inputz.roi)
      [hG , ok] = loadROI(hG, inputz.roi(r), 0,inputz.ROI.color(r,:))
%       [hG , ok] = loadROI(hG, inputz.roi,0)
       if ok<1
%        [hG , ok]= loadROI(hG, 'dialog', [], inputz.ROI.color, 1, 1); 
       end
     end
       
       
      mapPath=fullfile(inputz.blockdir, inputz.sess{i}, 'Gray', 'GLMs', inputz.map);
%       if ~exist(mapPath,'file')
%       mapPath=fullfile(inputz.blockdir, inputz.sess{i}, 'Gray', 'MotionComp_RefScan1', inputz.map);
%       end 
 
     %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
     hG.ui = load('Gray/userPrefs.mat');
     hG.ui.dataTypeName= 'GLMs'; % in case ui preferences are different
%      hG.ui.dataTypeName= 'MotionComp_RefScan1'; 

     % Load and clip the parameter map
     hG= loadParameterMap(hG, mapPath);
     
     
%%%%% set color
     hG.ui.mapMode=setColormap(hG.ui.mapMode, 'autumnCmap'); % set color - use this for face or body selective
    % hG=bicolorCmap(hG); % set color use this for animate inanimate
%%%%%%%%     
     
     hG=refreshScreen(hG,1); 
     if inputz.clip==1;
        hG.ui.mapMode.clipMode = [3 12];
     end
        hG.ui.displayMode='map';
        %set map threshold, p=2
        hG=setMapWindow(hG, [inputz.pval Inf]);
        %% load up a mesh for the view
       % first, we set the hemisphere, by setting the cursor position's 3rd dim.
       if isequal(lower(inputz.hemisphere), 'rh')
            hG.loc = [100 100 1];
       else
            hG.loc = [100 100 200];
       end

    % go into anatomy folder
    cd('3DAnatomy')
    % load the mesh
    hG = meshLoad(hG, inputz.meshname, 1);
     % set the view settings
    [mesh1, settings]=meshRetrieveSettings(hG.mesh{1}, inputz.meshAngle);
     % % try re-computing the vertex map
     vertexGrayMap = mrmMapVerticesToGray(...
        meshGet(mesh1, 'initialvertices'),...
        viewGet(hG, 'nodes'),...
        viewGet(hG, 'mmPerVox'),...
        viewGet(hG, 'edges'));
       hG.mesh{1} = meshSet(hG.mesh{1}, 'vertexgraymap', vertexGrayMap);
       %hG.ui.roiDrawMethod = 'filled'; hG = refreshScreen(hG); 
       hG.ui.roiDrawMethod = 'filled'; 
       hG = refreshScreen(hG); 
    
% Set the mesh lighting to be the same across meshes     
      meshLighting(hG, hG.mesh{1}, inputz.L, 1);
      meshColorOverlay(hG);
      meshUpdateAll(hG);
      pause(1);
% grab the snapshot and crop it if it is a ventral view
        img_temp= mrmGet(hG.mesh{1}, 'screenshot' ) ./ 255;
        %image_crop=img_temp(0:499,:, :);
        %img{i}=image_crop;
        img{i}=img_temp;
        img_final=img_temp;
        hG = meshDelete(hG, Inf); %close all meshes
       plotNum = i;
       subplot(inputz.nrows,inputz.ncols,plotNum);
       imagesc(img{i});
       set(gca,'CameraViewAngle',get(gca,'CameraViewAngle')-.1);
       set(gcf,'color','w');
       axis image;
       axis off;
       title(inputz.sess{i},'interpreter','none');
       
end

% save
cd('/oak/stanford/groups/kalanit/biac2/kgs/projects/emoji');
saveas(gca,inputz.imagefile);

