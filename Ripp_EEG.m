function varargout = Ripp_EEG(handles)
[filename,pathname,filterindex] = uigetfile('*.*','Please pick a EEG file to display.')
if filterindex==0
    errordlg('You did not pick a EEG file','Bad Input','modal')
    return
end

load(fullfile(pathname,filename));
chan_num=[];
chan_num=listdlg('PromptString','Select Channel For Diplay','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));

Cdata=[];
chan_num2=listdlg('PromptString','Please Select a Reference Channel','SelectionMode','multiple','ListString',str2mat(OUTEEG.chanlocs.labels));
Cdata=OUTEEG.data(chan_num,:)-OUTEEG.data(chan_num2,:);
Rdata=Cdata-mean(Cdata);



Rsrate=OUTEEG.srate;
clear OUTEEG
window_size=30*ceil(Rsrate);


if filterindex~=0
 handles.masterfig3=gcbf;
 
 %  bw0=Rsrate/2; % bw in Hz (sampling freq/2)
%  nb1=64;
% 
%         
%        
% 
%         %Ripple 80 to 240Hz, 512 order FIR
%        
%                 wn(1)=80/bw0; wn(2)=240/bw0;
%                 bn_ripple=fir1(nb1,wn);
% 
%        
%       
%                 
%                 
% %Now Filter Data and Store It.                
%               
% 
%                 
%                 junk=Rdata;
%                 s0_short=[junk zeros(1,nb1/2)];
%                 
%                 s1_r=filter(bn_ripple,1,s0_short);
%                 ripple=s1_r((nb1/2)+1:end);
%                

 Den=[1.000000000000000   3.293256843394248   4.898440829013834   5.922954151388943   7.388287115961792   7.277005464173143 5.380041735378279   3.688421103643950   2.259934265277285   0.900692156280027   0.168319896193130];
 Num=[0.168000157994495   0.267518917335913  -0.158872298540514  -0.091178119539115   0.527044395766065  -0.000000000000000 -0.527044395766065   0.091178119539115   0.158872298540514  -0.267518917335913  -0.168000157994495];
 
 %Calculate 30 sec window power.

 ripple=filtfilt(Num,Den,double(Rdata)); 
 
    
ripple_squared_voltages=ripple.^2;

    if (mod(length(ripple_squared_voltages),window_size))~=0
            ripple_empty_cells=window_size-(mod(length(ripple_squared_voltages),window_size));
            ripple_squared_voltages_padded=[ripple_squared_voltages zeros(1,ripple_empty_cells)];
    end

    if (mod(length(ripple_squared_voltages),window_size))==0
        
            ripple_squared_voltages_padded=ripple_squared_voltages;
    end
	
    
    
rip_squared_volt=reshape(ripple_squared_voltages_padded,window_size,((length(ripple_squared_voltages_padded))/window_size));
rip_squared_buff=sum(rip_squared_volt);
rippleP=(rip_squared_buff(1:(end))./(window_size/Rsrate));

Rdata_m_m=[std(Rdata)]; 
ripple_m_m=[std(ripple)];     
rippleP_m_m=[1*std(rippleP)];      
 setappdata(handles.masterfig3,'Rdata',Rdata);
 setappdata(handles.masterfig3,'Rsrate',Rsrate);
 
 setappdata(handles.masterfig3,'ripple',ripple);
 setappdata(handles.masterfig3,'rippleP',rippleP);
 setappdata(handles.masterfig3,'Rdata_m_m',Rdata_m_m);
 setappdata(handles.masterfig3,'ripple_m_m',ripple_m_m);
 setappdata(handles.masterfig3,'rippleP_m_m',rippleP_m_m);
 
 
 
 clear junk s0_short s1_a
end