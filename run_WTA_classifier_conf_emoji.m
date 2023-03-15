function WTA_conf_emoji=run_WTA_classifier_conf_emoji(runs,numconds,one_run_out_corr_all)


conf=zeros(numconds,numconds);

for m=1:length(runs)
    
    corr=one_run_out_corr_all(:,:,m);
    for w=1:numconds
        corrCol = corr(:,w); % from Run 1 to 2
        corrRow = corr(w,:); % and the other way around
        wtaCol = find(corrCol==max(corrCol)); % find the maximum value
        wtaRow = find(corrRow==max(corrRow));
        
        % Now check if the maximum is the same as w, basically if
        % the highest value is obtained for the category at hand.
        if wtaCol == w && wtaRow == w % if both predictions are correct
            conf(w, wtaRow, m) = 0;
        elseif wtaCol == w && wtaRow ~= w % first one correct but 2nd incorrect
            conf(w, wtaRow, m) = 0.5;
        elseif wtaCol ~= w && wtaRow == w % second one correct but 1st incorrect
            conf(w, wtaCol, m) = 0.5;
        else % both are incorrect
            if wtaCol == wtaRow % and both took the same category
                conf(w, wtaCol, m) = 1;
            else
                conf(w, wtaCol, m) = 0.5;
                conf(w, wtaRow, m) = 0.5;
            end
        end
        
    end
end
        

WTA_conf_emoji=mean(conf,3);


end