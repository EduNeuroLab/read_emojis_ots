function WTA_correctSO_rep_adapt=run_WTA_classifier_correctSO_rep_adapt(runs,numconds,one_run_out_corr_all);


correctSO=zeros((numconds), length(runs));
correctSO_final=zeros((numconds/2), length(runs));


for m=1:length(runs)
    corr=one_run_out_corr_all(:,:,m)
    
    for w=1:numconds
        corrCol = corr(:,w); % from Run 1 to 2
        corrRow = corr(w,:); % and the other way around
        wtaCol = find(corrCol==max(corrCol)); % find the maximum value
        wtaRow = find(corrRow==max(corrRow));
        
        % we can also do the same think across certain conditions
        % for instance we might be interested in how well task can be
        % decoded irrespective of stimulus
        
        correct_matrix=[1 2 ; 3 4; 1 2; 3 4] %first we will create a matrix saying which 
        % conditions can be confused 
        
        if find(wtaCol==correct_matrix(w,:))>0 % now we check if for each conditions one of the correct answers  was given
            correctSO(w,m)=correctSO(w,m)+1/4;
        end
        
        if find(wtaRow==correct_matrix(w,:))>0 % we do this for all rows and columns
            correctSO(w,m)=correctSO(w,m)+1/4;
        end
        
        correctSO_final(1,m)=(correctSO(1,m)+correctSO(2,m)) % finally we add  up those conditions that can be confused
        correctSO_final(2,m)=(correctSO(3,m)+correctSO(4,m))

    end
end

WTA_correctSO_rep_adapt=mean(correctSO_final,2);
end