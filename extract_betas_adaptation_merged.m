%This script calculates rmANOVAS for the differences in signal change 
%between different conditions in experiment 2. 
%Conditions: 1) Repeated vs. non-repeated  2) emoji vs. text. vs. mixed)
%This is done seperatly for each participant and ROI.

clear all;
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');
 
%only call in the sessions of the participants that actually had this ROI 
%e.g. not all participants had mOTS-words on the right hemisphere
%lh AC
%    sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
%    '06_KT30_adaptation_031121'...
%    '07_GP21_adaptation_051221' '12_SCW23_adaptation_060321'...
%    '13_GN23_adaptation_062121' '16_ST22_adaptation_070821'...
%    '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}
% 
%  lh CC, PC, mOTS, pOTS  
%    sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
%    '05_IK30_adaptation_030421' '06_KT30_adaptation_031121'...
%    '07_GP21_adaptation_051221' '10_HL27_adaptation_051821'...
%    '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
%    '13_GN23_adaptation_062121' '14_MW28_adaptation_070821'...
%    '15_MM21_adaptation_071921' '16_ST22_adaptation_070821'...
%    '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}
  
%   rh AC
%    sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
%    '05_IK30_adaptation_030421' '06_KT30_adaptation_031121'...
%    '07_GP21_adaptation_051221' '10_HL27_adaptation_051821'...
%    '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
%    '13_GN23_adaptation_062121' '14_MW28_adaptation_070821'...
%    '15_MM21_adaptation_071921' '16_ST22_adaptation_070821'}
   
%   rh PC and pots
%    sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
%    '05_IK30_adaptation_030421' '06_KT30_adaptation_031121'...
%    '07_GP21_adaptation_051221' '10_HL27_adaptation_051821'...
%    '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
%    '13_GN23_adaptation_062121' '14_MW28_adaptation_070821'...
%    '15_MM21_adaptation_071921' '16_ST22_adaptation_070821'...
%    '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'} 

%   %rh mOTS 
%   sessions={'03_EK29_adaptation_030521' '05_IK30_adaptation_030421'... 
%   '06_KT30_adaptation_031121' '07_GP21_adaptation_051221' ...
%   '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
%   '15_MM21_adaptation_071921'...
%   '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}
% 

sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521' '05_IK30_adaptation_030421' '06_KT30_adaptation_031121'...
     '07_GP21_adaptation_051221' '10_HL27_adaptation_051821'...
    '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
     '13_GN23_adaptation_062121_backup' '14_MW28_adaptation_070821'...
     '15_MM21_adaptation_071921' '16_ST22_adaptation_070821'...
     '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}

rois={'lh_pOTS_fLOC3_words_vs_all'}';

    for s = 1:length(sessions)
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenInplane(5,1,rois);
        tc_plotScans(hi,1);
        tc_applyGlm;
        tc_dumpDataToWorkspace;
        d = fig1Data;
        betas(s,:) = d.glm.betas(1:8);
        sems(s,:) = d.glm.sems(1:8);
        close all;
    end
 
   %stacks betas and standard error
   %condition 5 & 7 and 6 & 8 are averages, as they are both mixed 
   %5 & 7 are mixed repeated trials, 6 & 8 mixed non-repeated trials
   betas_noCon=[betas(:,1)';betas(:,2)';betas(:,3)';betas(:,4)';mean([betas(:,5),betas(:,7)]');mean([betas(:,6),betas(:,8)]')]'
   sems_noCon=[sems(:,1)';sems(:,2)';sems(:,3)';sems(:,4)';mean([sems(:,5),sems(:,7)]');mean([sems(:,6),sems(:,8)]')]'
   
   bet=mean(betas_noCon);
   sem=mean(sems_noCon);
   
   %create plot
   xvalues=[bet(1:2) 0 bet(3:4) 0 bet(5:6)];
   xerror=[sem(1:2) 0 sem(3:4) 0 sem(5:6)];
   
   caption_x=[' Rep '; 'NoRep';'     ';' Rep '; 'NoRep';'     '; ' Rep '; 'NoRep'];
   caption_y='betas';
   fig=mybar(xvalues,xerror, caption_x,[],[17.3/100 62.7/100 17.3/100; 0.59 0.87 0.54;...
       0 0 0; 14/255 156/255 190/255; 71/255 211/255 235/255; 0 0 0; 84/255 84/255 84/255;...
       127/255 127/255 127/255;0 0 0;  1 0.4 0; 1 0.8 0],2);
   ylim([0 1.7]);
   yticks([0 0.5 1.0 1.5])
   ylabel('signal change [%]','FontSize',16,'FontName','Arial','FontWeight','bold');
   xlabel('  Text                 Emoji              Mixed','FontSize',16,'FontName','Arial','FontWeight','bold');
   pbaspect([1 1 1])
   set(gca,'FontSize',12,'FontWeight','bold'); box off; set(gca,'Linewidth',2);

%reconstruct betas to calculate ANOVA 
reshaped_betas=reshape(betas_noCon',6,length(sessions));
column_of_betas=reshaped_betas(:);

for s = 1:length(sessions)
    subjects(:,s)=repmat(s,6,1)
end
 
column_of_subjects=subjects(:);
stims=[1 1 2 2 3 3]'
column_of_stims=repmat(stims,s,1);
rep=[1 2 1 2 1 2]'
column_of_rep=repmat(rep,s,1);

input_for_rmANOVA=[column_of_betas, column_of_subjects, column_of_stims, column_of_rep];
factor_names={'stim' 'rep'};

%repeated measure ANOVA with stim and rep as factors
rm_anova2(column_of_betas, column_of_subjects, column_of_stims, column_of_rep,factor_names)
