function varargout = Sleep_stats_controls_slide(handles)
set_cut=1;
handles.masterfig4=gcbf;
handles.masterfig3=getappdata(handles.masterfig4,'handlesfig3');

buffers_to_display=900 %This sets how many buffers to display. (number/2---> total minutes displayed)
col=[1 0 0;.7 1 .5;0 0 1;1 1 0;1 0 1;1 .8 .1; .5 .5 1; .75 .5 .5];

length(getappdata(handles.masterfig3,'Neo_deltaP'))
Stats_slider=ceil((get(findobj('Tag','Sleep_stats_controls_slider'),'Value'))*length(getappdata(handles.masterfig3,'Neo_deltaP')))+1;


%This portion will plot the EMG Power%

power_ind2=Stats_slider;



Neo_deltaP=getappdata(handles.masterfig3,'Neo_deltaP');



if (power_ind2>(length(Neo_deltaP)-(buffers_to_display+1)))
    aa=(length(Neo_deltaP)-(buffers_to_display+1));
    bb=length(Neo_deltaP);
end

if (power_ind2<(length(Neo_deltaP)-(buffers_to_display+1)))
    aa=power_ind2;
    bb=power_ind2+(buffers_to_display-1);
end


%This portion will plot the EMG Power



power_axis1=[];

emgP=getappdata(handles.masterfig3,'emgP');
power_axis1=emgP((aa):(bb));
timestamp_axis21=(((aa-1)*30):30:((bb-1)*30));
set(gcf,'CurrentAxes',findobj('Tag','Axis21'));
emgP_m_m=getappdata(handles.masterfig3,'emgP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'b');
setappdata(handles.masterfig4,'timestamp_axis21',timestamp_axis21+15);
sleep=getappdata(handles.masterfig3,'sleep')

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(emgP_m_m*set_cut) (emgP_m_m*set_cut)],'r');
set(findobj('Tag','Axis21'),'YLim',[0 3.0*emgP_m_m])


if sleep.cutoffs(5)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(5) sleep.cutoffs(5)],'k')
end

if sleep.cutoffs(6)~=0
    hold on
     plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(6) sleep.cutoffs(6)],'b')

end






EMG_thresh_pp=getappdata(handles.masterfig3,'EMG_thresh'); 



%This portion will plot the Delta Power



power_axis1=[];
Neo_deltaP=getappdata(handles.masterfig3,'Neo_deltaP');
power_axis1=Neo_deltaP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis31'));
Neo_deltaP_m_m=getappdata(handles.masterfig3,'Neo_deltaP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'g');


plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_deltaP_m_m*set_cut) (Neo_deltaP_m_m*set_cut)],'r');
set(findobj('Tag','Axis31'),'YLim',[0 0.15*Neo_deltaP_m_m])

if sleep.cutoffs(1)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(1) sleep.cutoffs(1)],'k')
end

if sleep.cutoffs(8)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(8) sleep.cutoffs(8)],'b')
end






%This portion will plot the Spindle Power (axis 41)




power_axis1=[];
Neo_spindleP=getappdata(handles.masterfig3,'Neo_spindleP');
power_axis1=Neo_spindleP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis41'));
Neo_spindleP_m_m=getappdata(handles.masterfig3,'Neo_spindleP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'b');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_spindleP_m_m*set_cut) (Neo_spindleP_m_m*set_cut)],'r');
set(findobj('Tag','Axis41'),'YLim',[0 0.4*Neo_spindleP_m_m])


if sleep.cutoffs(2)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(2) sleep.cutoffs(2)],'k')
end

%This portion will plot the EOG Power (Axis46)


