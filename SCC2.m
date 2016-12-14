function varargout = SCC2(handles)

handles.masterfig3=gcbf;
sleep=getappdata(handles.masterfig3,'sleep');
emgP_m_m=getappdata(handles.masterfig3,'emgP_m_m'); 
Neo_deltaP_m_m=getappdata(handles.masterfig3,'Neo_deltaP_m_m'); 
Neo_spindleP_m_m=getappdata(handles.masterfig3,'Neo_spindleP_m_m'); 
rippleP_m_m=getappdata(handles.masterfig3,'rippleP_m_m'); 
Neo_alphaP_m_m=getappdata(handles.masterfig3,'Neo_alphaP_m_m'); 
eo_m_m=getappdata(handles.masterfig3,'eo_m_m');
Neo_be_m_m=getappdata(handles.masterfig3,'Neo_be_m_m');
eo_se_m_m=getappdata(handles.masterfig3,'eo_se_m_m');
Neo_eogr_ebP_m_m=getappdata(handles.masterfig3,'Neo_eogr_ebP_m_m');
Neo_thetaP_m_m=getappdata(handles.masterfig3,'Neo_thetaP_m_m');

very_low_emg_thresh=1;
percent_of_average=1.5;
percent_of_averagea=1.5;
percent_of_averageab=1;
pcos=.5;
sleep.class=[];


%Gives a threshold value to all the power bands used for sleep
%classification. If a threshold value was not selected, a percentage of the the average power in
%the band is selected.Sleep.cutoffs ar the threshold values set by the user
% in examining the power in a given sleep band. The average threshold is in
% "band"."band"_threshold

%Neocortical Delta Power

if sleep.cutoffs(1)~=0
Neo_D_Power=sleep.cutoffs(1);
else
Neo_D_Power=Neo_deltaP_m_m*percent_of_average;    
end


%Neocortical Spindle Power

if sleep.cutoffs(2)~=0
Neo_S_Power=sleep.cutoffs(2);
else
Neo_S_Power=Neo_spindleP_m_m*percent_of_average;    
end


%Alpha Power

if sleep.cutoffs(3)~=0
T_A_Power=sleep.cutoffs(3);
else
T_A_Power=Neo_alphaP_m_m*percent_of_average;    
end


%Theta power 

if sleep.cutoffs(4)~=0
TH_Power=sleep.cutoffs(4);
else
TH_Power=Neo_thetaP_m_m*percent_of_average;    
end

%EMG-SWSpower

if sleep.cutoffs(5)~=0
EMG_Power_SWS=sleep.cutoffs(5);
else
EMG_Power_SWS=(emgP_m_m)*percent_of_averagea;      
end

%EMG-REMpower

if sleep.cutoffs(6)~=0
EMG_Power_REM=sleep.cutoffs(6);
else
EMG_Power_REM=(emgP_m_m)*percent_of_averageab;      
end

%EOG power

if sleep.cutoffs(7)~=0
EOG_Power=sleep.cutoffs(7);
else
EOG_Power=(eo_m_m)*pcos;      
end

%Neocortical Delta Power Low

if sleep.cutoffs(8)~=0
Neo_D_Power_b=sleep.cutoffs(8);
else
Neo_D_Power_b=Neo_deltaP_m_m*percent_of_average*.8;    
end


%Centralpower

if sleep.cutoffs(9)~=0
Central_Power=sleep.cutoffs(9);
else
Central_Power=(Neo_be_m_m)*pcos;      
end


%EOG Slow

if sleep.cutoffs(10)~=0
EOGSlow_Power=sleep.cutoffs(10);
else
EOGSlow_Power=(eo_se_m_m)*pcos;      
end

%EOG Eye Blink Power

if sleep.cutoffs(11)~=0
EOGBlink_Power=sleep.cutoffs(11);
else
EOGBlink_Power=(Neo_eogr_ebP_m_m)*pcos;      
end















%Classification made if there is an EMG electrode. 

 %Reads in Delta power data%
Neo_deltaP=getappdata(handles.masterfig3,'Neo_deltaP'); 

 %Now makes binary decision as to whether Delta power crosses threshold or not.
