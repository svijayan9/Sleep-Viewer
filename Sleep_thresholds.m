function varargout = Sleep_thresholds(handles)

% Reads value from the popupmenu. Determines which frequency band is being given
% a threshold


%Read popup menu value.
trace_type=(get(findobj('Tag','Sleep_thresh'),'Value'));


%Sleep threshold for given band is stored.
handles.masterfig3=gcbf;
setappdata(handles.masterfig3,'trace_type',trace_type);