power_axis1=[];
eo_together=getappdata(handles.masterfig3,'eo_together');
power_axis1=eo_together((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis46'));
eo_m_m=getappdata(handles.masterfig3,'eo_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'m');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(eo_m_m*set_cut) (eo_m_m*set_cut)],'r');



if sleep_stats.cutoffs(7)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(7) sleep.cutoffs(7)],'k')
end





%This portion will plot the Alpha Power (Axis51)
power_axis1=[];
Neo_alphaP=getappdata(handles.masterfig3,'Neo_alphaP');
power_axis1=Neo_alphaP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis51'));
Neo_alphaP_m_m=getappdata(handles.masterfig3,'Neo_alphaP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'y');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_alphaP_m_m*set_cut) (Neo_alphaP_m_m*set_cut)],'r');

set(findobj('Tag','Axis51'),'YLim',[0 .4*Neo_alphaP_m_m])

if sleep.cutoffs(3)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(3) sleep.cutoffs(3)],'k')
end


%This portion will plot the Ripple Power (Axis61)

% 
% power_axis1=[];
% rippleP=getappdata(handles.masterfig3,'rippleP');
% power_axis1=rippleP((aa):(bb));
% set(gcf,'CurrentAxes',findobj('Tag','Axis61'));
% rippleP_m_m=getappdata(handles.masterfig3,'rippleP_m_m');
% cla;
% bar(timestamp_axis21+15,power_axis1,'m');
% sleep_stats=getappdata(handles.masterfig4,'sleep_stats');
% 
% plot([min(timestamp_axis21) (max(timestamp_axis21))],[(rippleP_m_m*set_cut) (rippleP_m_m*set_cut)],'r');
% set(findobj('Tag','Axis61'),'YLim',[0 4*rippleP_m_m])




%This portion will plot the Theta Power (Axis61)


power_axis1=[];
Neo_thetaP=getappdata(handles.masterfig3,'Neo_thetaP');
power_axis1=Neo_thetaP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis61'));
Neo_thetaP_m_m=getappdata(handles.masterfig3,'Neo_thetaP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'m');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_thetaP_m_m*set_cut) (Neo_thetaP_m_m*set_cut)],'r');
set(findobj('Tag','Axis61'),'YLim',[0 0.4*Neo_thetaP_m_m])

if sleep.cutoffs(4)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(4) sleep.cutoffs(4)],'k')
end

%This portion will plot the Central Power (Axis81)


power_axis1=[];
Neo_beP=getappdata(handles.masterfig3,'Neo_beP');
power_axis1=Neo_beP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis81'));
Neo_beP_m_m=getappdata(handles.masterfig3,'Neo_beP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'m');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_beP_m_m*set_cut) (Neo_beP_m_m*set_cut)],'r');
set(findobj('Tag','Axis81'),'YLim',[0 0.4*Neo_beP_m_m])

if sleep.cutoffs(8)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(8) sleep.cutoffs(8)],'k')
end

%This portion will plot the EOG-Slow (Axis83)


power_axis1=[];
eo_se_together=getappdata(handles.masterfig3,'eo_se_together');
power_axis1=eo_se_together((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis83'));
eo_se_m_m=getappdata(handles.masterfig3,'eo_se_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'m');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(eo_se_m_m*set_cut) (eo_se_m_m*set_cut)],'r');



if sleep_stats.cutoffs(9)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(9) sleep.cutoffs(9)],'k')
end



%This portion will plot the EOG Eye Blink (Axis85)

power_axis1=[];
Neo_eogr_ebP=getappdata(handles.masterfig3,'Neo_eogr_ebP');
power_axis1=Neo_eogr_ebP((aa):(bb));
set(gcf,'CurrentAxes',findobj('Tag','Axis85'));
Neo_eogr_ebP_m_m=getappdata(handles.masterfig3,'Neo_eogr_ebP_m_m');
cla;
bar(timestamp_axis21+15,power_axis1,'m');
sleep_stats=getappdata(handles.masterfig4,'sleep_stats');

plot([min(timestamp_axis21) (max(timestamp_axis21))],[(Neo_eogr_ebP_m_m*set_cut) (Neo_eogr_ebP_m_m*set_cut)],'r');
set(findobj('Tag','Axis85'),'YLim',[0 .05*Neo_eogr_ebP_m_m])

if sleep.cutoffs(10)~=0
    hold on
    plot([min(timestamp_axis21) (max(timestamp_axis21))], [sleep.cutoffs(10) sleep.cutoffs(10)],'k')
end
