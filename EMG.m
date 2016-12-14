function varargout = EMG(handles)
[filename,pathname,filterindex] = uigetfile('*.*','Please pick a EMG file to display.')
if filterindex==0
    errordlg('You did not pick a EMG file','Bad Input','modal')
    return
end

load(fullfile(pathname,filename));
chan_num=[];
chan_num=listdlg('PromptString','Select Channel For Diplay','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));

Cdata=[];
chan_num2=listdlg('PromptString','Please Select a Reference Channel','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));
Cdata=OUTEEG.data(chan_num,:)-OUTEEG.data(chan_num2,:);
Edata=Cdata-mean(Cdata);

Esrate=OUTEEG.srate;
clear OUTEEG
window_size=30*ceil(Esrate);


if filterindex~=0
 handles.masterfig3=gcbf;
 
 
%EMG 10-100 hz (American Academy of Sleep Medicine (AASM) 2007 Manual)  
 
Den_em=[1,-10.8666688265116,57.4170249510870,-196.727935216282,490.531541914541,-944.866196474898,1454.64126400221,-1825.44078160782,1886.53755239022,-1610.50591118062,1131.61742644713,-647.427305018445,295.598433892741,-104.080797585802,26.6363706149394,-4.42226189185645,0.358243795317221];
Num_em=[0.0339358088042112,-0.276643219204113,1.09686798162715,-2.88011799156696,5.70082551104073,-9.10618700029234,12.2752601964105,-14.4592361463704,15.2305897211620,-14.4592361463704,12.2752601964105,-9.10618700029234,5.70082551104073,-2.88011799156696,1.09686798162715,-0.276643219204113,0.0339358088042112];

      %emg=filtfilt(Num_em,Den_em,double(Edata));           
      emg=eegfilt(double(Edata),Esrate,10,100);
               
 %Calculate 30 sec window power.

    
emg_squared_voltages=emg.^2;

    if (mod(length(emg_squared_voltages),window_size))~=0
            emg_empty_cells=window_size-(mod(length(emg_squared_voltages),window_size));
            emg_squared_voltages_padded=[emg_squared_voltages zeros(1,emg_empty_cells)];
    end

    if (mod(length(emg_squared_voltages),window_size))==0
        
            emg_squared_voltages_padded=emg_squared_voltages;
    end
	
    
    
e_squared_volt=reshape(emg_squared_voltages_padded,window_size,((length(emg_squared_voltages_padded))/window_size));
e_squared_buff=sum(e_squared_volt);
emgP=(e_squared_buff(1:(end))./(window_size/Esrate));

    
 Edata_m_m=[std(Edata)];
 emg_m_m=[std(emg)];
 emgP_m_m=[0*std(emgP)+median(emgP)];
 
 setappdata(handles.masterfig3,'Edata',Edata);
 setappdata(handles.masterfig3,'Esrate',Esrate);
 
 setappdata(handles.masterfig3,'emg',emg);
 setappdata(handles.masterfig3,'emgP',emgP);
 setappdata(handles.masterfig3,'Edata_m_m',Edata_m_m);
 setappdata(handles.masterfig3,'emg_m_m',emg_m_m);
 setappdata(handles.masterfig3,'emgP_m_m',emgP_m_m);
 
 
 
 clear junk s0_short s1_a
end