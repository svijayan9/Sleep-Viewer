function varargout = Save_Sleep_Class(handles)

[FileName,PathName,FilterIndex] = uiputfile('*_sc','Save sleep classification files with the prefix?')

if FilterIndex==0
    errordlg('You did not specify a prefix for the sleep classification files.','Bad Input','modal')
    return
end




%%% To write sleep catgorizations to a file%%%%%%%
handles.masterfig3=gcbf;
sleep=getappdata(handles.masterfig3,'sleep');
state.cutoffs=sleep.cutoffs;
state.class=sleep.class;
time_epochs=length(getappdata(handles.masterfig3,'Neo_deltaP'));
timestamp=(0:30:(30*(time_epochs-1)));
state.timestamp=timestamp;
% %%%%%%%%%Awake State%%%%%%%%%%%%%%%%
% awake_index=[1];
% j=1;
% 
% while ~(isempty(find((sleep.class(awake_index(j):end))==1,1)))&(awake_index(j)~=length(sleep.class));
% awake=find((sleep.class(awake_index(j):end))==1,1);
% j=j+1;
%     if length(awake_index)~=1;
%         awake_index(j)=awake+awake_index(j-1)-1;
%     else
%         awake_index(j)=awake;
%     end
% awake=find(sleep.class(awake_index(j):end)~=1,1);
%     if ~(isempty(awake))& ((j>2)|(awake_index(j)>1));
%         j=j+1;
%         awake_index(j)=awake+awake_index(j-1)-1;
%     elseif ~(isempty(awake))& (j<=2);
%         j=j+1;
%         awake_index(j)=awake;
%     else
%         j=j+1;
%         awake_index(j)=length(sleep.class);
%     end
% end
% 
% awake_index=awake_index(2:end-2);
% 
% awake_times=(Hipp_timestamp.timestamp(awake_index)+Neo_timestamp.timestamp(awake_index)+EMG_timestamp.timestamp(awake_index))/3;
% awake_times=reshape(awake_times,2,(length(awake_times)/2))';
% if awake_index(end)==length(Hipp_timestamp.timestamp);
%     awake_times(2,end)=awake_times(2,end)+one_buffer_time;
% end
% 
% %%%%%%%%%%%%%%%%%%%SWS Categorization%%%%%%%%%%%%%%%%%%%%
% 
% 
% SWS_index=[1];
% j=1;
% 
% while ~(isempty(find((sleep.class(SWS_index(j):end))==5,1)))&(SWS_index(j)~=length(sleep.class));
% SWS=find((sleep.class(SWS_index(j):end))==5,1);
% j=j+1;
%     if length(SWS_index)~=1;
%         SWS_index(j)=SWS+SWS_index(j-1)-1;
%     else
%         SWS_index(j)=SWS;
%     end
% SWS=find(sleep.class(SWS_index(j):end)~=5,1);
%     if ~(isempty(SWS))& ((j>2)|(SWS_index(j)>1));
%         j=j+1;
%         SWS_index(j)=SWS+SWS_index(j-1)-1;
%     elseif ~(isempty(SWS))& (j<=2);
%         j=j+1;
%         SWS_index(j)=SWS;
%     else
%         j=j+1;
%         SWS_index(j)=length(sleep.class);
%     end
% end
% 
% SWS_index=SWS_index(2:end);
% SWS_times=(Hipp_timestamp.timestamp(SWS_index)+Neo_timestamp.timestamp(SWS_index)+EMG_timestamp.timestamp(SWS_index))/3;
% SWS_times=reshape(SWS_times,2,(length(SWS_times)/2))';
% 
% if SWS_index(end)==length(Hipp_timestamp.timestamp);
%     SWS_times(2,end)=SWS_times(2,end)+one_buffer_time;
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%REM%%%%%%%%%%%%%%%%%%%%%%%%
% 
% REM_index=[1];
% j=1;
% 
% while ~(isempty(find((sleep.class(REM_index(j):end))==9,1)))&(REM_index(j)~=length(sleep.class))
% REM=find((sleep.class(REM_index(j):end))==9,1);
% j=j+1;
%     if length(REM_index)~=1
%         REM_index(j)=REM+REM_index(j-1)-1;
%     else
%         REM_index(j)=REM;
%     end
% REM=find(sleep.class(REM_index(j):end)~=9,1);
%     if ~(isempty(REM))& ((j>2)|(REM_index(j)>1))
%         j=j+1;
%         REM_index(j)=REM+REM_index(j-1)-1;
%     elseif ~(isempty(REM))& (j<=2)
%         j=j+1;
%         REM_index(j)=REM;
%     else
%         j=j+1;
%         REM_index(j)=length(sleep.class);
%     end
% end
% 
% REM_index=REM_index(2:end);
% REM_times=(Hipp_timestamp.timestamp(REM_index)+Neo_timestamp.timestamp(REM_index)+EMG_timestamp.timestamp(REM_index))/3;
% REM_times=reshape(REM_times,2,(length(REM_times)/2))';
% 
% if REM_index(end)==length(Hipp_timestamp.timestamp)
%     REM_times(2,end)=REM_times(2,end)+one_buffer_time;
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%Transitory%%%%%%%%%%%%%%%%%%%
% 
% 
% TRANS_index=[1];
% j=1;
% 
% while ~(isempty(find((sleep.class(TRANS_index(j):end))==3,1)))&(TRANS_index(j)~=length(sleep.class))
% TRANS=find((sleep.class(TRANS_index(j):end))==3,1);
% j=j+1;
%     if length(TRANS_index)~=1
%         TRANS_index(j)=TRANS+TRANS_index(j-1)-1;
%     else
%         TRANS_index(j)=TRANS;
%     end
% TRANS=find(sleep.class(TRANS_index(j):end)~=3,1);
%     if ~(isempty(TRANS))& ((j>2)|(TRANS_index(j)>1))
%         j=j+1;
%         TRANS_index(j)=TRANS+TRANS_index(j-1)-1;
%     elseif ~(isempty(TRANS))& (j<=2)
%         j=j+1;
%         TRANS_index(j)=TRANS;
%     else
%         j=j+1;
%         TRANS_index(j)=length(sleep.class);
%     end
% end
% 
% TRANS_index=TRANS_index(2:end-2);
% TRANS_times=(Hipp_timestamp.timestamp(TRANS_index)+Neo_timestamp.timestamp(TRANS_index)+EMG_timestamp.timestamp(TRANS_index))/3;
% TRANS_times=reshape(TRANS_times,2,(length(TRANS_times)/2))';
% 
% if TRANS_index(end)==length(Hipp_timestamp.timestamp)
%     TRANS_times(2,end)=TRANS_times(2,end)+one_buffer_time;
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state.(d).SWS_times=SWS_times;
% state.(d).REM_times=REM_times;
% state.(d).TRANS_times=TRANS_times;
% state.(d).awake_times=awake_times;
% state.(d).all=sleep;
save([FileName '_Sleep'],'state');