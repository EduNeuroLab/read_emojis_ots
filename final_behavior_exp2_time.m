%This script performs the behavioral analysis for experiment 2 
%hit rates and reaction times are calculates across all conditions

%condition codes 1 = TR, 2 = TNR, 3 = ER, 4 = ENR, 5 = MTR, 6 = MTNR, 7 = MER, and 8 = MENR
 clear all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');


%first participant only has four runs !! 
sessions={'01_hk_adaptation_121620' '02_cc_adaptation_021821' '03_EK29_adaptation_030521'...
  '05_IK30_adaptation_030421' '06_KT30_adaptation_031121' '07_GP21_adaptation_051221'...
  '10_HL27_adaptation_051821' '11_CS63_adaptation_051821' '12_SCW23_adaptation_060321'...
  '13_GN23_adaptation_062121' '14_MW28_adaptation_070821' '15_MM21_adaptation_071921'...
  '16_ST22_adaptation_070821' '17_JL21_adaptation_072021' '18_HJ26_adapatation_073021'}
    
summary = zeros(15,6);
summary_hits = zeros(15,8)


for s = 2:length(sessions) %iterate over all subjects
    myFolder = (fullfile(ExpDir,sessions{s},'Stimuli','parfiles')); %find correct folder
    filePattern = fullfile(myFolder, '*.mat');
    matFiles = dir(filePattern);
    

%get all runs of the subject
 for k = 1:length(matFiles);
    baseFileName = matFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    matData(k) = load(fullFileName);  %mataData(2) for example means load run 2 of the subjec
 end 
  
 run1 = matData(1);
time1 = run1.theData.rt; %where the reaction time are stored
type1 = run1.theSubject.trials.cond;%where the condition is stored 
type1( :, ~any(type1,1) ) = [];
type1(2:2:end) = [];
hit1 = run1.theData.resp;
compare1 = cat(1, time1, type1);
indices_1 = find(compare1(1,:)==0);
compare1(:, indices_1) = [];
compare1 = compare1';
compare1_hit = cat(1, hit1, type1);
indices1_hit = find(compare1_hit(1,:)==0);
compare1_hit(:, indices1_hit) = [];
compare1_hit = compare1_hit';
compare1_hit(:,1) = [];

 run2 = matData(2);
time2 = run2.theData.rt; %where the reaction time are stored
type2 = run2.theSubject.trials.cond;%where the condition is stored 
type2( :, ~any(type2,1) ) = [];
type2(2:2:end) = [];
hit2 = run2.theData.resp
compare2 = cat(1, time2, type2);
indices_2 = find(compare2(1,:)==0);
compare2(:, indices_2) = [];
compare2 = compare2';
compare2_hit = cat(1, hit2, type2);
indices2_hit = find(compare2_hit(1,:)==0);
compare2_hit(:, indices2_hit) = [];
compare2_hit = compare2_hit';
compare2_hit(:,1) = [];

 run3 = matData(3);
time3 = run3.theData.rt; %where the reaction time are stored
type3 = run3.theSubject.trials.cond;%where the condition is stored (in this cas 1-8)
type3( :, ~any(type3,1) ) = [];
type3(2:2:end) = [];
hit3 = run3.theData.resp
compare3 = cat(1, time3, type3);
indices_3 = find(compare3(1,:)==0);
compare3(:, indices_3) = [];
compare3 = compare3';
compare3_hit = cat(1, hit3, type3);
indices3_hit = find(compare3_hit(1,:)==0);
compare3_hit(:, indices3_hit) = [];
compare3_hit = compare3_hit';
compare3_hit(:,1) = [];

 run4 = matData(4);
time4 = run4.theData.rt; %where the reaction time are stored
type4 = run4.theSubject.trials.cond;%where the condition is stored
type4( :, ~any(type4,1) ) = [];
type4(2:2:end) = [];
hit4 = run4.theData.resp
compare4 = cat(1, time4, type4);
indices_4 = find(compare4(1,:)==0);
compare4(:, indices_4) = [];
compare4 = compare4';
compare4_hit = cat(1, hit4, type4);
indices4_hit = find(compare4_hit(1,:)==0);
compare4_hit(:, indices4_hit) = [];
compare4_hit = compare4_hit';
compare4_hit(:,1) = [];

 run5 = matData(5);