voltage_axis_delta=zeros(1,length(Neo_deltaP));
a=find((Neo_deltaP)>=Neo_D_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_deltaP)<Neo_D_Power);;%Finds voltages less than threshold.
voltage_axis_delta(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_delta(b)=0;%Sets voltages less than threshold to zero

%Now makes binary decision as to whether lower Delta power crosses threshold or not.
voltage_axis_delta_b=zeros(1,length(Neo_deltaP));
a=find((Neo_deltaP)>=Neo_D_Power_b); %Find voltages greater than or equal to threshold.
b=find((Neo_deltaP)<Neo_D_Power_b);;%Finds voltages less than threshold.
voltage_axis_delta_b(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_delta_b(b)=0;%Sets voltages less than threshold to zero


%Reads in spindle power data%
Neo_spindleP=getappdata(handles.masterfig3,'Neo_spindleP'); 

 %Now makes binary decision as to whether spindle power crosses threshold or not.
voltage_axis_spindle=zeros(1,length(Neo_deltaP));
a=find((Neo_spindleP)>=Neo_S_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_spindleP)<Neo_S_Power);;%Finds voltages less than threshold.
voltage_axis_spindle(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_spindle(b)=0;%Sets voltages less than threshold to zero



%Reads in alpha power data%
Neo_alphaP=getappdata(handles.masterfig3,'Neo_alphaP'); 

 %Now makes binary decision as to whether alpha power crosses threshold or not.
voltage_axis_alpha=zeros(1,length(Neo_deltaP));
a=find((Neo_alphaP)>=T_A_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_alphaP)<T_A_Power);;%Finds voltages less than threshold.
voltage_axis_alpha(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_alpha(b)=0;%Sets voltages less than threshold to zero



%  %Reads in ripple power data%
%  rippleP=getappdata(handles.masterfig3,'rippleP'); 
% 
%  %Now makes binary decision as to whether ripple power crosses threshold or not.
% voltage_axis_ripp=zeros(1,length(Neo_deltaP));
% a=find((rippleP)>=R_Power); %Find voltages greater than or equal to threshold.
% b=find((rippleP)<R_Power);;%Finds voltages less than threshold.
% voltage_axis_ripp(a)=1;%Sets voltages greater than or equal to threshold at one.
% voltage_axis_ripp(b)=0;%Sets voltages less than threshold to zero


 %Reads in ripple power data%
 Neo_thetaP=getappdata(handles.masterfig3,'Neo_thetaP'); 

 %Now makes binary decision as to whether ripple power crosses threshold or not.
voltage_axis_theta=zeros(1,length(Neo_deltaP));
a=find((Neo_thetaP)>=TH_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_thetaP)<TH_Power);;%Finds voltages less than threshold.
voltage_axis_theta(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_theta(b)=0;%Sets voltages less than threshold to zero





 %Reads in emg SWS power data%
 emgP=getappdata(handles.masterfig3,'emgP'); 

 %Now makes binary decision as to whether emg SWS power crosses threshold or not.
voltage_axis_SWS=zeros(1,length(Neo_deltaP));
a=find((emgP)>=EMG_Power_SWS); %Find voltages greater than or equal to threshold.
b=find((emgP)<EMG_Power_SWS);;%Finds voltages less than threshold.
voltage_axis_SWS(b)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_SWS(a)=0;%Sets voltages less than threshold to zero




%Reads in emg REM power data%
 

 %Now makes binary decision as to whether emg REM power crosses threshold or not.
voltage_axis_REM=zeros(1,length(Neo_deltaP));
a=find((emgP)>=EMG_Power_REM); %Find voltages greater than or equal to threshold.
b=find((emgP)<EMG_Power_REM);;%Finds voltages less than threshold.
voltage_axis_REM(b)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_REM(a)=0;%Sets voltages less than threshold to zero

%Reads in EOG data%
eo_together=getappdata(handles.masterfig3,'eo_together'); 

 %Now makes binary decision as to whether eog cov crosses threshold or not.
voltage_axis_eog=zeros(1,length(eo_together));
a=find((eo_together)>=EOG_Power); %Find voltages greater than or equal to threshold.
b=find((eo_together)<EOG_Power);;%Finds voltages less than threshold.
voltage_axis_eog(b)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_eog(a)=0;%Sets voltages less than threshold to zero


%Reads in Central power data%
Neo_beP=getappdata(handles.masterfig3,'Neo_beP'); 
% Now make decision about Centralpower


%Now makes binary decision as to whether Central power crosses threshold or not.
voltage_axis_Central=zeros(1,length(Neo_deltaP));
a=find((Neo_beP)>=Central_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_beP)<Central_Power);;%Finds voltages less than threshold.
voltage_axis_Central(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_Central(b)=0;%Sets voltages less than threshold to zero





%Reads in Eye blink power data%

Neo_eogr_ebP=getappdata(handles.masterfig3,'Neo_eogr_ebP');
%Now makes binary decision as to whether Eyeblink power crosses threshold or not.
voltage_axis_Eyeblink=zeros(1,length(Neo_deltaP));
a=find((Neo_eogr_ebP)>=EOGBlink_Power); %Find voltages greater than or equal to threshold.
b=find((Neo_eogr_ebP)<EOGBlink_Power);;%Finds voltages less than threshold.
voltage_axis_Eyeblink(a)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_Eyeblink(b)=0;%Sets voltages less than threshold to zero


%Reads in EOG data%
eo_se_together=getappdata(handles.masterfig3,'eo_se_together'); 

 %Now makes binary decision as to whether eog cov crosses threshold or not.
voltage_axis_eo_se=zeros(1,length(eo_se_together));
a=find((eo_se_together)>=EOGSlow_Power); %Find voltages greater than or equal to threshold.
b=find((eo_se_together)<EOGSlow_Power);;%Finds voltages less than threshold.
voltage_axis_eo_se(b)=1;%Sets voltages greater than or equal to threshold at one.
voltage_axis_eo_se(a)=0;%Sets voltages less than threshold to zero













%EMG=voltage_axis_REM,voltage_axis_SWS
%Alpha=voltage_axis_alpha
%Theta=voltage_axis_theta
%Delta=voltage_axis_delta
%Spindle=voltage_axis_spindle
%EOG=voltage_axis_eog
%EYE_slow=voltage_axis_eo_se
%EYE_blink=voltage_axis_Eyeblink
%Central=voltage_axis_Central
sleep.class=6*ones(1,length(Neo_deltaP));



%Stage N1
%Stage N2
%Stage N3
%Awake
%Stage REM
%N1=1
%N2=2
%N3=3
%REM=4
%Awake=5

%Awake

sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==1)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=5;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==1)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=5;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=5;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=5;



