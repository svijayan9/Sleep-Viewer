function varargout = Sleep_thresholds_stats(handles)

% Reads value from the popupmenu. Determines which frequency band is being given
% a threshold


%Read popup menu value.
trace_type_stats=(get(findobj('Tag','Sleep_thresh_stats'),'Value'));


%Sleep threshold for given band is stored.
handles.masterfig4=gcbf;
setappdata(handles.masterfig4,'trace_type_stats',trace_type_stats);