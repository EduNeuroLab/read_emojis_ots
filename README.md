# read_emojis_ots
This repository is a collection of all the analyses performed for the publication 
"Both mOTS-words and pOTS-words prefer emojis over text during a reading task" <br />
by Alexia Dalski(1,2), Holly Kular(3), Julia G. Jorgensen(3), Kalanit Grill-Spector(3,4), Mareike Grotheer(1,2)

1 Department of Psychology, Philipps-Universität Marburg, Marburg 35039, Germany.<br />
2 Center for Mind, Brain and Behavior – CMBB, Philipps-Universität Marburg and Justus-Liebig-Universität Giessen, Marburg 35039, Germany. <br />
3 Department of Psychology, Stanford University, Stanford, CA 94305, USA.<br />
4 Wu Tsai Neurosciences Institute, Stanford University, CA 94305, USA.<br />
<br />

## Project description
The visual word form area in the occipitotemporal sulcus, here referred to as OTS-words, responds more strongly to text than other visual stimuli and plays a critical role in reading. Here we hypothesized, that this region’s preference for text may be driven by a preference for reading tasks, as in most prior fMRI studies only the text stimuli were readable. To test this, we performed three fMRI experiments (N=15) and systematically varied the participant’s task and the visual stimulus, investigating mOTS-words and pOTS-words subregions. 
### Experiments
We ran 3 fMRI experiments on 15 subjects:<br />
Exp 1: Localizer : Five visual categories were presented while adult subjects performed a 1-back task, images were either colored or in grayscale.<br />
Exp 2:  fMRI adaptation : 2 pairs of images were presented, whereas each pair formed an English compound word; participants had to indicate when the image was white. All images in a trial were either in emoji, text, or mixed format. Pairs in a trial could be repeated or non-repeated.<br />
Exp 3: Reading vs. color judgment: Subjects performed a reading or a color judgment task on compound words, formed either from text or emoji stimuli.<br />

## Neccessary packages 
- [Freesurfer](https://surfer.nmr.mgh.harvard.edu/) for segmenting the anatomical brain volume of each participant 
- [ITKGray](http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/ItkGray) manual correction and surface reconstruction 
- [mrVista Toolbox](http://github.com/vistalab) functional analysis
## ROI creation
- [makeROIdiskGray.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/makeROIdiskGray.m) creates an ROI in the grey matter
- [load_and_save_volume_ROIs.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/load_and_save_volume_ROIs.m) transfers all ROIs into the folders with the experimental data to easily retrieve them for the analysis of experiment 2 and 3
- [roi_size_emoji.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/roi_size_emoji.m) calculates size of ROI for each participant

## Behavioral Analyses 
- [final_behavior_exp1_time.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/final_behavior_exp1_time.m) calculates performance (hit rate and reaction time for each condition in experiment 1 and compares them)
- [final_behavior_exp2_time.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/final_behavior_exp2_time.m) calculates performance (hit rate and reaction time for each condition in experiment 2 and compares them)
- [final_behavior_exp3_time.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/final_behavior_exp2_time.m) calculates performance (hit rate and reaction time for each condition in experiment 3 and compares them)
## Univariate Analyses:
### Exp 2: fMRI adaptation
- [extract_betas_adaptation_merged.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/extract_betas_adaptation_merged.m) calculates % of BOLD signal change for each ROI, participant and condition; runs a repeated measure ANOVA with 2 Factors (Reptition: repeated vs. non-repeated trials, Stimulus: emojis, text, mixed)
- [extract_betas_adaptation_merged_postHoc.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/extract_betas_adaptation_merged_postHoc.m) runs a tukey-kramer post-hoc test on the univarate analyses of experiment 3 

### Exp 3: reading vs. color judgement
- [extract_betas_emoji_noCongruence.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/extract_betas_adaptation_merged.m)
calculates % of BOLD signal change for each ROI, participant and condition; runs a repeated measure ANOVA with 2 Factors (Task: reading vs. color judgement, Stimulus: emojis vs. text)
- [extract_betas_emoji_noCongruence_postHoc.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/extract_betas_emoji_noCongruence_postHoc.m)
runs a tukey-kramer post-hoc test on the univarate analyses of experiment 3 

## Multivariate Analyses
- [MVPA_wrapper_adapt_6cond_leave1runout.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/MVPA_wrapper_adapt_6cond_leave1runout.asv) RSA for experiment 2  fMRI adaptation calculates RSM for an ROI, contrasting MVPs of different stimuli (emoji vs. text vs. mixed) and repetition (repeated vs. non-repeated). Each RDM is calculated for one subject at a time and later merged into a mean RDM
- [MVPA_wrapper_adapt_4cond_leave1runout.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/Mvpa_wrapper_adapt_4cond_leave1runout.asv) RSA for experiment 2  fMRI adaptation calculates RSM for an ROI, contrasting MVPs of different stimuli (emojivs. text) and repetition (repeated vs. non-repeated) 
For this analysis we will not use the mixed condition. Each RDM is calculated for one subject at a time and later merged into an mean RDM.After calculating the RDM we will run WTA-classifiers decoding repetition and stimulus. Here again, WTA-classifier performances will be calculated for each subject and then averaged across all subjects. Finally, we test WTA-classifier performance against chance compare the
%performance for stimulus and repetition to one another
- [MVPA_wrapper_emoji_leave1runout.m](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/MVPA_wrapper_emoji_leave1runout.m)RSA for experiment 3  task and stimulus preferences calculates RSM for an ROI, contrasting MVPs of different stimuli (emojivs. text) and task (reading vs.color judgement) 
Each RDM is calculated for one subject at a time and later merged into an mean RDM. After calculating the RDM we will run WTA-classifiers decoding task
and stimulus.Here again, WTA-classifier performances will be calculated for each subject and then averaged across all subjects. Finally, we test WTA-classifier performance against chance compare the
%performance for stimulus and task to one another
-[MVPA_wrapper_eexp2and3_averagedruns](https://github.com/EduNeuroLab/read_emojis_ots/blob/main/MVPA_wrapper_exp2and3_averageruns.m) RSA for experiment 2 and 3. We take runs from both exeriments for this analysis and calculate an RSM for an ROI, contrasting MVPs of different stimuli (emoji
%vs. text) and task/paradigm (reading vs.color judgement vs Black/White judgement). Each RDM is calculated for one subject at a time and later merged into an mean RDM