%N1
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=1;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=1;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=1;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=1;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=1;
%add eog here (?) 
% slow eye movemnets

%N2
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=2;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==0)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=2;

% K complex

%N3
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=3;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=3;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==0)))=3;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=3;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=3;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==0)))=3;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=3;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=3;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==1)&(voltage_axis_theta==1)))=3;
%sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==0)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=3;
sleep.class(find((voltage_axis_REM==0)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=3;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==1)&(voltage_axis_delta==1)&(voltage_axis_spindle==0)&(voltage_axis_theta==1)))=3;


%REM + Alpha(?)


sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_eog==1)))=4;
sleep.class(find((voltage_axis_REM==1)&(voltage_axis_SWS==1)&(voltage_axis_alpha==0)&(voltage_axis_delta_b==0)&(voltage_axis_delta==0)&(voltage_axis_spindle==0)&(voltage_axis_eog==1)))=4;

%Absolute
sleep.class(find(voltage_axis_Eyeblink==1))=5



%Rule 1 Scoring W Keeping when N1 intervenes

W_events=find(sleep.class==5); 
for i=1:(length(W_events)-1)
    if (sleep.class((W_events(i)+1):(W_events(i+1)-1))==1) & ((W_events(i+1)-W_events(i))<=11)
        sleep.class((W_events(i)+1):(W_events(i+1)-1))=5;
    end
end
%Rule 1a Scoring W Keeping when N1 intervenes

W_events=find(sleep.class==5); 
for i=1:(length(W_events)-1)
    if (sleep.class((W_events(i)+1):(W_events(i+1)-1))==6) & ((W_events(i+1)-W_events(i))<=11)
        sleep.class((W_events(i)+1):(W_events(i+1)-1))=5;
    end
end

%Rule 2 W scoring with transition later

for i=1:(length(sleep.class)-3)
    
    if (sleep.class(i)==5) & (sleep.class(i+1)==5)&(sleep.class(i+2)~=5)
        
        if (i+2)<=(length(sleep.class)-6)&(sum((sleep.class(i+3:i+8)==5)>=3))
            sleep.class(i+2)=5;
        end
        if (i+2)>(length(sleep.class)-6)&(sum((sleep.class(i+3:end)==5)>=3))
            sleep.class(i+2)=5;
        end
        
    end
end
        

%Rule 3 (checked)



