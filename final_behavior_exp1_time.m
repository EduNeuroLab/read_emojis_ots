%This script performs the behavioral analysis for experiment 1 
%hit rates and reaction times are calculates across all conditions

%codes: 1 = word, 2 = word-colored, 3 = limb, 4 = limb-colored, 
% 5 = adult, 6 = adult-colored, 7 = house, 8 = house-colored, 9 = instrument,
%10 = instrument-colored 
clear all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','emoji','data');
% % 
sessions={'01_hk_fLOC_121620' '02_cc_fLOC_021821' '03_EK29_fLOC_030521' '05_IK30_fLOC_030421'...
     '06_KT30_fLOC_031121' '07_GP21_fLOC_051221' '10_HL27_fLOC_0551821' '11_CS63_fLOC_051821'...
     '12_SCW23_fLOC_060321' '13_GN23_fLOC_062121' '14_MW28_fLOC_070821' '15_MM21_fLOC_071921'...
  '16_ST22_fLOC_070821' '17_JL21_fLOC_072021' '18_HJ26_fLOC_073021'};


summary = zeros(15,5);
summary_hits = zeros(15,10);
summary_all_cats = zeros(15,10);

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
type1 = run1.theSubject.trials.cond;%where the condition is stored 
hit1 = run1.theData.resp
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
all_hits = cat(1, compare1_hit, compare2_hit, compare3_hit, compare4_hit);
all_hits = nonzeros(all_hits);

%%counting hits per condition 
edges = unique(all_hits);  
counts = histc(all_hits(:), edges);
edges = edges';
counts = counts';
summary_hit = cat (1, edges, counts);

sub_over = zeros(2,10);
sub_over(1,:) = [1,2,3,4,5,6,7,8,9,10];
missing = setdiff(sub_over(1,:), summary_hit(1,:));
TF = isempty(missing);

% %participant 15 (s = 11) had no hits in condition 9 
if s == 12
    temp_1 = summary_hit(:,1:8)
    temp_2 = [9;0]
    temp_3 = summary_hit(:,9)
    summary_hit = horzcat(temp_1, temp_2, temp_3)
else 
    
end 
    
hits_only = summary_hit(2,:);
summary_hits(s,:) = hits_only;

%%averaging reaction time for each condition in a subject
only_1 = all_onesubject(any(all_onesubject==1, 2), :);
mean_1 = mean(only_1);
mean_1 =mean_1(1,1);

only_2 = all_onesubject(any(all_onesubject==2, 2), :);
mean_2 = mean(only_2);
mean_2 =mean_2(1,1);

only_3 = all_onesubject(any(all_onesubject==3, 2), :);
mean_3 = mean(only_3);
mean_3 =mean_3(1,1);

only_4 = all_onesubject(any(all_onesubject==4, 2), :);
mean_4 = mean(only_4);
mean_4 =mean_4(1,1);

only_5 = all_onesubject(any(all_onesubject==5, 2), :);
mean_5 = mean(only_5);
mean_5 =mean_5(1,1);

only_6 = all_onesubject(any(all_onesubject==6, 2), :);
mean_6 = mean(only_6);
mean_6 =mean_6(1,1);

only_7 = all_onesubject(any(all_onesubject==7, 2), :);
mean_7 = mean(only_7);
mean_7 =mean_7(1,1);

only_8 = all_onesubject(any(all_onesubject==8, 2), :);
mean_8 = mean(only_8);
mean_8 =mean_8(1,1);

only_9 = all_onesubject(any(all_onesubject==9, 2), :);
mean_9 = mean(only_9);
mean_9 =mean_9(1,1);

only_10 = all_onesubject(any(all_onesubject==10, 2), :);
mean_10 = mean(only_10);
mean_10 =mean_10(1,1);

%summarizing reaction times of all participants:
one_sub_all = cat(1, mean_1, mean_2, mean_3, mean_4, mean_5, mean_6, mean_7, mean_8, mean_9, mean_10);
one_sub = cat(1, mean([mean_1, mean_2]), mean([mean_3, mean_4]), mean([mean_5, mean_6]), mean([mean_7, mean_8]), mean([mean_9, mean_10]));
one_sub_tran = transpose(one_sub);
one_sub_all_tran = one_sub_all;
summary(s, :) = one_sub_tran;
summary_all_cats(s,:) =one_sub_all_tran;

end 

%means and NaN: 
%check for NaNs: 
y1 = isnan(summary)  %there is an Nan in the last column (instruments)
%replace: 
instru = summary(:,5)
mean_5 = nanmean(instru)
summary(isnan(summary)) = mean_5
summary_all_cats(12,9) = mean_5


%select each condition
just_words = summary(:,1)
just_limbs = summary(:,2)
just_adults = summary(:,3)
just_houses= summary(:,4)
just_instru = summary(:,5)

