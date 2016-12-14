function varargout = Set_threshold(handles)
%This function allows the user to set the thresholds for sleep
%classification

handles.masterfig3=gcbf;
trace_type=getappdata(handles.masterfig3,'trace_type');
sleep=getappdata(handles.masterfig3,'sleep');
set(gcf,'Renderer','opengl');
%Pick the threshold for various frequency ranges that are important to sleep classification.

%Delta
if trace_type==1
    n=1;
    
while n<2 
    set(gcf,'CurrentAxes',findobj('Tag','Axis8'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    set(gcf,'CurrentAxes',findobj('Tag','Axis8'));
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end

%Spindle Power
if trace_type==2
    n=2;
    
while n<3 
    set(gcf,'CurrentAxes',findobj('Tag','Axis8bb'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');    
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end


%Alpha Power
if trace_type==3
    n=3;
while n<4 
    set(gcf,'CurrentAxes',findobj('Tag','Axis9'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end

%Theta Power (formerly Ripple)
if trace_type==4
    n=4;
while n<5 
    set(gcf,'CurrentAxes',findobj('Tag','Axis10'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep)
end

%EMG-SWS Power
if trace_type==5
    n=5;
while n<6
    set(gcf,'CurrentAxes',findobj('Tag','Axis11'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep)
end
%EMG-REM
if trace_type==6
    n=6;
while n<7 
    set(gcf,'CurrentAxes',findobj('Tag','Axis11'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end

%EOG
if trace_type==7
    n=7;
while n<8 
    set(gcf,'CurrentAxes',findobj('Tag','Axis12'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'r');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end

%Low Delta
if trace_type==8
    n=8;
while n<9
    set(gcf,'CurrentAxes',findobj('Tag','Axis8'));
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([0 11.5],[sleep_y(n) sleep_y(n)],'g');   
    sleep.cutoffs(n)=sleep_y(n);
    n=n+1;
end
setappdata(handles.masterfig3,'sleep',sleep);
end