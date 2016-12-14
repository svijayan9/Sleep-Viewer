function varargout = Sleep_Viewer_controls_slide(handles)
set(findobj('Tag','EEG_slider'),'SliderStep',[.00001 .001]);

secs_display=5;
set_cut=1;
set_cuta=.8;
eeg_scale=5;
% Set the value of the EEG viewer slider. The range is going to be
% determined by the number of timestamps in the neocortical EEG file. 

handles.masterfig3=gcbf;
window_size=30*ceil(getappdata(handles.masterfig3,'Neo_srate'));

Neo_timestamp=getappdata(handles.masterfig3,'Neo_timestamp');
buffs_to_display=secs_display*ceil(getappdata(handles.masterfig3,'Neo_srate'));


%This portion reads in the value of the slider. The slider value is used to
%determine the timestamp to use for displaying the data. The program will
%display 30 seconds of data from that timepoint. The slider will also be
%used to display the average power.

EEG_slid=ceil(get(findobj('Tag','EEG_slider'),'Value'))

col=[1 0 0;.7 1 .5;0 0 1;1 1 0;1 0 1;1 .8 .1; .5 .5 1; .75 .5 .5];

%This portion of code will plot the raw Neocortical EEG data

Ndata=getappdata(handles.masterfig3,'Neo_data');

