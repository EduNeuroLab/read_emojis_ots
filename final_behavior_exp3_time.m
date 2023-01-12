%This script performs the behavioral analysis for experiment 3 
%hit rates and reaction times are calculates across all conditions
% % Number	Abbrev	Task	Stimulus	Match?
% % 21        SREM	Read	Emoji       Match
% % 22        SREMM	Read	Emoji       Mismatch
% % 23        SRTM	Read	Text        Match
% % 24        SRTMM	Read	Text        Mismatch
% % 25        SCEM	Color	Emoji       Match
% % 26        SCEMM	Color	Emoji       Mismatch
% % 27        SCTM	Color	Text        Match
% % 28        SCTMM	Color	Text        Mismatch
% 
 clear all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');

sessions = {'01_hk_emoji_06521' '02_cc_emoji_031921' '03_EK29_emoji_031721' '05_IK30_emoji_040221'...
'06_KT30_emoji_061621' '07_GP21_emoji_051921_v2' '10_HL27_emoji_052121'...
'11_CS63_emoji_062821' '12_SCW23_emoji_063021' '13_GN23_emoji_062221'...
'14_MW28_emoji_070921' '15_MM21_emoji_072021' '16_ST22_emoji_071221'...
'17_JL21_emoji_072221' '18_HJ26_emoji_072921'};

summary = zeros(15,4);
summary_hits = zeros(15,8)


for s = 1:length(sessions) %iterate over all subjects
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
type1 = run1.theData.type;%where the condition is stored 
type1( :, ~any(type1,1) ) = [];
hit1 = run1.theData.perf;
compare1 = cat(1, time1, type1);
compare1 = compare1';
compare1_hit = cat(1, hit1, type1);
compare1_hit = compare1_hit';
indices1_hit = find(compare1_hit(:,1)==0);
compare1_hit(indices1_hit,:) = []
compare1_hit(:,1) = [];

 run2 = matData(2);
time2 = run2.theData.rt; %where the reaction time are stored
type2 = run1.theData.type;%where the condition is stored 
type2( :, ~any(type2,1) ) = [];
hit2 = run2.theData.perf
compare2 = cat(1, time2, type2);
compare2 = compare2';
compare2_hit = cat(1, hit2, type2);
compare2_hit = compare2_hit';
indices2_hit = find(compare2_hit(:,1)==0);
compare2_hit(indices2_hit,:) = []
compare2_hit(:,1) = [];

 run3 = matData(3);
time3 = run3.theData.rt; %where the reaction time are stored
type3 = run3.theData.type;%where the condition is stored (in this cas 1-8)
type3( :, ~any(type3,1) ) = [];
hit3 = run3.theData.perf;
compare3 = cat(1, time3, type3);
compare3 = compare3';
compare3_hit = cat(1, hit3, type3);
compare3_hit = compare3_hit';
indices3_hit = find(compare3_hit(:,1)==0);
compare3_hit(indices3_hit,:) = []
compare3_hit(:,1) = [];

 run4 = matData(4);
time4 = run4.theData.rt; %where the reaction time are stored
type4 = run4.theData.type;%where the condition is stored
type4( :, ~any(type4,1) ) = [];
hit4 = run4.theData.perf;
compare4 = cat(1, time4, type4);
compare4 = compare4';
compare4_hit = cat(1, hit4, type4);
compare4_hit = compare4_hit';
indices4_hit = find(compare4_hit(:,1)==0);
compare4_hit(indices4_hit,:) = []
compare4_hit(:,1) = [];

 run5 = matData(5);
time5 = run5.theData.rt; %where the reaction time are stored
type5 = run5.theData.type;%where the condition is stored
type5( :, ~any(type5,1) ) = [];
hit5 = run5.theData.perf;
compare5 = cat(1, time5, type5);
compare5 = compare5';
compare5_hit = cat(1, hit5, type5);
compare5_hit = compare5_hit';
indices5_hit = find(compare5_hit(:,1)==0);
compare5_hit(indices5_hit,:) = []
compare5_hit(:,1) = [];

 run6 = matData(6);
time6 = run6.theData.rt; %where the reaction time are stored
type6 = run6.theData.type;%where the condition is stored
type6( :, ~any(type6,1) ) = [];
hit6 = run6.theData.perf;
compare6 = cat(1, time6, type6);
compare6 = compare6';
compare6_hit = cat(1, hit6, type6);
compare6_hit = compare6_hit';
indices6_hit = find(compare6_hit(:,1)==0);
compare6_hit(indices6_hit,:) = []
compare6_hit(:,1) = [];

 run7 = matData(7);
