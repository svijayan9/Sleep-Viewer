function varargout = ECOG_Viewer(varargin)

% This is code for viewing Sleep and general EEG data. This file sets up the figure 
handles.masterfig3=figure;
set(handles.masterfig3,'NumberTitle','off', 'Name','Sleep Viewer','Units','normalized','Position',[.006 .006 .985 .924]);
col=[1 0 0;.7 1 .5;0 0 1;1 1 0;1 0 1;1 .8 .1; .5 .5 1; .75 .5 .5];

axes('NextPlot','add','Position',[.04 .89 .7 .07],'Tag','Axis1');
title('Neocortical Lead','Color',[col(1,:)],'FontWeight','bold');

xlabel('Delta (.5-2)','Color',[col(2,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .79 .7 .06],'Tag','Axis2');

xlabel('Spindle (12-16 Hz)','Color',[col(3,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .69 .7 .06],'Tag','Axis3');

xlabel('Central 2-6 Hz','Color',[col(3,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .58 .7 .07],'Tag','Axis3a');


xlabel('Ocippital Lead','Color',[col(4,:)],'FontWeight','bold')

axes('NextPlot','add','Position',[.04 .48 .7 .06],'Tag','Axis4');
ylabel('Voltage','FontWeight','bold')

xlabel('Alpha (8-12 Hz)','Color',[col(4,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .37 .7 .06],'Tag','Axis5');

xlabel('Theta (4-7 Hz)','Color',[col(5,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .27 .7 .06],'Tag','Axis6');

xlabel('EMG','Color',[col(7,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .17 .7 .06],'Tag','Axis7');

xlabel('EOG','Color',[col(8,:)],'FontWeight','bold')
axes('NextPlot','add','Position',[.04 .07 .7 .06],'Tag','Axis7a');


xlabel('Time (s)','FontWeight','bold')
axes('NextPlot','add','Position',[.79 .89 .2 .09],'Tag','Axis8');
title('Delta Power','Color',[col(2,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(2,:)])

axes('NextPlot','add','Position',[.79 .76 .2 .09],'Tag','Axis8bb');
title('Spindle Power','Color',[col(3,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(3,:)])


axes('NextPlot','add','Position',[.79 .63 .2 .09],'Tag','Axis9');
title('Alpha Power','Color',[col(4,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(4,:)])

axes('NextPlot','add','Position',[.79 .50 .2 .09],'Tag','Axis10');
title('Theta Power','Color',[col(5,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(5,:)])

axes('NextPlot','add','Position',[.79 .37 .2 .09],'Tag','Axis11');
title('EMG Power','Color',[col(7,:)],'FontWeight','bold');
ylabel('Power','FontWeight','bold','Color',[col(7,:)])

axes('NextPlot','add','Position',[.79 .24 .2 .09],'Tag','Axis12');
title('EOG COV','Color',[col(8,:)],'FontWeight','bold');
ylabel('Cov','FontWeight','bold','Color',[col(8,:)])
xlabel('Time (s)','Color',[col(8,:)],'FontWeight','bold')


sleep.cutoffs=[0 0 0 0 0 0 0 0 0 0 0];
sleep.class=[];
setappdata(handles.masterfig3,'sleep',sleep);
Sleep_Viewer_controls(handles);
Sleep_Viewer_menu(handles);