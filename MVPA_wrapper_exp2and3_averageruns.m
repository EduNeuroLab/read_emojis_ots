% RSA for experiment 2 and 3 
%We take runs from both exeriments for this analysis:  
%runs 1-6 = Exp 2 fMRI adaptation 
%runs 7-14 = exp3 task and stimulus preferences 

%We calculate an RSM for an ROI, contrasting MVPs of different stimuli (emoji
%vs. text) and task/paradigm (reading vs.color judgement vs Black/White judgement) 

%Each RDM is calculated for one subject at a time and later merged into an 
%mean RDM

% We have 22 Conditions in total:
% Exp 2 fMRI adaptation:
% 1: text repeated, 2: text nonrepeated, 3: emoji repeated, 4: emoji non-repeated
% 5-6 mixed repeated, 7-8 mixed nonrepeated
% Experiment 3 task and stimulus preferences
% 12-13: emoji reading, 14-15 text reading, 16-17 emoji color, 18-19 text color



clear all;
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');
OutDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','MVPA_results','exp2and3merged', 'averaged');
OutDirInd=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','MVPA_results','exp2and3merged', 'averaged');

rois={'rh_CC_fLOC3_color_vs_all_disk_75mm.mat'}; %choose ROI
conditions={'AdapTx'; 'AdapEm'; 'ReadTx'; 'ReadEm';'ColoTx' ; 'ColoEm'};

%important! Check if all subjects have the same number of runs. 
%In our case participant 1 only completed 4 out of 6 trials of exp 2
%Therefor this participant is processed seperatly and then merged with the
%others

%%%%%%%%%%%%%%%run till end so we get only the correlations for the first subject 

sessions={'01_hk_emoji_06521'};

numconds=length(conditions);