time7 = run7.theData.rt; %where the reaction time are stored
type7 = run7.theData.type;%where the condition is stored
type7( :, ~any(type7,1) ) = [];
hit7 = run7.theData.perf;
compare7 = cat(1, time7, type7);
compare7 = compare7';
compare7_hit = cat(1, hit7, type7);
compare7_hit = compare7_hit';
indices7_hit = find(compare7_hit(:,1)==0);
compare7_hit(indices7_hit,:) = []
compare7_hit(:,1) = [];

 run8 = matData(8);
time8 = run8.theData.rt; %where the reaction time are stored
type8 = run8.theData.type;%where the condition is stored
type8( :, ~any(type8,1) ) = [];
hit8 = run8.theData.perf;
compare8 = cat(1, time8, type8);
compare8 = compare8';
compare8_hit = cat(1, hit8, type8);
compare8_hit = compare8_hit';
indices8_hit = find(compare8_hit(:,1)==0);
compare8_hit(indices8_hit,:) = []
compare8_hit(:,1) = [];

all_onesubject = cat(1, compare1, compare2, compare3, compare4, compare5, compare6, compare7, compare8);
all_hits = cat(1, compare1_hit, compare2_hit, compare3_hit, compare4_hit, compare5_hit, compare6_hit,...
                  compare7_hit, compare8_hit);
all_hits = nonzeros(all_hits);

%%counting hits per condition 
edges = unique(all_hits)
counts = histc(all_hits(:), edges)
edges = edges';
counts = counts';
summary_hit = cat (1, edges, counts);
hits_only = summary_hit(2,:);
summary_hits(s,:) = hits_only;

%mean reaction times
only_21 = all_onesubject(any(all_onesubject==21, 2), :);
mean_21 = mean(only_21);
mean_21 =mean_21(1,1);

only_22 = all_onesubject(any(all_onesubject==22, 2), :);
mean_22 = mean(only_22);
mean_22 =mean_22(1,1);

only_23 = all_onesubject(any(all_onesubject==23, 2), :);
mean_23 = mean(only_23);
mean_23 =mean_23(1,1);

only_24 = all_onesubject(any(all_onesubject==24, 2), :);
mean_24 = mean(only_24);
mean_24 =mean_24(1,1);

only_25 = all_onesubject(any(all_onesubject==25, 2), :);
mean_25 = mean(only_25);
mean_25 =mean_25(1,1);

only_26 = all_onesubject(any(all_onesubject==26, 2), :);
mean_26 = mean(only_26);
mean_26 =mean_26(1,1);

only_27 = all_onesubject(any(all_onesubject==27, 2), :);
mean_27 = mean(only_27);
mean_27 =mean_27(1,1);

only_28 = all_onesubject(any(all_onesubject==28, 2), :);
mean_28 = mean(only_28);
mean_28 =mean_28(1,1);

one_sub = cat(1, mean([mean_21, mean_22]), mean([mean_23, mean_24]), mean([mean_25, mean_26]), mean([mean_27, mean_28]));
one_sub_tran = transpose(one_sub);
summary(s, :) = one_sub_tran;

end 

%%means and visualiuation for the reaction time
%select each condition
emoji_read = summary(:,1);
text_read= summary(:,2);
emoji_color = summary(:,3);
text_color= summary(:,4);

%standard error for each condition
ste_emoji_read = std(emoji_read) / sqrt(length(emoji_read));
ste_text_read = std(text_read) / sqrt(length(text_read));
ste_emoji_color = std(emoji_color) / sqrt(length(emoji_color));
ste_text_color = std(text_color) / sqrt(length(text_color));


%means for each condition
all_means = mean(summary) 
mean_emoji_read = all_means(1,1)
mean_text_read = all_means(1,2)
mean_emoji_color = all_means(1,3) 
mean_emoji_text = all_means(1,4)

%plot
xvalues=[mean_emoji_read  mean_text_read  mean_emoji_color mean_emoji_text];
xerror=[ste_emoji_read  ste_text_read   ste_emoji_color   ste_text_color];
caption_x=['emjR';'txtR';'emjC';'txtC'];
caption_y='time';