voltage_axis1=Ndata(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis1'));
cla;
a=Neo_timestamp(EEG_slid:(EEG_slid+buffs_to_display));
plot(a,voltage_axis1,'Color',[col(1,:)]);
set(findobj('Tag','Axis1'),'XLim',[min(a) max(a)]);


%This portion of code will plot the raw Neocortical EEG Delta

voltage_axis1=[];

Neo_delta=getappdata(handles.masterfig3,'Neo_delta');

voltage_axis1=Neo_delta(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis2'));

Neo_delta_m_m=getappdata(handles.masterfig3,'Neo_delta_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(2,:)]);

set(findobj('Tag','Axis2'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-Neo_delta_m_m Neo_delta_m_m]);

%This portion will plot the Neocortical Delta Power
power_ind=floor((EEG_slid/window_size));
power_axis1=[];



Neo_deltaP=getappdata(handles.masterfig3,'Neo_deltaP');


if power_ind<6
    aa=1;
    bb=power_ind+5;
end

if power_ind>(length(Neo_deltaP)-6)
    aa=power_ind-5;
    bb=length(Neo_deltaP);
end
if (power_ind>6)& (power_ind<(length(Neo_deltaP)-6))
    aa=power_ind-5;
    bb=power_ind+5;
end




power_axis1=Neo_deltaP(aa:bb);
set(gcf,'CurrentAxes',findobj('Tag','Axis8'));
Neo_deltaP_m_m=getappdata(handles.masterfig3,'Neo_deltaP_m_m');
cla;
bar(power_axis1,'g');
plot([0 11.5],[(Neo_deltaP_m_m*set_cut) (Neo_deltaP_m_m*set_cut)],'r');

sleep=getappdata(handles.masterfig3,'sleep');
if (sleep.cutoffs(1)~=0)
plot([0 11.5],[(sleep.cutoffs(1)*set_cut) (sleep.cutoffs(1)*set_cut)],'k');
end

set(findobj('Tag','Axis8'),'XLim',[.5 11.5])



%This portion of code will plot the Neocortical EEG Spindle

voltage_axis1=[];

Neo_spindle=getappdata(handles.masterfig3,'Neo_spindle');

voltage_axis1=Neo_spindle(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis3'));

Neo_spindle_m_m=getappdata(handles.masterfig3,'Neo_spindle_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(3,:)]);

set(findobj('Tag','Axis3'),'XLim',[min(a) max(a)],'YLim',1.5*eeg_scale*[-Neo_spindle_m_m Neo_spindle_m_m]);
hold on
plot(a,(ones(1,length(a)).*(3*[Neo_spindle_m_m])),'r')

%This portion will plot the Neocortical Spindle Power

power_axis1=[];

Neo_spindleP=getappdata(handles.masterfig3,'Neo_spindleP');










power_axis1=Neo_spindleP((aa):(bb));

set(gcf,'CurrentAxes',findobj('Tag','Axis8bb'));
Neo_spindleP_m_m=getappdata(handles.masterfig3,'Neo_spindleP_m_m');
cla;
bar(power_axis1,'b');
plot([0 11.5],[(Neo_spindleP_m_m*set_cut) (Neo_spindleP_m_m*set_cut)],'r');
set(findobj('Tag','Axis8bb'),'XLim',[.5 11.5])


if (sleep.cutoffs(2)~=0)
plot([0 11.5],[(sleep.cutoffs(2)*set_cut) (sleep.cutoffs(2)*set_cut)],'k');
end

set(findobj('Tag','Axis8'),'XLim',[.5 11.5])


%This portion of code will plot the Central 2-6
voltage_axis1=[];

Neo_be=getappdata(handles.masterfig3,'Neo_be');

voltage_axis1=Neo_be(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis3a'));

Neo_be_m_m=getappdata(handles.masterfig3,'Neo_be_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(3,:)]);

set(findobj('Tag','Axis3a'),'XLim',[min(a) max(a)],'YLim',1.5*eeg_scale*[-Neo_be_m_m Neo_be_m_m]);
hold on
plot(a,(ones(1,length(a)).*(3*[Neo_be_m_m])),'r')





%This portion of code will plot the raw Neocortical Alpha EEG data

voltage_axis1=[];
Adata=getappdata(handles.masterfig3,'Adata');
voltage_axis1=Adata(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis4'));
cla;
plot(a,voltage_axis1,'Color',[col(4,:)]);
set(findobj('Tag','Axis4'),'XLim',[min(a) max(a)],'YLim',.8*[min(voltage_axis1) max(voltage_axis1)]);


%This portion of code will plot the Neocortical EEG Alpha

voltage_axis1=[];
Neo_alpha=getappdata(handles.masterfig3,'Neo_alpha');

voltage_axis1=Neo_alpha(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis5'));

Neo_alpha_m_m=getappdata(handles.masterfig3,'Neo_alpha_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(4,:)]);

set(findobj('Tag','Axis5'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-Neo_alpha_m_m Neo_alpha_m_m]);
%set(findobj('Tag','Axis4'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-100 100]);




%This portion will plot the Neocortical Alpha Power

power_axis1=[];

Neo_alphaP=getappdata(handles.masterfig3,'Neo_alphaP');
power_axis1=Neo_alphaP((aa):(bb));

set(gcf,'CurrentAxes',findobj('Tag','Axis9'));
Neo_alphaP_m_m=getappdata(handles.masterfig3,'Neo_alphaP_m_m');
cla;
bar(power_axis1,'y');
plot([0 11.5],[(Neo_alphaP_m_m*set_cut) (Neo_alphaP_m_m*set_cut)],'r');
set(findobj('Tag','Axis9'),'XLim',[.5 11.5])

if (sleep.cutoffs(3)~=0)
plot([0 11.5],[(sleep.cutoffs(3)*set_cut) (sleep.cutoffs(3)*set_cut)],'k');
end






%This portion of code will plot the theta filtered EEG

voltage_axis1=[];
Neo_theta=getappdata(handles.masterfig3,'Neo_theta');

voltage_axis1=Neo_theta(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis6'));

Neo_theta_m_m=getappdata(handles.masterfig3,'Neo_theta_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(5,:)]);

set(findobj('Tag','Axis6'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-Neo_theta_m_m Neo_theta_m_m]);





%This portion of code will plot the raw Ripple EEG data
% 
% voltage_axis1=[];
% Rdata=getappdata(handles.masterfig3,'Rdata');
% voltage_axis1=Rdata(EEG_slid:(EEG_slid+buffs_to_display));
% set(gcf,'CurrentAxes',findobj('Tag','Axis5'));
% cla;
% plot(a,voltage_axis1,'Color',[col(5,:)]);
% set(findobj('Tag','Axis5'),'XLim',[min(a) max(a)]);


%This portion of code will plot the Ripple EEG 
% 
% voltage_axis1=[];
% ripple=getappdata(handles.masterfig3,'ripple');
% 
% voltage_axis1=ripple(EEG_slid:(EEG_slid+buffs_to_display));
% set(gcf,'CurrentAxes',findobj('Tag','Axis6'));
% 
% ripple_m_m=getappdata(handles.masterfig3,'ripple_m_m');
% cla;
% plot(a,voltage_axis1,'Color',[col(5,:)]);
% 
% set(findobj('Tag','Axis6'),'XLim',[min(a) max(a)],'YLim',1.5*eeg_scale*[-ripple_m_m ripple_m_m]);
% 
% % 
% %This portion will plot the Ripple Power
% 
% power_axis1=[];
% 
% rippleP=getappdata(handles.masterfig3,'rippleP');
% power_axis1=rippleP((aa):(bb));
% 
% set(gcf,'CurrentAxes',findobj('Tag','Axis10'));
% rippleP_m_m=getappdata(handles.masterfig3,'rippleP_m_m');
% cla;
% bar(power_axis1,'m');
% plot([0 11.5],[(rippleP_m_m*set_cut) (rippleP_m_m*set_cut)],'r');
% set(findobj('Tag','Axis10'),'XLim',[.5 11.5])
% 
% if (sleep.cutoffs(4)~=0)
% plot([0 11.5],[(sleep.cutoffs(4)*set_cut) (sleep.cutoffs(4)*set_cut)],'k');
% end


%This portion will plot the Theta Power

power_axis1=[];

Neo_thetaP=getappdata(handles.masterfig3,'Neo_thetaP');
power_axis1=Neo_thetaP((aa):(bb));

set(gcf,'CurrentAxes',findobj('Tag','Axis10'));
Neo_thetaP_m_m=getappdata(handles.masterfig3,'Neo_thetaP_m_m');
cla;
bar(power_axis1,'m');
plot([0 11.5],[(Neo_thetaP_m_m*set_cut) (Neo_thetaP_m_m*set_cut)],'r');
set(findobj('Tag','Axis10'),'XLim',[.5 11.5])

if (sleep.cutoffs(4)~=0)
plot([0 11.5],[(sleep.cutoffs(4)*set_cut) (sleep.cutoffs(4)*set_cut)],'k');
end








%This portion of code will plot the EMG data

voltage_axis1=[];
emg=getappdata(handles.masterfig3,'emg');
voltage_axis1=emg(EEG_slid:(EEG_slid+buffs_to_display));
set(gcf,'CurrentAxes',findobj('Tag','Axis7'));
emg_m_m=getappdata(handles.masterfig3,'emg_m_m');
cla;
plot(a,voltage_axis1,'Color',[col(7,:)]);
set(findobj('Tag','Axis7'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-emg_m_m emg_m_m]);
%set(findobj('Tag','Axis7'),'XLim',[min(a) max(a)],'YLim',[-80 80]);





%This portion will plot the EMG Power

power_axis1=[];

emgP=getappdata(handles.masterfig3,'emgP');
power_axis1=emgP((aa):(bb));

set(gcf,'CurrentAxes',findobj('Tag','Axis11'));
emgP_m_m=getappdata(handles.masterfig3,'emgP_m_m');
cla;
bar(power_axis1,'b');
plot([0 11.5],[(emgP_m_m*set_cut) (emgP_m_m*set_cut)],'r');
set(findobj('Tag','Axis10'),'XLim',[.5 11.5])
if (sleep.cutoffs(5)~=0)
plot([0 11.5],[(sleep.cutoffs(5)*set_cut) (sleep.cutoffs(5)*set_cut)],'k');
end
if (sleep.cutoffs(6)~=0)
plot([0 11.5],[(sleep.cutoffs(6)*set_cut) (sleep.cutoffs(6)*set_cut)],'b');
end




%This portion of code will plot the EOG data

voltage_axis1=[];
voltage_axis2=[];
eogl=getappdata(handles.masterfig3,'eogl');
eogr=getappdata(handles.masterfig3,'eogr');

voltage_axis1=eogl(EEG_slid:(EEG_slid+buffs_to_display));
voltage_axis2=eogr(EEG_slid:(EEG_slid+buffs_to_display));


set(gcf,'CurrentAxes',findobj('Tag','Axis7a'));
eogl_m_m=getappdata(handles.masterfig3,'eogl_m_m');
eogr_m_m=getappdata(handles.masterfig3,'eogr_m_m');
eogg=max(eogl_m_m,eogr_m_m);
cla;
plot(a,voltage_axis1,'r');
hold on
plot(a,voltage_axis2,'g');
%set(findobj('Tag','Axis7a'),'XLim',[min(a) max(a)],'YLim',eeg_scale*[-eogg eogg]);
set(findobj('Tag','Axis7a'),'XLim',[min(a) max(a)],'YLim',[-550 250]);

%This portion will plot the EOG Power

power_axis1=[];

eo_together=getappdata(handles.masterfig3,'eo_together');
power_axis1=1*(eo_together((aa):(bb)));

set(gcf,'CurrentAxes',findobj('Tag','Axis12'));
eo_m_m=getappdata(handles.masterfig3,'eo_m_m');
cla;
bar(power_axis1,'m');
plot([0 11.5],[(eo_m_m*set_cut) (eo_m_m*set_cut)],'r');
set(findobj('Tag','Axis10'),'XLim',[.5 11.5])

if (sleep.cutoffs(7)~=0)
plot([0 11.5],[(sleep.cutoffs(7)*set_cut) (sleep.cutoffs(7)*set_cut)],'k');
end


sleep=getappdata(handles.masterfig3,'sleep');
  %Displays Sleep classification
 
if ~isempty(sleep.class)
     
   sleep_state_names={'N1'; 'N2';'N3';'REM';'AWAKE';'Sleep,Unknown'};
   set(findobj('Tag','Sleep_class_return'),'string',sleep_state_names(sleep.class(power_ind)));
  
   
end
     




