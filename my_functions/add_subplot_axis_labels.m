function [ ] = add_subplot_axis_labels( figure_handle, x_axis_label, y_axis_label )
% Add x and y labels on an invisible background layer of plot.
% Usage: add_subplot_axis_labels(fig_handle,x_axis_label,y_axis_label)
%
% modified from http://www.mathworks.com/matlabcentral/answers/78036-how-to-add-figure-title-and-axes-labels-for-multiple-plots
%
% fig = figure handle (probably already set in script when generating the
% plot
%
% x_axis_label = character string that will become the label along the x
% axis
%
% y_axis_label = character string that will be the label along the y axis
%
% Author: Halle R. Zucker

    background_axes = axes;
    % make background axes invisible
    background_color = get(figure_handle,'Color');
    set(background_axes,'Xcolor',background_color,...
        'Ycolor',background_color,...
        'box','off','Color','none')
    xlabel(x_axis_label,'Color','k')
    ylabel(y_axis_label,'Color','k')
    % position the background axes to be at the bottom
    uistack(background_axes,'bottom')
    % clean up before moving onto next plot
    clear background_axes background_color
end