figure(1)
fig=mybar(xvalues, xerror, caption_x,[],2);
ylim([0 0.9]);
ylabel('reaction time in sec','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('Read                         Color   ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);

%%means and visualizization for the hit rates

emoji_read_hits = ((summary_hits(:,1)+summary_hits(:,2))/48);
text_read_hits = ((summary_hits(:,3)+summary_hits(:,4))/48);
emoji_color_hits = ((summary_hits(:,5)+summary_hits(:,6))/48);
text_color_hits = ((summary_hits(:,7)+summary_hits(:,8))/48);

%standard error for each condition
ste_emoji_read_hits = std(emoji_read_hits) / sqrt(length(emoji_read_hits));
ste_text_read_hits = std(text_read_hits) / sqrt(length(text_read_hits));
ste_emoji_color_hits = std(emoji_color_hits) / sqrt(length(emoji_color_hits));
ste_text_color_hits = std(text_color_hits) / sqrt(length(text_color_hits));

%%%mean
mean_emoji_read_hits = mean(emoji_read_hits);
mean_text_read_hits = mean(text_read_hits);
mean_emoji_color_hits = mean(emoji_color_hits);
mean_text_color_hits = mean(text_color_hits);

%plot
xvalues=[mean_emoji_read_hits  mean_text_read_hits  mean_emoji_color_hits mean_emoji_color_hits];
xerror=[ste_emoji_read_hits  ste_text_read_hits   ste_emoji_color_hits   ste_text_color_hits];
caption_x=['emjR';'txtR';'emjC';'txtC'];
caption_y='hits';

figure(2)
fig=mybar(xvalues, xerror, caption_x,[],2);
ylim([0 1]);
ylabel('hits in %','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('Read                         Color   ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);


%%%%%%Anova hits

anov_hits = cat(2, emoji_read_hits, text_read_hits, emoji_color_hits, text_color_hits);
reshaped_means_hits=reshape(anov_hits',4,length(sessions));
column_of_hits=reshaped_means_hits(:);

 for s = 1:length(sessions)
     subjects(:,s)=repmat(s,4,1);
 end
 
  column_of_subjects=subjects(:);
%  
  task=[1 1 2 2]'
  column_of_tasks=repmat(task,s,1);
%  
  stims=[1 2 1 2]'
  column_of_stims=repmat(stims,s,1);
   factor_names={'task' 'stim'};
rm_anova2(column_of_hits, column_of_subjects, column_of_tasks, column_of_stims, factor_names)


%%%%%%Anova reaction time

reshaped_times=reshape(summary',4,length(sessions));
column_of_times=reshaped_times(:);

 for s = 1:length(sessions)
     subjects(:,s)=repmat(s,4,1);
 end
 
  column_of_subjects=subjects(:);
%  
  task=[1 1 2 2]';
  column_of_tasks=repmat(task,s,1);
%  
  stims=[1 2 1 2]';
  column_of_stims=repmat(stims,s,1);
   factor_names={'task' 'stim'};
rm_anova2(column_of_times, column_of_subjects, column_of_tasks, column_of_stims, factor_names)

%%%%post hoc für reaction times%%% 

 reshaped_betas_inverted=reshaped_times' 

table_for_rmANOVA=table(reshaped_betas_inverted(:,1),reshaped_betas_inverted(:,2),...
    reshaped_betas_inverted(:,3),reshaped_betas_inverted(:,4),... 
    'VariableNames',{'re','rt','ce','ct'});
WithinDesign = table([1 1 2 2]',[1 2 1 2]','VariableNames',{'task','stim'});
WithinDesign.task = categorical(WithinDesign.task);
WithinDesign.stim = categorical(WithinDesign.stim);

rm = fitrm(table_for_rmANOVA, 're,rt,ce,ct~1','WithinDesign',WithinDesign);
ranovatable = ranova(rm,'WithinModel','task*stim')
multcompare(rm, 'stim','by','task','ComparisonType',['tukey-kramer'])


%%%standard error for average hit rates
mean_all_hitrates = mean(anov_hits, 2);
ste_hitrates_all = std(mean_all_hitrates) /sqrt(length(mean_all_hitrates))

%%%standard error for average reaction times
mean_all_times = mean(summary, 2);
ste_times_all = std(mean_all_times) /sqrt(length(mean_all_times))
