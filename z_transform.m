

function [z_values]=z_transform(betas,residual,dof,numconds)

        % for z-values we also need the residual variance and the degrees of
        % freedom. z-values = subtracted-beta value devided by the standard deviation which is defined as
        % sqrt( residual ^2 / [degrees of freedom] )

        residualvar = sum(residual.^2)/dof;
        resd = sqrt(residualvar);
        resd = resd';
        resd_mat = repmat(resd, [1 numconds]);
        z_values = betas./resd_mat;    
        
        % if you want to look at the z-tranformed values:
        
        %         %create figures but don't plot them now.
%         figure('Visible','off','color', [ 1 1 1],'name', [ session ' ' ROIname]);
%         labelstring={'a','k','b','l','c','g','p','h','w','n'};
%         
%         
%         for p= 1:nrRuns
%             subplot(1,3,p); imagesc(z_values{p}, [-4 4]); cmap=mrvColorMaps('coolhot'); colormap(cmap); colorbar; title(sprintf('run %d', listRuns(s,p)))
%             set(gca,'Xtick', [1:1:10], 'XtickLabel',labelstring)
%         end
%        
%         sessionresults=fullfile(ExpDir,session, 'MVPA_results');
%         
%         if ~exist(sessionresults, 'dir')
%             mkdir(sessionresults);
%         end
%         
%         % save the figures.
% %         outfilename=sprintf('MVP_%s_%s_%s_%d_Runs_z.fig',session,ROIname, currentview, nrRuns');
% %         outfile=fullfile(sessionresults,outfilename);
% %         saveas(gcf, outfile, 'fig')
% %         outfilename=sprintf('MVP_%s_%s_%s_%d_Runs_z.png',session,ROIname, currentview, nrRuns');
% %         outfile=fullfile(sessionresults,outfilename);
% %         saveas(gcf, outfile, 'png')


end