for r=1:length(rois)
    
    combinedcavgmatrix=nan(numconds,numconds,length(sessions));
    combinedcsymmatrix=nan(numconds,numconds,length(sessions));
    combinedcavgmatrix_subj1=nan(numconds,numconds,length(sessions));
    combinedcsymmatrix_subj1=nan(numconds,numconds,length(sessions));
   
    for s = 1:length(sessions)
        % Init Inplane
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenGray(4,1,rois);
        oddRuns = [1,3,7,9,11,13];
        evenRuns = [2, 4, 6, 8, 10, 12];
        runs=[oddRuns; evenRuns];
        cond_exp2 = 2;
        cond_exp3 = 4;
        iterations=[1,2];
        z_values_all=[];
        z_values_other_runs=[];
        
        for n=1:length(iterations)
            clear mean;
            % Init MVPA structures
            mv=mv_init(hi,hi.ROIs(r).name,runs(n,:),4,[]);
            % run GLMs
            mv = mv_applyGlm(mv);
            amps_all=mv_amps(mv);
            
            % amps without mixed condition, as we decided to also drop 
            %this condition from the MVPA for exp 2 fMRI adaptation
            amps = [amps_all(:,1), amps_all(:,2), amps_all(:,3), amps_all(:,4),...
                mean(amps_all(:,12:13)')',...
                mean(amps_all(:,16:17)')', mean(amps_all(:,14:15)')', mean(amps_all(:,18:19)')']

            amps_exp2 = [mean(amps_all(:,1:2)')', mean(amps_all(:,3:4)')' ]

            amps_exp3 = [mean(amps_all(:,14:15)')', mean(amps_all(:,12:13)')',...
                mean(amps_all(:,16:17)')', mean(amps_all(:,18:19)')']
        
            mean_exp2 = mean(amps_exp2, 2);
            mean_exp3 = mean(amps_exp3, 2);
            
            meanmat_exp2 = mean_exp2*ones(1,cond_exp2)
            meantmat_exp3 = mean_exp3*ones(1,cond_exp3)
            subbetas_exp2 = amps_exp2-meanmat_exp2
            subbetas_exp3 = amps_exp3-meantmat_exp3
            
            subbetas = cat(2,subbetas_exp2, subbetas_exp3)
           
            % do z-transform
            z_values=z_transform(subbetas,mv.glm.residual,mv.glm.dof,numconds);
            z_values_name=sprintf('z_values_%d',runs(n)');
            eval([z_values_name '=z_values;']);
            z_values_all(:,:,n)=z_values;
        end
        corr_all=run_corr(OutDirInd,sessions{s},rois{r},iterations,conditions,z_values_all)
        clear mean;
        corr=mean(corr_all,3);
        for i=1:numconds %symmetrical correlation
            for j=1:i
                csym(i,j)=.5*(corr(i,j)+corr(j,i));
                csym(j,i)=csym(i,j);
            end
        end
        
          cavg=zeros(numconds,numconds); % average correlation
        for i=1:numconds
            for j=1:numconds
                tmpc=corrcoef(z_values_1(:,i),z_values_2(:,j));
                cavg(i,j)=tmpc(1,2);
            end
        end
         corr_all_matrix(:,:,s) = corr;
        corr_all_filename= sprintf('exp2and3_corr_all_%s_z_split_half.mat',rois{r}');
        corr_all_file= fullfile(OutDir, corr_all_filename);
        save(corr_all_file, 'corr_all_matrix');
        
        %save the matrices with data from all the participants (separately for each ROI).
        combinedcavgmatrix(:,:,s) = cavg;
        cavgallfilename= sprintf('exp2and3_cavg_all_%s_z.mat',rois{r}');
        cavgallfile= fullfile(OutDir, cavgallfilename);
        save(cavgallfile, 'combinedcavgmatrix');
        
        combinedcsymmatrix(:,:,s) = csym;
        csymallfilename= sprintf('exp2and3_csym_all_%s_z_split_half.mat',rois{r}');
        csymallfile= fullfile(OutDir, csymallfilename);
        save(csymallfile, 'combinedcsymmatrix');
        clear hi      
    end

    clear mean;
    corr_mean=mean(corr_all_matrix,3);
    corr_mean_filename= sprintf('exp2and3_cavg_%s_z_split_half.mat',rois{r}');
    corr_mean_file= fullfile(OutDir, corr_mean_filename);
    save(corr_mean_file, 'corr_mean');
    
    clear mean;
    
    cavg_mean=mean(combinedcavgmatrix,3);
    cavgallfilename= sprintf('exp2and3_cavg_%s_z.mat',rois{r}');
    cavgallfile= fullfile(OutDir, cavgallfilename);
    save(cavgallfile, 'combinedcavgmatrix');
    
    csym_mean=mean(combinedcsymmatrix,3);
    csymallfilename= sprintf('exp2and3_csym_%s_z_split_half.mat',rois{r}');
    csymallfile= fullfile(OutDir, csymallfilename);
    save(csymallfile, 'combinedcsymmatrix');
    
    outfilename=sprintf('exp2and3_all_subjects_RSM_%s_z_split_half.png',rois{r}');
    plot_corr(cavg_mean, csym_mean, OutDir, outfilename, conditions, 'all_subjects_', rois{r}, 1);
  
    
end %%%%%%%%%%%run till here
   
%%save correlations of participant 1 so we can later add it to the other
%%participants
part1_cavg = cavg_mean
part1_csym = csym_mean
add_part1 = corr_mean
%%%run till here


%%%%other participants:
% 
%for lh mOTS, pots, CC and rh pots and CC
sessions={'02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
 '06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
 '11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
 '14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
 '17_JL21_emoji_072221' '18_HJ26_emoji_072921'}

% sessions for rh mots, run from here:
% sessions={'02_cc_emoji_031921' '05_IK30_emoji_040221' '03_EK29_emoji_031721'...
% '06_KT30_emoji_061621' '07_GP21_emoji_051921_v2'...
% '11_CS63_emoji_062821' '12_SCW23_emoji_063021'... 
% '14_MW28_emoji_070921' '15_MM21_emoji_072021'...
% '17_JL21_emoji_072221' '18_HJ26_emoji_072921'};
numconds=length(conditions);

for r=1:length(rois)
    
    combinedcavgmatrix=nan(numconds,numconds,length(sessions));
    combinedcsymmatrix=nan(numconds,numconds,length(sessions));

   
    for s = 1:length(sessions)
        % Init Inplane
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenGray(4,1,rois);
 runs = 1:14;
            oddRuns = runs(1:2:end);
            evenRuns = runs(2:2:end);
            runs=[oddRuns; evenRuns];
        cond_exp2 = 2;
        cond_exp3 = 4;
        iterations=[1,2];
        z_values_all=[];
        z_values_other_runs=[];
        
        for n=1:length(iterations)
            clear mean;
            % Init MVPA structures
            mv=mv_init(hi,hi.ROIs(r).name,runs(n,:),4,[]);
            % run GLMs
            mv = mv_applyGlm(mv);
            amps_all=mv_amps(mv);
            
            % amps without mixed condition 
            amps = [amps_all(:,1), amps_all(:,2), amps_all(:,3), amps_all(:,4),...
                mean(amps_all(:,12:13)')',...
                mean(amps_all(:,16:17)')', mean(amps_all(:,14:15)')', mean(amps_all(:,18:19)')']

            amps_exp2 = [mean(amps_all(:,1:2)')', mean(amps_all(:,3:4)')' ]

            amps_exp3 = [mean(amps_all(:,14:15)')', mean(amps_all(:,12:13)')',...
                mean(amps_all(:,18:19)')', mean(amps_all(:,16:17)')']
        
            mean_exp2 = mean(amps_exp2, 2);
            mean_exp3 = mean(amps_exp3, 2);
            
            meanmat_exp2 = mean_exp2*ones(1,cond_exp2)
            meantmat_exp3 = mean_exp3*ones(1,cond_exp3)
            subbetas_exp2 = amps_exp2-meanmat_exp2
            subbetas_exp3 = amps_exp3-meantmat_exp3
            
            subbetas = cat(2,subbetas_exp2, subbetas_exp3)
           
            % do z-transform
            z_values=z_transform(subbetas,mv.glm.residual,mv.glm.dof,numconds);
            z_values_name=sprintf('z_values_%d',runs(n)');
            eval([z_values_name '=z_values;']);
            z_values_all(:,:,n)=z_values;
        end
        corr_all=run_corr(OutDirInd,sessions{s},rois{r},iterations,conditions,z_values_all)
        clear mean;
        corr=mean(corr_all,3);
        for i=1:numconds %symmetrical correlation
            for j=1:i
                csym(i,j)=.5*(corr(i,j)+corr(j,i));
                csym(j,i)=csym(i,j);
            end
        end
        
          cavg=zeros(numconds,numconds); % average correlation
        for i=1:numconds
            for j=1:numconds
                tmpc=corrcoef(z_values_1(:,i),z_values_2(:,j));
                cavg(i,j)=tmpc(1,2);
            end
        end
         corr_all_matrix(:,:,s) = corr;
        corr_all_matrix(:,:,15) = add_part1

        corr_all_filename= sprintf('exp2and3_corr_all_%s_z_split_half.mat',rois{r}');
        corr_all_file= fullfile(OutDir, corr_all_filename);
        save(corr_all_file, 'corr_all_matrix');
        
        %save the matrices with data from all the participants (separately for each ROI).
        combinedcavgmatrix(:,:,s) = cavg;
        combinedcavgmatrix(:,:,15) = part1_cavg %comment out for rh mots
        cavgallfilename= sprintf('exp2and3_cavg_all_%s_z.mat',rois{r}');
        cavgallfile= fullfile(OutDir, cavgallfilename);
        save(cavgallfile, 'combinedcavgmatrix');
        
        combinedcsymmatrix(:,:,s) = csym;
        combinedcsymmatrix(:,:,15) = part1_csym %comment out for rh mots
        csymallfilename= sprintf('exp2and3_csym_all_%s_z_split_half.mat',rois{r}');
        csymallfile= fullfile(OutDir, csymallfilename);
        save(csymallfile, 'combinedcsymmatrix');
        clear hi      
    end

    clear mean;
    corr_mean=mean(corr_all_matrix,3);
    corr_mean_filename= sprintf('exp2and3_cavg_%s_z_split_half.mat',rois{r}');
    corr_mean_file= fullfile(OutDir, corr_mean_filename);
    save(corr_mean_file, 'corr_mean');
    
    clear mean;
    
    cavg_mean=mean(combinedcavgmatrix,3);
    cavgallfilename= sprintf('exp2and3_cavg_%s_z.mat',rois{r}');
    cavgallfile= fullfile(OutDir, cavgallfilename);
    save(cavgallfile, 'combinedcavgmatrix');
    
    csym_mean=mean(combinedcsymmatrix,3);
    csymallfilename= sprintf('exp2and3_csym_%s_z_split_half.mat',rois{r}');
    csymallfile= fullfile(OutDir, csymallfilename);
    save(csymallfile, 'combinedcsymmatrix');
    
    outfilename=sprintf('exp2and3_all_subjects_RSM_%s_z_split_half.png',rois{r}');
    plot_corr(cavg_mean, csym_mean, OutDir, outfilename, conditions, 'all_subjects_', rois{r}, 1);
  
    
    end

