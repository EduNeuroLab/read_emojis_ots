%This script performs repeated measure ANOVA for all chosen sessions 
%and ROIs on experiment 3 
%Factors:1) Task (reading vs. color judgement), 2) (Emoji vs. text)
clear all;
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');

%only call in the sessions of the participants that actually had this ROI 
%e.g. not all participants had mOTS-words on the right hemisphere

% lh AC, CC, mots and pOTS
% sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
% '06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
% '11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
% '14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
% '17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

%lh PC 
%sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
%'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
%'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
%'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
%'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

 %rh_AC
 %sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
 %'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
 %'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
 %'15_MM21_emoji_072021' '16_ST22_emoji_071221'...
 %'17_JL21_emoji_072221'};

 %rh CC
 %sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
 %'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
 %'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
 %'14_MW28_emoji_070921' '15_MM21_emoji_072021' '17_JL21_emoji_072221' '18_HJ26_emoji_072921'}
 
 %rh PC
%sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
 %'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
 %'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
 %'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
 %'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

% rh mOTS
%sessions={'03_EK29_emoji_031721' '05_IK30_emoji_040221'...
%'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2'...
%'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
%'15_MM21_emoji_072021' '17_JL21_emoji_072221' '18_HJ26_emoji_072921'};
 
%  %rh pots 
%sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
%'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
%'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
%'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
%'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

rois={'lh_pOTS_fLOC3_words_vs_all'}';

    for s = 1:length(sessions)
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenInplane(5,1,rois);
        tc_plotScans(hi,1);
        tc_applyGlm;
        tc_dumpDataToWorkspace;
        d = fig1Data;
        betas(s,:) = d.glm.betas(4:11);
        sems(s,:) = d.glm.sems(4:11);
        close all;
    end
    
    betas_noCon=[mean([betas(:,1),betas(:,2)]');mean([betas(:,3),betas(:,4)]');mean([betas(:,5),betas(:,6)]');mean([betas(:,7),betas(:,8)]')]'
    sems_noCon=[mean([sems(:,1),sems(:,2)]');mean([sems(:,3),sems(:,4)]');mean([sems(:,5),sems(:,6)]');mean([sems(:,7),sems(:,8)]')]'
    
    bet=mean(betas_noCon);
    sem=mean(sems_noCon);
    
    %create bar plot
    xvalues=[bet(1) bet(2) 0 bet(3) bet(4)];
    xerror=[sem(1) sem(2) 0 sem(3) sem(4)];
    caption_x=['Emj';'Txt';'   '; 'Emj'; 'Txt'];
    caption_y='betas';
    fig=mybar(xvalues, xerror, caption_x,[],[14/255 156/255 190/255;...
        17.3/100 62.7/100 17.3/100; 0 0 0; 71/255 211/255 235/255; 0.59 0.87 0.54],2);
    ylim([0 1.7]);
    ylabel('signal change [%]','FontSize',16,'FontName','Arial','FontWeight','bold');
    xlabel(' Read             Color','FontSize',16,'FontName','Arial','FontWeight','bold');
    pbaspect([2 1 1])
    set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);
     
% restructure betas for rmANOVA 
 reshaped_betas=reshape(betas_noCon',4,length(sessions))
 column_of_betas=reshaped_betas(:);
 
 for s = 1:length(sessions)
     subjects(:,s)=repmat(s,4,1)
 end
 
  column_of_subjects=subjects(:);
 
  task=[1 1 2 2]'
  column_of_tasks=repmat(task,s,1);
  
  stims=[1 2 1 2]'
  column_of_stims=repmat(stims,s,1);

 factor_names={'task' 'stim'};
 
 p=anovan(column_of_betas,{column_of_tasks, column_of_stims})
 pInter=anovan(column_of_betas,{column_of_tasks, column_of_stims},'model','interaction','varnames',factor_names)
rm_anova2(column_of_betas, column_of_subjects, column_of_tasks, column_of_stims, factor_names)
