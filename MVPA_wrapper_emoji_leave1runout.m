%RSA for experiment 3  task and stimulus preferences 
%calculates RSM for an ROI, contrasting MVPs of different stimuli (emoji
%vs. text) and task (reading vs.color judgement) 

%Each RDM is calculated for one subject at a time and later merged into an 
%mean RDM

%After calculating the RDM we will run WTA-classifiers decoding task
%and stimulus 
%Here again, WTA-classifier performances will be calculated for each
%subject and then averaged across all subjects 

%Finally, we test WTA-classifier performance against chance compare the
%performance for stimulus and task to one another


clear all;
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');
OutDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','MVPA_results','leave_one_run_out');
OutDirInd=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','MVPA_results','leave_one_run_out');

%for all fROIs except for rh mOTS 
sessions={'01_hk_emoji_06521' '02_cc_emoji_031921' '05_IK30_emoji_040221' '03_EK29_emoji_031721'...
'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

% rh mOTS 
% sessions={'02_cc_emoji_031921' '05_IK30_emoji_040221' '03_EK29_emoji_031721'...
% '06_KT30_emoji_061621' '07_GP21_emoji_051921_v2'...
% '11_CS63_emoji_062821' '12_SCW23_emoji_063021'... 
% '14_MW28_emoji_070921' '15_MM21_emoji_072021'...
% '17_JL21_emoji_072221' '18_HJ26_emoji_072921'};
%  
rois={'lh_pOTS_fLOC3_words_vs_all_disk_75mm'}; %choose your ROI
conditions={'ReadTx','ReadEm','ColoTx','ColoEm'};
numconds=length(conditions);
for r=1:length(rois)
    
combinedcavgmatrix=nan(numconds,numconds,length(sessions));
combinedcsymmatrix=nan(numconds,numconds,length(sessions)); 

    for s = 1:length(sessions)
        % Init Inplane
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenInplane(4,1,rois);
        runs=1:length(mrSESSION.functionals);
        z_values_all=[];
        z_values_other_runs=[];
  
        for n=1:length(runs)
        clear mean; 
        % Init MVPA structures
        mv=mv_init(hi,hi.ROIs(r).name,runs(n),4,[]);
         
        % run GLMs
        mv = mv_applyGlm(mv);
        % get betas for each run and voxel
        amps_all=mv_amps(mv);
        amps=amps_all(:,4:11);
        amps=[mean(amps(:,3:4)')', mean(amps(:,1:2)')',mean(amps(:,7:8)')',mean(amps(:,5:6)')']
      % subtract means  from each voxel
        mean=mean(amps,2);
        meanmat=mean*ones(1,numconds);
        subbetas=amps-meanmat;
       % do z-transform
        z_values=z_transform(subbetas,mv.glm.residual,mv.glm.dof,numconds);
        z_values_name=sprintf('z_values_%d',runs(n)');
        eval([z_values_name '=z_values;']);
        z_values_all(:,:,n)=z_values; 
        end 
   
        % create crosscorrelation matrixes among MVPs for each subject and
        % save a figure
        corr_all=one_run_out_corr_all(OutDirInd,sessions{s},rois{r},runs,conditions,z_values_all)  
        
        clear mean;
        corr=mean(corr_all,3);
        for i=1:numconds %symmetrical correlation
            for j=1:i
                csym(i,j)=.5*(corr(i,j)+corr(j,i));
                csym(j,i)=csym(i,j);
            end
        end
  
       
        % run WTA classfier and save %correct for each subject
        WTA_correctC_emoji=run_WTA_classifier_correctC_emoji(runs,numconds,corr_all);
        WTA_correctSO_task_emoji=run_WTA_classifier_emoji_task(runs,numconds,corr_all);
        WTA_correctSO_stim_emoji=run_WTA_classifier_correctSO_stim_emoji(runs,numconds,corr_all);             
        
        % run WTA classifier and save confusion matrix for each subject
        WTA_conf_emoji=run_WTA_classifier_conf_emoji(runs,numconds,corr_all);

        %save the matrices with data from all the participants (separately for each ROI).
        corr_all_matrix(:,:,s) = corr;
        corr_all_filename= sprintf('emoji_corr_all_%s_z_1rout.mat',rois{r}');
        corr_all_file= fullfile(OutDir, corr_all_filename);
        save(corr_all_file, 'corr_all_matrix');
  
        combinedcsymmatrix(:,:,s) = csym;
        csymallfilename= sprintf('emoji_csym_all_%s_z_1rout.mat',rois{r}');
        csymallfile= fullfile(OutDir, csymallfilename);
        save(csymallfile, 'combinedcsymmatrix');
        
        combinedWTA_correctC_emoji(:,s) = WTA_correctC_emoji;
        WTA_correctCfilename= sprintf('emoji_WTA_correctC_%s_z_1rout.mat',rois{r}');
        WTA_correctCfile= fullfile(OutDir, WTA_correctCfilename);
        save(WTA_correctCfile, 'combinedWTA_correctC_emoji');
                           
        combinedWTA_SO_task_emoji(:,s) = WTA_correctSO_task_emoji;
        WTA_correctSO_task_filename= sprintf('emoji_WTA_correctSO_task_%s_z_1rout.mat',rois{r}');
        WTA_correctSO_task_file= fullfile(OutDir, WTA_correctSO_task_filename);
        save(WTA_correctSO_task_file, 'combinedWTA_SO_task_emoji');

        combinedWTA_SO_stim_emoji(:,s) = WTA_correctSO_stim_emoji;
        WTA_correctSO_stim_filename= sprintf('emoji_WTA_correctSO_stim_%s_z_1rout.mat',rois{r}');
        WTA_correctSO_stim_file= fullfile(OutDir, WTA_correctSO_stim_filename);
        save(WTA_correctSO_stim_file, 'combinedWTA_SO_stim_emoji');
        
        combinedWTA_conf_emoji(:,:,s) = WTA_conf_emoji;
        WTA_conffilename= sprintf('emoji_WTA_conf_%s_z_1rout.mat',rois{r}');
        WTA_conffile= fullfile(OutDir, WTA_conffilename);
        save(WTA_conffile, 'combinedWTA_conf_emoji');
        clear hi;
    end
    
%           % average the data across participants and make some nice figures
    clear mean;
    corr_mean=mean(corr_all_matrix,3);
    corr_mean_filename= sprintf('emoji_mean_cavg_%s_z_1rout.mat',rois{r}');
    corr_mean_file= fullfile(OutDir, corr_mean_filename);
    save(corr_mean_file, 'corr_mean');
     
    clear mean;
    csym_mean=mean(combinedcsymmatrix,3);
    csymallfilename= sprintf('emoji_mean_csym_%s_z_1rout.mat',rois{r}');
    csymallfile= fullfile(OutDir, csymallfilename);
    save(csymallfile, 'combinedcsymmatrix');
    
    outfilename=sprintf('emoji_mean_all_subjects_RSM_%s_z_1rout.png',rois{r}');
    plot_corr(corr_mean, csym_mean, OutDir, outfilename, conditions, 'all_subjects_', rois{r}, 1);
    
     clear mean;
    WTA_correctC_mean=mean(combinedWTA_correctC_emoji,2);
    WTA_correctC_ste=std(combinedWTA_correctC_emoji')/sqrt(length(combinedWTA_correctC_emoji'));
    WTA_correctC_filename= sprintf('emoji_mean_WTA_correctC_%s_z_1rout.mat',rois{r}');
    WTA_correctC_file= fullfile(OutDir, WTA_correctC_filename);
    save(WTA_correctC_file, 'WTA_correctC_mean');
    
    clear mean;
    WTA_SO_task_mean=mean(combinedWTA_SO_task_emoji,2);
    WTA_SO_task_ste=std(combinedWTA_SO_task_emoji')/sqrt(length(combinedWTA_SO_task_emoji'));
    WTA_SO_task_filename= sprintf('emoji_mean_WTA_SO_task_%s_z_1rout.mat',rois{r}');
    WTA_SO_task_file= fullfile(OutDir, WTA_SO_task_filename);
    save(WTA_SO_task_file, 'WTA_SO_task_mean');
    
    clear mean;
    WTA_SO_stim_mean=mean(combinedWTA_SO_stim_emoji,2);
    WTA_SO_stim_ste=std(combinedWTA_SO_stim_emoji')/sqrt(length(combinedWTA_SO_stim_emoji'));
    WTA_SO_stim_filename= sprintf('mean_mean_WTA_SO_stim_%s_z_1rout.mat',rois{r}');
    WTA_SO_stim_file= fullfile(OutDir, WTA_SO_stim_filename);
    save(WTA_SO_stim_file, 'WTA_SO_stim_mean');

    clear mean;
    WTA_conf_mean=mean(combinedWTA_conf_emoji,3);
    WTA_conf_filename= sprintf('emoji_mean_WTA_conf_%s_z_1rout.mat',rois{r}');
    WTA_conf_file= fullfile(OutDir, WTA_conf_filename);
    save(WTA_conf_file, 'WTA_conf_mean');
   
 
    
    figure('Visible','on','color', [ 1 1 1], 'name',[rois{r}],'units','norm', 'position', [ 0.1 .2 .6 .4]);
    subplot(1,2,1); mybar(WTA_correctC_mean',WTA_correctC_ste,conditions,[],[50/255, 166/255, 46/255; 154/255, 217/255, 137/255; 148/255, 105/255, 191/255;198/255, 180/255, 217/255  ]);
    subplot(1,2,2); imagesc(WTA_conf_mean, [0 .6]); axis('image'); cmap=mrvColorMaps('hot'); colormap(cmap); colorbar; title('WTA_conf')
    set(gca,'Xtick', [1:1:numconds], 'XtickLabel',conditions)
    set(gca,'Ytick', [1:1:numconds], 'YtickLabel',conditions)
    % save figures.
    outfilename=sprintf('emoji_all_subjects_WTA_%s_z_1rout.png',rois{r}');
    outfile=fullfile(OutDir, outfilename);
    saveas(gcf, outfile, 'fig')
    
    outfile=fullfile(OutDir, outfilename);
    saveas(gcf, outfile, 'png');
    
 
    figure('Visible','on','color', [ 1 1 1], 'name',[rois{r}],'units','norm', 'position', [ 0.1 .1 .6 .4]);
    subplot(1,2,1); mybar(WTA_SO_task_mean',WTA_SO_task_ste,[{'Read', 'Color'}],[],[50/255, 166/255, 46/255; 148/255, 105/255, 191/255]);
    ylim([0 1]);
    subplot(1,2,2); mybar(WTA_SO_stim_mean',WTA_SO_stim_ste,[{'Text'; 'Emoji'}],[],[50/255, 166/255, 46/255; 15/255, 174/255, 191/255]);
    ylim([0 1]);
    % save figures.
    outfilename=sprintf('emoji_all_subjects_WTA_SO_%s_z_1rout.png',rois{r}');
    outfile=fullfile(OutDir, outfilename);
    saveas(gcf, outfile, 'fig')
    
    outfile=fullfile(OutDir, outfilename);
    saveas(gcf, outfile, 'png');
end  

%test classifier accuracies against chance 

%test classifier performance against chance 
%task: 
task_reading = combinedWTA_SO_task_emoji(1,:)
task_color = combinedWTA_SO_task_emoji(2,:)
[h_read,p_read] = ttest(task_reading,0.5,'Tail','right')
[h_color,p_color] = ttest(task_color,0.5,'Tail','right')

%stimuli 
stim_emoji = combinedWTA_SO_stim_emoji(1,:)
stim_text = combinedWTA_SO_stim_emoji(2,:)
[h_emoji, p_emoji] = ttest(stim_emoji, 0.5,'Tail','right')
[h_text, p_text] = ttest(stim_text, 0.5,'Tail','right')


%test classifier performances against  each other 
mean_wta_task = mean(combinedWTA_SO_task_emoji)
mean_wta_stim = mean(combinedWTA_SO_stim_emoji)
[h_wta, p_wta] = ttest(mean_wta_task, mean_wta_stim)
