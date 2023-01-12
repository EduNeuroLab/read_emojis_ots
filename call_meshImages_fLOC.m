
%This script retreives meshes of multiple sessions all in one image 
%with ROIs

function [montage] = call_meshImages_Morphing_Adding()

inputz.roi ={'lh_mOTS_fLOC3_words_vs_all' 'lh_pOTS_fLOC3_words_vs_all'};
%ROIs that should be displayed
inputz.ROI.color = [[0/255 126/255 7/255];[7/255 71/255 16/255];[62/255 0 179/255];[107/255 0 215/255];[162/255 48/255 237/255]];

inputz.imagefile ='lh_fLOC3.jpg';

inputz.map ='01_words_vs_all.mat';
inputz.pval= 3; 
inputz.scan = 1;
inputz.blockdir = '/biac2/kgs/projects/emoji/data';
inputz.L.ambient = [.5 .5 .4];
inputz.L.diffuse = [.3 .3 .3];
inputz.hemisphere='lh';
inputz.meshAngle='lh_VTC_zoomed'; %for all brains
inputz.meshname='lh_inflated_200_1.mat';
inputz.clip=1;

%all participants
inputz.sess={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
'17_JL21_emoji_072221' '18_HJ26_emoji_072921'}


inputz.nrows=4;
inputz.ncols=4;

montage = meshImages_PAR_formontage(inputz);
imageview(montage);


