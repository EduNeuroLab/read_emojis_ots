
function WTA_correctSO_task_emoji=run_WTA_classifier_emoji_task(runs,numconds,one_run_out_corr_all);

correctSO=zeros((numconds/2), length(runs));
correctSO2=zeros(numconds, length(runs));
correctSO_final=zeros((numconds/2), length(runs));

for m=1:length(runs)
    corr=one_run_out_corr_all(:,:,m)
    
    for w=1:numconds
        corrCol = corr(:,w); % from Run 1 to 2
        corrRow = corr(w,:); % and the other way around
        wtaCol = find(corrCol==max(corrCol)); % find the maximum value
        wtaRow = find(corrRow==max(corrRow));
        
        if floor((wtaCol+1)/2)==floor((w+1)/2)
            correctSO(floor((w+1)/2),m)= correctSO(floor((w+1)/2),m)+0.25;
        end
        if floor((wtaRow+1)/2)==floor((w+1)/2)
            correctSO(floor((w+1)/2),m)= correctSO(floor((w+1)/2),m)+0.25;
        end
        
        
        % we can also do the same think across certain conditions
        % for instance we might be interested in how well task can be
        % decoded irrespective of stimulus
        
        correct_matrix=[1 2; 1 2; 3 4; 3 4]; %first we will create a matrix saying which 
        % conditions can be confused
        
        if find(wtaCol==correct_matrix(w,:))>0 % now we check if for each conditions one of the correct answers  was given
            correctSO2(w,m)=correctSO2(w,m)+0.25;
        end
        
        if find(wtaRow==correct_matrix(w,:))>0 % we do this for all rows and columns
            correctSO2(w,m)=correctSO2(w,m)+0.25;
        end
        
        correctSO_final(1,m)=(correctSO2(1,m)+correctSO2(2,m)) % finally we add  up those conditions that can be confused
        correctSO_final(2,m)=(correctSO2(3,m)+correctSO2(4,m))
    end
end

WTA_correctSO_task_emoji=mean(correctSO_final,2);

end