%standard error for each condition
ste_words = std(just_words) / sqrt(length(just_words))
ste_limbs = std(just_limbs) / sqrt(length(just_limbs))
ste_adults = std(just_adults) / sqrt(length(just_adults))
ste_houses = std(just_houses) / sqrt(length(just_houses))
ste_instru = std(just_instru) / sqrt(length(just_instru))

%means for each condition
all_means = mean(summary) 
mean_words = all_means(1,1)
mean_limbs = all_means(1,2)
mean_adult = all_means(1,3) 
mean_house = all_means(1,4)
mean_instrument = all_means(1,5)

xvalues=[mean_words mean_limbs mean_adult mean_house mean_instrument];
xerror=[ste_words ste_limbs ste_adults ste_houses ste_instru];
caption_x=['words';'limbs';'adult'; 'house'; 'instr'];
caption_y='time';

figure(1)
fig_time=mybar(xvalues, xerror, caption_x,[],2);
ylim([0 0.8]);
ylabel('reaction time in sec','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('                     ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);


%%%%%%%%%%%%%%%%%%%  same thing with hit rate %%%%%%%%%%%%%%%%%%%%%%%%

hits_cats = [(summary_hits(:,1) + summary_hits(:,2)) (summary_hits(:,3) + summary_hits(:,3))...
   (summary_hits(:,5) + summary_hits(:,6)) (summary_hits(:,7) + summary_hits(:,8))...
   (summary_hits(:,9) + summary_hits(:,10))]

just_words_hits = (hits_cats(:,1))/16;
just_limbs_hits  = hits_cats(:,2)/16;
just_adults_hits = hits_cats(:,3)/16;
just_houses_hits= hits_cats(:,4)/16;
just_instru_hits = hits_cats(:,5)/16;

%standard error for each condition
ste_words_hits = std(just_words_hits) / sqrt(length(just_words_hits));
ste_limbs_hits = std(just_limbs_hits) / sqrt(length(just_limbs_hits));
ste_adults_hits = std(just_adults_hits) / sqrt(length(just_adults_hits));
ste_houses_hits = std(just_houses_hits) / sqrt(length(just_houses_hits));
ste_instru_hits = std(just_instru_hits) / sqrt(length(just_instru_hits));

%mean for each condition in %
mean_words_hits = mean(just_words_hits);
mean_limbs_hits = mean(just_limbs_hits);
mean_adults_hits = mean(just_adults_hits);
mean_houses_hits = mean(just_houses_hits);
mean_instru_hits = mean(just_instru_hits);

xvalues=[mean_words_hits, mean_limbs_hits mean_adults_hits mean_houses_hits mean_instru_hits]
xerror=[ste_words_hits ste_limbs_hits ste_adults_hits ste_houses_hits ste_instru_hits];
caption_x=['words';'limbs';'adult'; 'house'; 'instr'];
caption_y='hits';

figure(2)
fig_hits=mybar(xvalues, xerror, caption_x,[],2);
ylim([0 1]);
ylabel('hits','FontSize',16,'FontName','Arial','FontWeight','bold');
 xlabel('                     ','FontSize',16,'FontName','Arial','FontWeight','bold');
pbaspect([2 1 1])
set(gca,'FontSize',16,'FontName','Arial','FontWeight','bold'); box off; set(gca,'Linewidth',3);

%%%%anova hits
anov_hits = summary_hits;
reshaped_means_hits=reshape(anov_hits',10,length(sessions));
column_of_hits=reshaped_means_hits(:);

for s = 1:length(sessions)
     subjects(:,s)=repmat(s,10,1);
 end
 
  column_of_subjects=subjects(:);
%  
  color=[1 2 1 2 1 2 1 2 1 2]'
  column_of_color=repmat(color,s,1);
%  
  stims=[1 1 2 2 3 3 4 4 5 5]'
  column_of_stims=repmat(stims,s,1);
   factor_names={'color' 'stim'};
rm_anova2(column_of_hits, column_of_subjects, column_of_color, column_of_stims, factor_names)

%%%%%anova reaction time 

anov_hits = summary_all_cats;
reshaped_means_hits=reshape(anov_hits',10,length(sessions));
column_of_times=reshaped_means_hits(:);

for s = 1:length(sessions)
     subjects(:,s)=repmat(s,10,1);
 end
 
  column_of_subjects=subjects(:);
%  
  color=[1 2 1 2 1 2 1 2 1 2]'
  column_of_color=repmat(color,s,1);
%  
  stims=[1 1 2 2 3 3 4 4 5 5]'
  column_of_stims=repmat(stims,s,1);
   factor_names={'color' 'stim'};
rm_anova2(column_of_times, column_of_subjects, column_of_color, column_of_stims, factor_names)


%%standard error for average hit rates 

mean_all_hitrates = mean(summary_hits, 2);
ste_hitrates_all = (std(mean_all_hitrates) /sqrt(length(mean_all_hitrates)))/16

%%%standard error for average reaction times
mean_all_times = mean(summary_all_cats, 2);
ste_times_all = std(mean_all_times) /sqrt(length(mean_all_times))
