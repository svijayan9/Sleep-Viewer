function varargout = Sleep_Viewer_controls(handles)

% These are the primary controls to display the position points.

uicontrol(handles.masterfig3,'Style','slider','Units','normalized','Tag','EEG_slider','Position',[.04 .002 .7 .03],'Callback','Sleep_Viewer_controls_slide','Value',1);
uicontrol(handles.masterfig3,'Style','pushbutton','Tag','Set_thresh','Units','normalized','string','Set_Thresholds','Position',[.857 .115 .08 .03],'Callback','Set_threshold');
uicontrol(handles.masterfig3,'Style','popupmenu','Tag','Sleep_thresh','Units','normalized','String','Delta|Spindle|Alpha|Theta|EMG-SWS|EMG-REM|EOG|Delta-Low','Position',[.845 .125 .10 .05],'Callback','Sleep_thresholds','Value',1);
uicontrol(handles.masterfig3,'Style','text','Tag','thresh_name','Units','normalized','String','Set Thresholds for Sleep Classification','Position',[.819 .178 .15 .025]);
uicontrol(handles.masterfig3,'Style','pushbutton','Tag','SC','Units','normalized','string','Sleep Classification','Position',[.846 .06 .10 .025],'Callback','SCC2');
uicontrol(handles.masterfig3,'Style','text','Tag','Sleep_class_return','Units','normalized','Position',[.846 .02 .10 .03]);