time5 = run5.theData.rt; %where the reaction time are stored
type5 = run5.theSubject.trials.cond;%where the condition is stored
type5( :, ~any(type5,1) ) = [];
type5(2:2:end) = [];
hit5 = run5.theData.resp;
compare5 = cat(1, time5, type5);
indices_5 = find(compare5(1,:)==0);
compare5(:, indices_5) = [];
compare5 = compare5';
compare5_hit = cat(1, hit5, type5);
indices5_hit = find(compare5_hit(1,:)==0);
compare5_hit(:, indices5_hit) = [];
compare5_hit = compare5_hit';
compare5_hit(:,1) = [];

 run6 = matData(6);
time6 = run6.theData.rt; %where the reaction time are stored
type6 = run6.theSubject.trials.cond;%where the condition is stored
type6( :, ~any(type6,1) ) = [];
type6(2:2:end) = [];
hit6 = run6.theData.resp;
compare6 = cat(1, time6, type6);
indices_6 = find(compare6(1,:)==0);
compare6(:, indices_6) = [];
compare6 = compare6';
compare6_hit = cat(1, hit6, type6);
indices6_hit = find(compare6_hit(1,:)==0);
compare6_hit(:, indices6_hit) = [];
compare6_hit = compare6_hit';
compare6_hit(:,1) = [];

all_onesubject = cat(1, compare1, compare2, compare3, compare4, compare5, compare6);
all_hits = cat(1, compare1_hit, compare2_hit, compare3_hit, compare4_hit, compare5_hit, compare6_hit);
all_hits = nonzeros(all_hits);

%%counting hits per condition 
edges = unique(all_hits)
counts = histc(all_hits(:), edges)
edges = edges';
counts = counts';
summary_hit = cat (1, edges, counts)
hits_only = summary_hit(2,:);
summary_hits(s,:) = hits_only;

%%mean reaction time
only_1 = all_onesubject(any(all_onesubject==1, 2), :);
indices_1 = find(only_1(:,2)==0);
only_1(indices_1,:) = [];
mean_1 = mean(only_1);
mean_1 =mean_1(1,1);


only_2 = all_onesubject(any(all_onesubject==2, 2), :);
indices_2 = find(only_2(:,2)==0);
only_2(indices_2,:) = [];
mean_2 = mean(only_2);
mean_2 =mean_2(1,1);


only_3 = all_onesubject(any(all_onesubject==3, 2), :);
indices_3 = find(only_3(:,2)==0);
only_3(indices_3,:) = [];
mean_3 = mean(only_3);
mean_3 =mean_3(1,1);

only_4 = all_onesubject(any(all_onesubject==4, 2), :);
indices_4 = find(only_4(:,2)==0);
only_4(indices_4,:) = [];
mean_4 = mean(only_4);
mean_4 =mean_4(1,1);

only_5 = all_onesubject(any(all_onesubject==5, 2), :);
indices_5 = find(only_5(:,2)==0);
only_5(indices_1,:) = [];
mean_5 = mean(only_5);
mean_5 =mean_5(1,1);

only_6 = all_onesubject(any(all_onesubject==6, 2), :);
indices_6 = find(only_6(:,2)==0);
only_6(indices_6,:) = [];
mean_6 = mean(only_6);
mean_6 =mean_6(1,1);

only_7 = all_onesubject(any(all_onesubject==7, 2), :);
indices_7 = find(only_7(:,2)==0);
only_7(indices_7,:) = [];
mean_7 = mean(only_7);
mean_7 =mean_7(1,1);

only_8 = all_onesubject(any(all_onesubject==8, 2), :);
indices_8 = find(only_8(:,2)==0);
only_8(indices_8,:) = [];
mean_8 = mean(only_8);
mean_8 =mean_8(1,1);


