function varargout=Saved_TValues(handles)

[filename,pathname,filterindex] = uigetfile('*.*','Cutoff times file, please.')

if filterindex==0
    errordlg('You did not pick a file','Bad Input','modal')
    return
end

if filterindex~=0
    
    fname=fullfile(pathname,filename);
    load(fname);
    handles.masterfig3=gcbf;
    sleep=getappdata(handles.masterfig3,'sleep');
    sleep.cutoffs=state.cutoffs;
    setappdata(handles.masterfig3,'sleep',sleep);

end