function varargout = Plot_classification(handles)

handles.masterfig3=gcbf;
handles.masterfig5=figure;
sleep=getappdata(handles.masterfig3,'sleep')
time_epochs=length(getappdata(handles.masterfig3,'Neo_deltaP'));
timestamp=(0:30:(30*(time_epochs-1)));
col=[1 0 0;.7 1 .5;0 0 1;1 1 0;1 0 1;1 .8 .1; .5 .5 1; .75 .5 .5];

set(handles.masterfig5,'NumberTitle','off','Name', 'Sleep Classification','Units','normalized','Position',[.006 .006 .985 .924]);
min(timestamp)
max(timestamp)
%axes('NextPlot','add','Position',[.06 .13 .89 .75],'Tag','Axis210','XLim',[min(timestamp) max(timestamp)],'YTickLabel',{'';'N1';'N2';'N3';'REM';'Awake';'None';''});

axes('NextPlot','add','Position',[.06 .13 .89 .75],'Tag','Axis210','XLim',[min(timestamp) max(timestamp)],'YTick',[0 1 2 3 4 5 6],'YTickLabel',{'';'N1';'N2';'N3';'REM';'Awake';''});


title('Sleep Classification','Color',[col(3,:)],'FontWeight','bold');
ylabel('Sleep Stage','FontWeight','bold','Color',[col(3,:)]);
xlabel('Time (s)','Color',[col(3,:)],'FontWeight','bold');



bar(timestamp(1:(min([length(timestamp) length(sleep.class)]))),sleep.class(1:(min([length(timestamp) length(sleep.class)]))));

h = findobj(gca,'Type','patch');
set(h,'FaceColor',[col(2,:)]);