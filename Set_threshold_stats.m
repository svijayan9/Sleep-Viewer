function varargout = Set_threshold_stats(handles)
%This function allows the user to set the thresholds for sleep
%classification

handles.masterfig4=gcbf;
trace_type_stats=getappdata(handles.masterfig4,'trace_type_stats');
handles.masterfig3=getappdata(handles.masterfig4,'handlesfig3');
sleep=getappdata(handles.masterfig3,'sleep');
sleep_stats=sleep
bin_size=getappdata(handles.masterfig4,'bin_size');


%Pick the threshold for various frequency ranges that are important to sleep classification.

%Delta

timestamp_axis21=getappdata(handles.masterfig4,'timestamp_axis21');



if trace_type_stats==1
    n=1;
while n<2 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');   
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end

%Spindle Power


if trace_type_stats==2
    n=2;
while n<3 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');   
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end


%Alpha Power




if trace_type_stats==3
    n=3;
while n<4 
    [sleep_x(n),sleep_y(n)] = ginput(1);
     plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end



%Theta Power (Before Ripple)




if trace_type_stats==4
    n=4;
while n<5 
    [sleep_x(n),sleep_y(n)] = ginput(1);
     plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end


%EMG-SWS Power

timestamp_axis21=getappdata(handles.masterfig4,'timestamp_axis21');

if trace_type_stats==5
    n=5;
while n<6 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');        
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end



%EMG-REM Power

if trace_type_stats==6
    n=6;
while n<7 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end


%EOG

if trace_type_stats==7
    n=7;
while n<8 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end

end



%Delta Low

timestamp_axis21=getappdata(handles.masterfig4,'timestamp_axis21');



if trace_type_stats==8
    n=8;
while n<9 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');   
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end

%Central

if trace_type_stats==9
    n=8;
while n<9 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end

end

%EOG Slow

if trace_type_stats==10
    n=9;
while n<10 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end
end
%EOG Eye Blink

if trace_type_stats==11
    n=10;
while n<11 
    [sleep_x(n),sleep_y(n)] = ginput(1);
    plot([min(timestamp_axis21) (max(timestamp_axis21))],[sleep_y(n) sleep_y(n)],'r');      
    sleep_stats.cutoffs(n)=sleep_y(n);
    n=n+1;
end


end
























setappdata(handles.masterfig4,'sleep_stats',sleep_stats);
sleep.cutoffs=sleep_stats.cutoffs;
setappdata(handles.masterfig3,'sleep',sleep);