for i=1:(length(sleep.class)-3)
    
    if (sleep.class(i)==4) & (sleep.class(i+1)==4)&(sleep.class(i+2)~=4)
        
        if (i+2)<=(length(sleep.class)-21)&((sum(sleep.class(i+3:i+22)==4))>=3)
            sleep.class(i+2)=4;
        end
        if (i+2)>(length(sleep.class)-21)&((sum(sleep.class(i+3:end)==4))>=3)
            sleep.class(i+2)=4;
        end
        
    end
end


%Rule 4 
% 
% R_events=find(sleep.class==4);
% for i=1:(length(R_events)-1)
%     if (sleep.class((R_events(i)+1):(R_events(i+1)-1))==1) & ((R_events(i+1)-R_events(i))<=21) & (sleep.class((R_events(i)-2):(R_events(i)-1))==4) & (sleep.class(R_events(i+1))==4) &(R_events(i)>2)
%          sleep.class((R_events(i)+1):(R_events(i+1)-1))=4;
%     end
% end




%Rule 5

for i=1:(length(sleep.class)-3)
    
    if (sleep.class(i)==2) & (sleep.class(i+1)==2)&(sleep.class(i+2)==3)
        
        if (i+2)<=(length(sleep.class)-6)&((sum(sleep.class(i+3:i+8)==2))>=2)
            sleep.class(i+2)=2;
        end
        if (i+2)>(length(sleep.class)-6)&((sum(sleep.class(i+3:end)==2))>=2)
            sleep.class(i+2)=2;
        end
        
    end
end


%Rule 6

for i=1:(length(sleep.class)-3)
    
    if (sleep.class(i)==2) & (sleep.class(i+1)==2)&(sleep.class(i+2)==1)
        
        if (i+2)<=(length(sleep.class)-4)&((sum(sleep.class(i+3:i+6)==2))>=3)
            sleep.class(i+2)=2;
        end
        if (i+2)>(length(sleep.class)-4)&((sum(sleep.class(i+3:end)==2))>=3)
            sleep.class(i+2)=2;
        end
        
    end
end




%Rule 7 


R_events=find(sleep.class==2); 
for i=1:(length(R_events)-1)
    if (mean(sleep.class((R_events(i)+1):(R_events(i+1)-1))==5)==1) & ((R_events(i+1)-R_events(i))<=31) & (mean(sleep.class((R_events(i)+1):(R_events(i)+3))==2)==1) & (sleep.class(R_events(i-1))==2) &(R_events(i)>1)
         sleep.class((R_events(i)+1):(R_events(i+1)-1))=2;
         
    end
end



%Rule 8

for i=3:(length(sleep.class)-2)
    
    if ((sleep.class(i)==2) & (sleep.class(i+1)==3)&(sleep.class(i+2)==3) & (sleep.class(i-1)==3)&(sleep.class(i-2)==3))|((sleep.class(i)==2) & (sleep.class(i+1)==6)&(sleep.class(i+2)==6) & (sleep.class(i-1)==6)&(sleep.class(i-2)==6))
        
       sleep.class(i)=3;
       
    end
end

%Rule 9

R_events=find(sleep.class==3); 
for i=1:(length(R_events)-1)
    if (mean(sleep.class((R_events(i)+1):(R_events(i+1)-1))==5)==1) & ((R_events(i+1)-R_events(i))<=11) & (mean(sleep.class((R_events(i)-3):(R_events(i)-1))==3)==1) & (sleep.class(R_events(i+1))==3) &(R_events(i)>3)
         sleep.class((R_events(i)+1):(R_events(i+1)-1))=3;
         
    end
end



%%%%Change unkown to smoothed classification

sleep.class(find((voltage_axis_REM==0)&(sleep.class==6)&(voltage_axis_SWS==0)))=5;


R_events=(find((voltage_axis_REM==0)&(sleep.class==6)&(voltage_axis_SWS==1)));


for i=1:(length(R_events))
    inds_inst=[];
    inds_inst=find(sleep.class==1|sleep.class==2|sleep.class==3);
    [a b]=min(abs(inds_inst-R_events(i)));
    sleep.class(R_events(i))=sleep.class(inds_inst(b));
    
end
    


R_events=(find((voltage_axis_REM==1)&(sleep.class==6)&(voltage_axis_SWS==1)));


for i=1:(length(R_events))
    inds_inst=[];
    inds_inst=find(sleep.class==1|sleep.class==2|sleep.class==3|sleep.class==4);
    [a b]=min(abs(inds_inst-R_events(i)));
    sleep.class(R_events(i))=sleep.class(inds_inst(b));
    
end









setappdata(handles.masterfig3,'sleep',sleep);  