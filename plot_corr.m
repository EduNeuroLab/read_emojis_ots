

function plot_corr(cavg, csym, OutDir, outfilename, labelstring, session, roi, visible);
         % plot correlation
        numconds=length(labelstring);
        if visible==1;
        figure('Visible','on','color', [ 1 1 1], 'name', [ session ' '  roi],'units','norm', 'position', [ 0.1 .1 .6 .4]);
         else
          figure('Visible','off','color', [ 1 1 1], 'name', [ session ' '  roi],'units','norm', 'position', [ 0.1 .1 .6 .4]);
         end
        subplot(1,2,1); imagesc(cavg, [-.5 .5]); axis('image'); cmap=mrvColorMaps('coolhot'); colormap(cmap); colorbar; title('cavg')
        set(gca,'Xtick', [1:1:numconds], 'XtickLabel',labelstring)
        set(gca,'Ytick', [1:1:numconds], 'YtickLabel',labelstring)
        subplot(1,2,2); imagesc(csym, [-.5 .5]); axis('image');cmap=mrvColorMaps('coolhot'); colormap(cmap);colorbar; title('csym')
        set(gca,'Xtick', [1:1:numconds], 'XtickLabel',labelstring)
        set(gca,'Ytick', [1:1:numconds], 'YtickLabel',labelstring)
        
        % save figures.
      %  outfile=fullfile(OutDir, outfilename);
      %  saveas(gcf, outfile, 'fig')
        
        outfile=fullfile(OutDir, outfilename);
        saveas(gcf, outfile, 'png')
end