one_sub = cat(1, mean_1, mean_2, mean_3, mean_4, mean([mean_5, mean_7]), mean([mean_6, mean_8]));
one_sub_tran = transpose(one_sub);
summary(s, :) = one_sub_tran;
hits_only = summary_hit(2,:);
summary_hits(s,:) = hits_only;
end 

%%%add participant 1 because they had only 4 runs%%

    
for s = 1 %iterate over all subjects
    myFolder = (fullfile(ExpDir,sessions{s},'Stimuli','parfiles')); %find correct folder
    filePattern = fullfile(myFolder, '*.mat');
    matFiles = dir(filePattern);
    

%get all runs of the subject
 for k = 1:length(matFiles);
    baseFileName = matFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    matData(k) = load(fullFileName);  %mataData(2) for example means load run 2 of the subjec
 end 
  
 run1 = matData(1);
time1 = run1.theData.rt; %where the reaction time are stored
type1 = run1.theSubject.trials.cond;%where the condition is stored 
type1( :, ~any(type1,1) ) = [];
type1(2:2:end) = [];
hit1 = run1.theData.resp;
compare1 = cat(1, time1, type1);
indices_1 = find(compare1(1,:)==0);
compare1(:, indices_1) = [];
compare1 = compare1';
compare1_hit = cat(1, hit1, type1);
indices1_hit = find(compare1_hit(1,:)==0);
compare1_hit(:, indices1_hit) = [];
compare1_hit = compare1_hit';
compare1_hit(:,1) = [];

 run2 = matData(2);
time2 = run2.theData.rt; %where the reaction time are stored
type2 = run2.theSubject.trials.cond;%where the condition is stored 
type2( :, ~any(type2,1) ) = [];
type2(2:2:end) = [];
hit2 = run2.theData.resp
compare2 = cat(1, time2, type2);
indices_2 = find(compare2(1,:)==0);
compare2(:, indices_2) = [];
compare2 = compare2';
compare2_hit = cat(1, hit2, type2);
indices2_hit = find(compare2_hit(1,:)==0);
compare2_hit(:, indices2_hit) = [];
compare2_hit = compare2_hit';
compare2_hit(:,1) = [];

 run3 = matData(3);
time3 = run3.theData.rt; %where the reaction time are stored
type3 = run3.theSubject.trials.cond;%where the condition is stored (in this cas 1-8)
type3( :, ~any(type3,1) ) = [];
type3(2:2:end) = [];
hit3 = run3.theData.resp
compare3 = cat(1, time3, type3);
indices_3 = find(compare3(1,:)==0);
compare3(:, indices_3) = [];
compare3 = compare3';
compare3_hit = cat(1, hit3, type3);
indices3_hit = find(compare3_hit(1,:)==0);
compare3_hit(:, indices3_hit) = [];
compare3_hit = compare3_hit';
compare3_hit(:,1) = [];

 run4 = matData(4);
time4 = run4.theData.rt; %where the reaction time are stored
type4 = run4.theSubject.trials.cond;%where the condition is stored
type4( :, ~any(type4,1) ) = [];
type4(2:2:end) = [];
hit4 = run4.theData.resp
compare4 = cat(1, time4, type4);
indices_4 = find(compare4(1,:)==0);
compare4(:, indices_4) = [];
compare4 = compare4';
compare4_hit = cat(1, hit4, type4);
indices4_hit = find(compare4_hit(1,:)==0);
compare4_hit(:, indices4_hit) = [];
compare4_hit = compare4_hit';
compare4_hit(:,1) = [];

all_onesubject = cat(1, compare1, compare2, compare3, compare4);
all_hits = cat(1, compare1_hit, compare2_hit, compare3_hit, compare4_hit, compare5_hit, compare6_hit);
all_hits = nonzeros(all_hits);

