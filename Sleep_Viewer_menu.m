function varargout = Sleep_Viewer_menu(handles)
handles.menu_data= uimenu(handles.masterfig3,'Label','Data');
handles.menu_data_open_pos_data=uimenu(handles.menu_data,'Label','Neocortical EEG Data','HandleVisibility','callback','Callback','Neo_EEG');
handles.menu_data_open_pos_data2a=uimenu(handles.menu_data,'Label','Alpha EEG Data','HandleVisibility','callback','Callback','Alpha_EEG');

handles.menu_data_open_pos_data2=uimenu(handles.menu_data,'Label','Ripple EEG Data','HandleVisibility','callback','Callback','Ripp_EEG');

handles.menu_data_open_pos_data3=uimenu(handles.menu_data,'Label','EMG Data','HandleVisibility','callback','Callback','EMG');
handles.menu_data_open_pos_data3=uimenu(handles.menu_data,'Label','EOG Data','HandleVisibility','callback','Callback','EOG');
handles.menu_data_open_pos_data4=uimenu(handles.menu_data,'Label','Overall Sleep Pattern','HandleVisibility','callback','Callback','Sleep_stats');
handles.menu_data_open_pos_data3=uimenu(handles.menu_data,'Label','Plot Sleep Classification Data','HandleVisibility','callback','Callback','Plot_classification');
handles.menu_data_open_pos_data33=uimenu(handles.menu_data,'Label','Load Sleep Threshold Values','HandleVisibility','callback','Callback','Saved_TValues');
handles.menu_data_open_pos_data3=uimenu(handles.menu_data,'Label','Save Sleep Classification Data','HandleVisibility','callback','Callback','Save_Sleep_Class');