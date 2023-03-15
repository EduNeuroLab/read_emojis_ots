function WTA_correctC_emoji=run_WTA_classifier_correctC_emoji(runs,numconds,one_run_out_corr_all);

for m=1:length(runs)
    corr=one_run_out_corr_all(:,:,m)
    
    for w=1:numconds
        corrCol = corr(:,w); % from Run 1 to 2
        corrRow = corr(w,:); % and the other way around
        wtaCol = find(corrCol==max(corrCol)); % find the maximum value
        wtaRow = find(corrRow==max(corrRow));
        
        % Now check if the maximum is the same as w, basically if
        % the highest value is obtained for the category at hand.
        if wtaCol == w && wtaRow == w % if both predictions are correct
            correctC(w,m) = 1;
        elseif wtaCol == w && wtaRow ~= w % first one correct but 2nd incorrect
            correctC(w,m) = 0.5;
        elseif wtaCol ~= w && wtaRow == w % second one correct but 1st incorrect
            correctC(w,m) = 0.5;
        else % both are incorrect
            correctC(w, m) = 0;
        end
    end
end
    WTA_correctC_emoji=mean(correctC,2);
end