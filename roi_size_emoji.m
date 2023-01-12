%This script calculates roi sizes of all chosen ROIs and participant
clear all;
ExpDir=fullfile('/oak/stanford/groups/kalanit/biac2/kgs/projects/emoji/data/');

 sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};  

rois={'lh_pOTS_fLOC3_words_vs_all'}

for s = 1:length(sessions)
    for r=1:length(rois)
    cd(fullfile(ExpDir,sessions{s}));
    hi = initHiddenInplane(4,1,rois{r});
    if isempty(hi.ROIs)
    roisize(s,r)=nan;
    else
    mv_plotScans(hi,1);
    tc_dumpDataToWorkspace;
    roisize(s,r)=size(fig1Data.coords,2);
    end
    close all;
    clear hi;
    end
end

for i=1:length(rois)
roisize(s+1,i)=nanmean(roisize(1:s,i))
roisize(s+2,i)=nanstd(roisize(1:s,i))
roisize(s+3,i)=nnz(~isnan(roisize(1:s,i)))
roisize(s+4,i)=sqrt(roisize(s+3,i))
roisize(s+5,i)=(roisize(s+2,i)/roisize(s+4,i))
end

 ind=nnz(~isnan(roisize(1:s,1)))


