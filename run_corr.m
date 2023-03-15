function one_run_out_corr_all=run_corr(OutDirInd,session,roi,runs,conditions,z_values_all)

numconds=length(conditions);
for m=1:length(runs) %equvialent to number of iteration
    leave_out_run=runs(m);
    other_runs=runs(runs~=leave_out_run);
    z_values_leave_out_run=z_values_all(:,:,m);
    
    for x=1:length(other_runs)
        z_values_other_runs(:,:,x)=z_values_all(:,:,other_runs(x));
    end
    
    if length(other_runs)>1
    avg_z_values_other_runs=mean(z_values_other_runs,3);
    outfilename=sprintf('loc_RSM_%s_%s_z_1rout.png',session,roi');
    else
    avg_z_values_other_runs=z_values_other_runs;
    outfilename=sprintf('loc_RSM_%s_%s_z_split_half.png',session,roi');
    end
    
    for i=1:numconds
        for j=1:numconds
            tmpc=corrcoef(z_values_leave_out_run(:,i),avg_z_values_other_runs(:,j));
            corr(i,j)=tmpc(1,2);
            corr_name=sprintf('corr_%d',runs(m)');
            eval([corr_name '=corr;']);
        end
    end
    one_run_out_corr_all(:,:,m)=corr;
end
    
    
    one_run_out_average=mean(one_run_out_corr_all,3);
    
    for i=1:numconds %symmetrical correlation
        for j=1:i
            csym(i,j)=.5*(one_run_out_average(i,j)+one_run_out_average(j,i));
            csym(j,i)=csym(i,j);
        end
    end
    
    % plot correlation and save figure
    plot_corr(one_run_out_average, csym, OutDirInd, outfilename, conditions, session, roi, 0);
end
