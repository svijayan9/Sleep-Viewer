function varargout = Sleep_stats(handles)

% This function plots the overall sleep statistics.

handles.masterfig3=gcbf;
handles.masterfig4=figure;
setappdata(handles.masterfig4,'handlesfig3',handles.masterfig3);
set(handles.masterfig4,'NumberTitle','off','Name', 'Overall Sleep Statistics','Units','normalized','Position',[.006 .006 .985 .924]);

col=[1 0 0;.7 1 .5;0 0 1;1 1 0;1 0 1;1 .8 .1; .5 .5 1; .75 .5 .5];


axes('NextPlot','add','Position',[.05 .93 .85 .04],'Tag','Axis21');
title('EMG Power','Color',[col(7,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(7,:)]);
xlabel('Time (s)','Color',[col(7,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .83 .85 .04],'Tag','Axis31');
title('Delta Power','Color',[col(2,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(2,:)]);
xlabel('Time (s)','Color',[col(2,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .73 .85 .04],'Tag','Axis41');
title('Spindle Power','Color',[col(3,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(3,:)]);
xlabel('Time (s)','Color',[col(3,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .63 .85 .04],'Tag','Axis46');
title('EOG Cov','Color',[col(8,:)],'FontWeight','bold');
ylabel('Cov Sum','FontWeight','bold','Color',[col(8,:)]);
xlabel('Time','Color',[col(8,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .53 .85 .04],'Tag','Axis51');
title('Alpha Power','Color',[col(4,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(4,:)]);
xlabel('Time (s)','Color',[col(4,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .43 .85 .04],'Tag','Axis61');
title('Theta Power','Color',[col(5,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(5,:)]);
xlabel('Time (s)','Color',[col(5,:)],'FontWeight','bold');

axes('NextPlot','add','Position',[.05 .33 .85 .04],'Tag','Axis81');
title('Central (2-6 Hz) Power','Color',[col(6,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(6,:)]);
xlabel('Time (s)','Color',[col(6,:)],'FontWeight','bold');

axes('NextPlot','add','Position',[.05 .23 .85 .04],'Tag','Axis83');
title('EOG Slow','Color',[col(7,:)],'FontWeight','bold');
ylabel('Cov Sum','FontWeight','bold','Color',[col(7,:)]);
xlabel('Time (s)','Color',[col(7,:)],'FontWeight','bold');


axes('NextPlot','add','Position',[.05 .13 .85 .04],'Tag','Axis85');
title('EOG Eye Blink','Color',[col(8,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(8,:)]);
xlabel('Time (s)','Color',[col(8,:)],'FontWeight','bold');

%set(findobj('Tag','Sleep_stats_controls_slider'),'max',length(getappdata(handles.masterfig3,'Neo_deltaP')),'min',1);
sleep=getappdata(handles.masterfig3,'sleep')
sleep_stats.cutoffs=sleep.cutoffs;
setappdata(handles.masterfig4,'sleep_stats',sleep_stats);
Sleep_stats_controls(handles);