%%counting hits per condition 
edges = unique(all_hits)
counts = histc(all_hits(:), edges)
edges = edges';
counts = counts';
summary_hit = cat (1, edges, counts)
hits_only = summary_hit(2,:);
summary_hits(s,:) = hits_only;
only_1 = all_onesubject(any(all_onesubject==1, 2), :);
indices_1 = find(only_1(:,2)==0);
only_1(indices_1,:) = [];
mean_1 = mean(only_1);
mean_1 =mean_1(1,2);

%mean reaction times
only_2 = all_onesubject(any(all_onesubject==2, 2), :);
indices_2 = find(only_2(:,2)==0);
only_2(indices_2,:) = [];
mean_2 = mean(only_2);
mean_2 =mean_2(1,1);

only_3 = all_onesubject(any(all_onesubject==3, 2), :);
indices_3 = find(only_3(:,2)==0);
only_3(indices_3,:) = [];
mean_3 = mean(only_3);
mean_3 =mean_3(1,1);

only_4 = all_onesubject(any(all_onesubject==4, 2), :);
indices_4 = find(only_4(:,2)==0);
only_4(indices_4,:) = [];
mean_4 = mean(only_4);
mean_4 =mean_4(1,1);

only_5 = all_onesubject(any(all_onesubject==5, 2), :);
indices_5 = find(only_5(:,2)==0);
only_5(indices_1,:) = [];
mean_5 = mean(only_5);
mean_5 =mean_5(1,1);

only_6 = all_onesubject(any(all_onesubject==6, 2), :);
indices_6 = find(only_6(:,2)==0);
only_6(indices_6,:) = [];
mean_6 = mean(only_6);
mean_6 =mean_6(1,1);

only_7 = all_onesubject(any(all_onesubject==7, 2), :);
indices_7 = find(only_7(:,2)==0);
only_7(indices_7,:) = [];
mean_7 = mean(only_7);
mean_7 =mean_7(1,1);

only_8 = all_onesubject(any(all_onesubject==8, 2), :);
indices_8 = find(only_8(:,2)==0);
only_8(indices_8,:) = [];
mean_8 = mean(only_8);
mean_8 =mean_8(1,1);

one_sub = cat(1, mean_1, mean_2, mean_3, mean_4, mean([mean_5, mean_7]), mean([mean_6, mean_8]));
one_sub_tran = transpose(one_sub);
summary(1, :) = one_sub_tran;
hits_only = summary_hit(2,:);
summary_hits(1,:) = hits_only;
end 

%%% reaction time mean and visualization

%select each condition
text_rep = summary(:,1);
 text_norep= summary(:,2);
emojis_rep = summary(:,3);
emojis_norep= summary(:,4);
mix_rep = summary(:,5);
mix_norep = summary(:,6);

%standard error for each condition
ste_text_rep = std(text_rep) / sqrt(length(text_rep));
ste_text_norep = std(text_norep) / sqrt(length(text_norep));
ste_emojis_rep = std(emojis_rep) / sqrt(length(emojis_rep));
ste_emojis_norep = std(emojis_norep) / sqrt(length(emojis_norep));
ste_mix_rep = std(mix_rep) / sqrt(length(mix_rep));
ste_mix_norep = std(mix_norep) / sqrt(length(mix_norep));

%means for each condition
all_means = mean(summary) 
mean_text_rep = all_means(1,1)
mean_text_norep = all_means(1,2)
mean_emoji_rep = all_means(1,3) 
mean_emoji_norep = all_means(1,4)
mean_mix_rep = all_means(1,5)
mean_mix_norep = all_means(1,6)

%plot
xvalues=[mean_text_rep mean_text_norep mean_emoji_rep mean_emoji_norep mean_mix_rep mean_mix_norep];
xerror=[ste_text_rep ste_text_norep ste_emojis_rep ste_emojis_norep ste_mix_rep ste_mix_norep];
caption_x=['txtR';'txtN';'emjR';'emjN';'mixR';'mixN'];
caption_y='time';

figure(1)
fig=mybar(xvalues, xerror, caption_x,[],2);
%ylim([0 0.8]);
ylabel('reaction time in sec','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('                     ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);

