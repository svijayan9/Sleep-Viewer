function varargout = Sleep_stats_controls(handles)

uicontrol(handles.masterfig4,'Style','slider','Units','normalized','Tag','Sleep_stats_controls_slider','Position',[.05 .0001 .85 .05],'Callback','Sleep_stats_controls_slide','Value',1);
uicontrol(handles.masterfig4,'Style','pushbutton','Tag','Set_thresh_stats','Units','normalized','string','Set_Thresholds','Position',[.91 .155 .08 .03],'Callback','Set_threshold_stats');
uicontrol(handles.masterfig4,'Style','popupmenu','Tag','Sleep_thresh_stats','Units','normalized','String','Delta|Spindle|Alpha|Theta|EMG-SWS|EMG-REM|EOG|Delta-Low|Central (2-6)|EOG-Slow|EOG-Blink','Position',[.91 .165 .08 .05],'Callback','Sleep_thresholds_stats','Value',1);