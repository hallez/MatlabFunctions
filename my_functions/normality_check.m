function [H,P] = normality_check(inputdata,nplot)
% checks re normality of distribution using Jarque-Bera test of normality

% Returns H and P. H=0 when the data are not normally distrubted and H=1
% when the data are normally distributed. P returns the p-value threshold
% that was used. When ~H=1, will plot scatterplots of the raw data for
% visual inspection and save to Figure#.png (in current directory). Will
% also compute arc sine transformation and save to data_AS in current
% directory. 
% NB: the caluclations used here for the arc sine transformation come from
% MacDuffie, et al. (2012) and Howell (1997)

fprintf('Testing normality.\n');
data = inputdata;
[H,P]=jbtest(data,.05);
if ~H 
%     outputvarname = 2 .* asin(sqrt(data)); %asin = inverse sine (ie, arc sine)
%     save(strcat(outputvarname,'.mat'),outputvarname)
    nplot = nplot + 1; 
    figure(nplot)
    s(nplot) = scatter(1:length(data), data);
    title('Scatterplot of raw data')
    xlabel('Subjects')
    ylabel('Raw data')
    print(sprintf('Figure%d.png',s(nplot)),'-dpng')
end %if

end

