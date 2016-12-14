function varargout = EOG(handles)
[filename,pathname,filterindex] = uigetfile('*.*','Please pick a EOG file to display.')
if filterindex==0
    errordlg('You did not pick a EOG file','Bad Input','modal')
    return
end

load(fullfile(pathname,filename));
chan_num=[];
chan_num=listdlg('PromptString','Select ROG Channel  For Diplay','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));

Cdata=[];
chan_num2=listdlg('PromptString','Please Select a ROG Reference Channel','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));
Cdata=OUTEEG.data(chan_num,:)-OUTEEG.data(chan_num2,:);
EdataR=Cdata-mean(Cdata);


chan_num=[];
chan_num=listdlg('PromptString','Select LOG Channel  For Diplay','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));

Cdata=[];
chan_num3=listdlg('PromptString','Please Select a LOG Reference Channel','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));
Cdata=OUTEEG.data(chan_num,:)-OUTEEG.data(chan_num3,:);
EdataL=Cdata-mean(Cdata);



Esrate=OUTEEG.srate;
clear OUTEEG
window_size=30*ceil(Esrate);


if filterindex~=0
 handles.masterfig3=gcbf;
 
 
 

      


%% REM      

%REM 0-35 hz (American Academy of Sleep Medicine (AASM) 2007 Manual)  
 
Den_eog=[1,-9.95149769652460,45.6364776040494,-127.236801679583,239.537122124663,-319.633423098830,308.413656045662,-215.159167398963,106.348486220625,-35.4701993354454,7.18514659377708,-0.669797392454855];
Num_eog=[0.000200767747058231,-0.00139324641737917,0.00443287408338733,-0.00819083365943383,0.00891243172235205,-0.00396099998819698,-0.00396099998819698,0.00891243172235205,-0.00819083365943383,0.00443287408338733,-0.00139324641737917,0.000200767747058231];

      %eogl=filtfilt(Num_eog,Den_eog,double(EdataL));           
      %eogr=filtfilt(Num_eog,Den_eog,double(EdataR)); 
      eogl=eegfilt(double(EdataL),Esrate,0,35);            
      eogr=eegfilt(double(EdataR),Esrate,0,35); 

 %Calculate 30 sec window power.

    

    if (mod(length(eogl),window_size))~=0
            eogl_empty_cells=window_size-(mod(length(eogl),window_size));
            eogl_padded=[eogl zeros(1,eogl_empty_cells)];
    end

    if (mod(length(eogl),window_size))==0
        
            eogl_padded=eogl;
    end
	
    
    
eogl_volt=reshape(eogl_padded,window_size,((length(eogl_padded))/window_size));



               
 %Calculate 30 sec window power.

    

    if (mod(length(eogr),window_size))~=0
            eogr_empty_cells=window_size-(mod(length(eogr),window_size));
            eogr_padded=[eogr zeros(1,eogr_empty_cells)];
    end

    if (mod(length(eogr),window_size))==0
        
            eogr_padded=eogr;
    end
	
    
    
eogr_volt=reshape(eogr_padded,window_size,((length(eogr_padded))/window_size));


for i = 1:numel(eogl_volt(1,:))

eo_together(i)=sum(xcov(eogl_volt(:,i),eogr_volt(:,i)',78,'coef'));

end




eo_m_m=-[1*std(eo_together)];
eogl_m_m=[std(eogl)];
eogr_m_m=[std(eogr)];


%% SEM

%SEM Filter for slow eye movements IIR  Lowpass .5 Hz

Den_eog=[];
Num_eog=[];
Num_eog=[2.93751628260784e-15,1.76250976956470e-14,4.40627442391175e-14,5.87503256521567e-14,4.40627442391175e-14,1.76250976956470e-14,2.93751628260784e-15];
Den_eog=[1,-5.97068505132118,14.8538546308702,-19.7085640264970,14.7094148320979,-5.85513085148321,0.971110466333530];

      %eogl_se=filtfilt(Num_eog,Den_eog,double(EdataL));           
      %eogr_se=filtfilt(Num_eog,Den_eog,double(EdataR)); 
      eogl_se=eegfilt(double(EdataL),Esrate,0,.5);            
      eogr_se=eegfilt(double(EdataR),Esrate,0,.5); 


%Calculate 30 sec window power.

    

    if (mod(length(eogl_se),window_size))~=0
            eogl_se_empty_cells=window_size-(mod(length(eogl_se),window_size));
            eogl_se_padded=[eogl_se zeros(1,eogl_se_empty_cells)];
    end

    if (mod(length(eogl_se),window_size))==0
        
            eogl_se_padded=eogl_se;
    end
	
    
    
eogl_se_volt=reshape(eogl_se_padded,window_size,((length(eogl_se_padded))/window_size));



               
 %Calculate 30 sec window power.

    

    if (mod(length(eogr_se),window_size))~=0
            eogr_se_empty_cells=window_size-(mod(length(eogr_se),window_size));
            eogr_se_padded=[eogr_se zeros(1,eogr_se_empty_cells)];
    end

    if (mod(length(eogr_se),window_size))==0
        
            eogr_se_padded=eogr_se;
    end
	
    
    
eogr_se_volt=reshape(eogr_se_padded,window_size,((length(eogr_se_padded))/window_size));


for i = 1:numel(eogl_se_volt(1,:))

eo_se_together(i)=sum(xcov(eogl_se_volt(:,i),eogr_se_volt(:,i)',10,'coef'));

end




eo_se_m_m=-[1*std(eo_se_together)];
eogl_se_m_m=[std(eogl_se)];
eogr_se_m_m=[std(eogr_se)];



%% Eye Blink
      
%EYE Blink Filter for eye blink .5-2 Hz FIR
Den_eog=[];
Num_eog=[];

%Newer delta .5 to 2, stopband .01 and 3.5
Den_eog=[1,-5.98095535972624,14.9057003509556,-19.8132380051633,14.8150656518969,-5.90844189303005,0.981869255071061];
Num_eog=[0.00139265181190150,-0.00556827687432191,0.00695859834773835,0,-0.00695859834773835,0.00556827687432191,-0.00139265181190150];


      %eogl_eb=filtfilt(Num_eog,Den_eog,double(EdataL));           
      %eogr_eb=filtfilt(Num_eog,Den_eog,double(EdataR)); 
      eogl_eb=eegfilt(double(EdataL),Esrate,.5,2);            
      eogr_eb=eegfilt(double(EdataR),Esrate,.5,2);  
      
      
eogl_eb_squared_voltages=eogl_eb.^2;
 

 

    if (mod(length(eogl_eb_squared_voltages),window_size))~=0
            eogl_eb_empty_cells=window_size-(mod(length(eogl_eb_squared_voltages),window_size));
            eogl_eb_squared_voltages_padded=[eogl_eb_squared_voltages zeros(1,eogl_eb_empty_cells)];
    end

    if (mod(length(eogl_eb_squared_voltages),window_size))==0
        
            eogl_eb_squared_voltages_padded=eogl_eb_squared_voltages;
    end
	
    
    
ogl_eb_squared_volt=reshape(eogl_eb_squared_voltages_padded,window_size,((length(eogl_eb_squared_voltages_padded))/window_size));
ogl_eb_squared_buff=sum(ogl_eb_squared_volt);
Neo_eogl_ebP=(ogl_eb_squared_buff(1:(end))./(window_size/Esrate));


 Neo_eogl_eb_m_m=[std(eogl_eb)];   
 Neo_eogl_ebP_m_m=[1*std(Neo_eogl_ebP)];    
    
 

 %Calculate 30 sec window power.
 
eogr_eb_squared_voltages=eogr_eb.^2;
 

 

    if (mod(length(eogr_eb_squared_voltages),window_size))~=0
            eogr_eb_empty_cells=window_size-(mod(length(eogr_eb_squared_voltages),window_size));
            eogr_eb_squared_voltages_padded=[eogr_eb_squared_voltages zeros(1,eogr_eb_empty_cells)];
    end

    if (mod(length(eogr_eb_squared_voltages),window_size))==0
        
            eogr_eb_squared_voltages_padded=eogr_eb_squared_voltages;
    end
	
    
    
ogr_eb_squared_volt=reshape(eogr_eb_squared_voltages_padded,window_size,((length(eogr_eb_squared_voltages_padded))/window_size));
ogr_eb_squared_buff=sum(ogr_eb_squared_volt);
Neo_eogr_ebP=(ogr_eb_squared_buff(1:(end))./(window_size/Esrate));


 Neo_eogr_eb_m_m=[std(eogr_eb)];   
 Neo_eogr_ebP_m_m=[1*std(Neo_eogr_ebP)+(median(Neo_eogr_ebP))];    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









setappdata(handles.masterfig3,'eo_together',eo_together);
setappdata(handles.masterfig3,'eo_m_m',eo_m_m);
setappdata(handles.masterfig3,'eogl_m_m',eogl_m_m);
setappdata(handles.masterfig3,'eogr_m_m',eogr_m_m);
setappdata(handles.masterfig3,'eogl',eogl);
setappdata(handles.masterfig3,'eogr',eogr);
setappdata(handles.masterfig3,'eo_se_together',eo_se_together);
setappdata(handles.masterfig3,'eo_se_m_m',eo_se_m_m);
setappdata(handles.masterfig3,'eogl_se_m_m',eogl_se_m_m);
setappdata(handles.masterfig3,'eogr_se_m_m',eogr_se_m_m);
setappdata(handles.masterfig3,'eogl_se',eogl_se);
setappdata(handles.masterfig3,'eogr_se',eogr_se);   
setappdata(handles.masterfig3,'eogr_eb',eogr_eb);
setappdata(handles.masterfig3,'Neo_eogr_ebP',Neo_eogr_ebP);
setappdata(handles.masterfig3,'Neo_eogr_eb_m_m',Neo_eogr_eb_m_m);
setappdata(handles.masterfig3,'Neo_eogr_ebP_m_m',Neo_eogr_ebP_m_m);
setappdata(handles.masterfig3,'Neo_eogl_ebP',Neo_eogl_ebP);
setappdata(handles.masterfig3,'Neo_eogl_eb_m_m',Neo_eogl_eb_m_m);
setappdata(handles.masterfig3,'Neo_eogl_ebP_m_m',Neo_eogl_ebP_m_m);
end