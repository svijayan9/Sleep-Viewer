function varargout = Neo_EEG(handles)
[filename,pathname,filterindex] = uigetfile('*.*','Please pick a Neocortical EEG file to display.')
if filterindex==0
    errordlg('You did not pick a Neocortical EEG file','Bad Input','modal')
    return
end

load(fullfile(pathname,filename));
chan_num=[];
chan_num=listdlg('PromptString','Select Channel For Diplay','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));


Cdata=[];
chan_num2=listdlg('PromptString','Please Select a Reference Channel','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));
Cdata=OUTEEG.data(chan_num,:)-OUTEEG.data(chan_num2,:);
Ndata=Cdata-mean(Cdata);

Nsrate=OUTEEG.srate;
Neo_timestamp=[0:1:(OUTEEG.pnts-1)]*(1/Nsrate);
clear OUTEEG
window_size=30*ceil(Nsrate);


if filterindex~=0
 handles.masterfig3=gcbf;
 
 
 
 
 bw0=Nsrate/2; % bw in Hz (sampling freq/2)
 nb1=512;
 nb2=2048;
        
        %Delta .5 to 2 Hz, 512 order FIR
        
                wn(1)=.5/bw0; wn(2)=2/bw0;
                bn_delta=fir1(nb2,wn);

        %Spindle 12 to 16 Hz, 512 order FIR
       
                wn(1)=12/bw0; wn(2)=16/bw0;
                bn_spindle=fir1(nb1,wn);

       
      
                
                
%Now Filter Data and Store It.                
              

                
                junk=Ndata;
                s0_short=[junk zeros(1,nb1/2)];
                s0_long=[junk zeros(1,nb2/2)];
                s1_d=filter(bn_delta,1,s0_long);
                s1_s=filter(bn_spindle,1,s0_short);
                
                Neo_delta=s1_d((nb2/2)+1:end);
                Neo_spindle=s1_s((nb1/2)+1:end);
               
 %Calculate 30 sec window power.
 
 delta_squared_voltages=Neo_delta.^2;

    if (mod(length(delta_squared_voltages),window_size))~=0
            delta_empty_cells=window_size-(mod(length(delta_squared_voltages),window_size));
            delta_squared_voltages_padded=[delta_squared_voltages zeros(1,delta_empty_cells)];
    end

    if (mod(length(delta_squared_voltages),window_size))==0
        
            delta_squared_voltages_padded=delta_squared_voltages;
    end
	
    
    
delt_squared_volt=reshape(delta_squared_voltages_padded,window_size,((length(delta_squared_voltages_padded))/window_size));
delt_squared_buff=sum(delt_squared_volt);
Neo_deltaP=(delt_squared_buff(1:(end))./(window_size/Nsrate));

    
    
spindle_squared_voltages=Neo_spindle.^2;

    if (mod(length(spindle_squared_voltages),window_size))~=0
            spindle_empty_cells=window_size-(mod(length(spindle_squared_voltages),window_size));
            spindle_squared_voltages_padded=[spindle_squared_voltages zeros(1,spindle_empty_cells)];
    end

    if (mod(length(spindle_squared_voltages),window_size))==0
        
            spindle_squared_voltages_padded=spindle_squared_voltages;
    end
	
    
    
spin_squared_volt=reshape(spindle_squared_voltages_padded,window_size,((length(spindle_squared_voltages_padded))/window_size));
spin_squared_buff=sum(spin_squared_volt);
Neo_spindleP=(spin_squared_buff(1:(end))./(window_size/Nsrate));


 Neo_data_m_m=[std(Ndata)];   
 Neo_delta_m_m=[std(Neo_delta)];
 Neo_spindle_m_m=[std(Neo_spindle)];   
 Neo_deltaP_m_m=[std(Neo_deltaP)];
 Neo_spindleP_m_m=[std(Neo_spindleP)];   
 
 setappdata(handles.masterfig3,'Neo_data',Ndata);
 setappdata(handles.masterfig3,'Neo_srate',Nsrate);
 setappdata(handles.masterfig3,'Neo_data_m_m',Neo_data_m_m);
 
 
 setappdata(handles.masterfig3,'Neo_delta',Neo_delta);
 setappdata(handles.masterfig3,'Neo_spindle',Neo_spindle);
 setappdata(handles.masterfig3,'Neo_delta_m_m',Neo_delta_m_m);
 setappdata(handles.masterfig3,'Neo_spindle_m_m',Neo_spindle_m_m);
 setappdata(handles.masterfig3,'Neo_deltaP_m_m',Neo_deltaP_m_m);
 setappdata(handles.masterfig3,'Neo_spindleP_m_m',Neo_spindleP_m_m);
 
 setappdata(handles.masterfig3,'Neo_deltaP',Neo_deltaP);
 setappdata(handles.masterfig3,'Neo_spindleP',Neo_spindleP);
 setappdata(handles.masterfig3,'Neo_timestamp',Neo_timestamp);
 set(findobj('Tag','EEG_slider'),'max',(length(Neo_timestamp)-window_size),'min',1);

 
 
 clear junk s0_short s0_long s1_d s1_s 
end