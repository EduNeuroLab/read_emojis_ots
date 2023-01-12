
clear all;
ExpDir=fullfile('/oak/stanford/groups/kalanit/biac2/kgs/projects/emoji/data/');

%% sessions for emoji, comment out but do not delete
%sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
%'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
%'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'};

% % %% sessions for adaptation, comment out but do not delete
%   sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
%   '05_IK30_adaptation_030421' '06_KT30_adaptation_031121'...
%       '07_GP21_adaptation_051221' '10_HL27_adaptation_051821'...
%      '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
%       '13_GN23_adaptation_062121' '14_MW28_adaptation_070821'...
%       '15_MM21_adaptation_071921' '16_ST22_adaptation_070821'...
%       '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}
  
  
  sessions={ '13_GN23_adaptation_062121'}

rois={'rh_CC_fLOC3_color_vs_all'}';

    for s = 1:length(sessions)
        try
        cd(fullfile(ExpDir,sessions{s}));
        selected_roi=fullfile(ExpDir,sessions{s},'3DAnatomy/ROIs',rois)
        hi = initHiddenInplane(5);
        roiLoadVol2Inplane(hi,selected_roi{1},1)
        close all;
        catch 
        end
    end