%%%hits  visualization 

text_rep_hits = (summary_hits(:,1)/28);
 text_norep_hits= (summary_hits(:,2)/28);
emojis_rep_hits = (summary_hits(:,3)/28);
emojis_norep_hits= (summary_hits(:,4)/28);
mix_rep_hits = (summary_hits(:,5)/28);
mix_norep_hits = (summary_hits(:,6)/28);

%standard error for each condition
ste_text_rep_hits = std(text_rep_hits) / sqrt(length(text_rep_hits));
ste_text_norep_hits = std(text_norep_hits) / sqrt(length(text_norep_hits));
ste_emojis_rep_hits = std(emojis_rep_hits) / sqrt(length(emojis_rep_hits));
ste_emojis_norep_hits = std(emojis_norep_hits) / sqrt(length(emojis_norep_hits));
ste_mix_rep_hits = std(mix_rep_hits) / sqrt(length(mix_rep_hits));
ste_mix_norep_hits = std(mix_norep_hits) / sqrt(length(mix_norep_hits));

%means for each condition
all_means_hits = (mean(summary_hits)/28) ;
mean_text_rep_hits = all_means_hits(1,1);
mean_text_norep_hits = all_means_hits(1,2);
mean_emoji_rep_hits = all_means_hits(1,3) ;
mean_emoji_norep_hits = all_means_hits(1,4);
mean_mix_rep_hits = all_means_hits(1,5);
mean_mix_norep_hits = all_means_hits(1,6);

%plot
xvalues=[mean_text_rep_hits mean_text_norep_hits mean_emoji_rep_hits...
    mean_emoji_norep_hits mean_mix_rep_hits mean_mix_norep_hits];
xerror=[ste_text_rep_hits ste_text_norep_hits ste_emojis_rep_hits...
    ste_emojis_norep_hits ste_mix_rep_hits ste_mix_norep_hits];
caption_x=['txtR';'txtN';'emjR';'emjN';'mixR';'mixN'];
caption_y='time';

figure(2)
fig=mybar(xvalues, xerror, caption_x,[],2);
ylim([0 1]);
ylabel('hits in percent','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('                     ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);


%%%%%Anova hits

anov_hits = cat(2, text_rep_hits, text_norep_hits, emojis_rep_hits,...
    emojis_norep_hits, mix_rep_hits, mix_norep_hits);
reshaped_means_hits=anov_hits';
column_of_hits=reshaped_means_hits(:);

 for s = 1:length(sessions)
     subjects(:,s)=repmat(s,6,1);
 end
    column_of_subjects=subjects(:);
    
 reps=[1 2 1 2 1 2]';
  column_of_reps=repmat(reps,s,1);
  stims=[1 1 2 2 3 3]';
  column_of_stims=repmat(stims,s,1);
   factor_names={'reps' 'stim'};
rm_anova2(column_of_hits, column_of_subjects, column_of_reps, column_of_stims, factor_names)

% Anova reaction time
% 
anov_times = cat(2, text_rep, text_norep, emojis_rep,...
    emojis_norep, mix_rep, mix_norep);
reshaped_times=anov_times';
column_of_times=reshaped_times(:);

 for s = 1:length(sessions)
     subjects(:,s)=repmat(s,6,1);
 end
    column_of_subjects=subjects(:);
    
 reps=[1 2 1 2 1 2]';
  column_of_reps=repmat(reps,s,1);
  stims=[1 1 2 2 3 3]';
  column_of_stims=repmat(stims,s,1);
   factor_names={'reps' 'stim'};
rm_anova2(column_of_times, column_of_subjects, column_of_reps, column_of_stims, factor_names)


%%standard error for average hit rates 

mean_all_hitrates = mean(summary_hits, 2);
ste_hitrates_all = (std(mean_all_hitrates) /sqrt(length(mean_all_hitrates)))/28

%%%standard error for average reaction times
mean_all_times = mean(anov_times, 2);
ste_times_all = std(mean_all_times) /sqrt(length(mean_all_times))