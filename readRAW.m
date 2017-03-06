function readRAW
%change portnum1 to the correct COM port

clear all 
close all

output = 'Trial_50.csv';

% data taken 512 Hz
% data_interval = 1843200; % 60 minute worth of data
% data_interval = 5529600; %3 hrs worth of data
% data_interval = 61440; %2 minutes worth of data
% data_interval = 40960; %80 sec worth of data
% data_interval = 30720; %1 minute worth of data
% data_interval = 10240; %20 seconds worth of data
data_interval = 153600 % 5 min of data
% data = zeros(1,256);    %preallocate buffer
% data = zeros(1,data_interval); %preallocate buffer 
data_signal = zeros(1,data_interval); 
data_attention = zeros(1,data_interval); 
data_meditation = zeros(1,data_interval); 
data_raw = zeros(1,data_interval); 
data_delta = zeros(1,data_interval); 
data_theta = zeros(1,data_interval); 
data_alpha1 = zeros(1,data_interval); 
data_alpha2 = zeros(1,data_interval); 
data_beta1 = zeros(1,data_interval); 
data_beta2 = zeros(1,data_interval); 
data_gamma1 = zeros(1,data_interval); 
data_gamma2 = zeros(1,data_interval); 
data_blink = zeros(1,data_interval); 

portnum1 = 4;   %COM Port #
comPortName1 = sprintf('\\\\.\\COM%d', portnum1);


% Baud rate for use with TG_Connect() and TG_SetBaudrate().
TG_BAUD_57600 =      57600;


% Data format for use with TG_Connect() and TG_SetDataFormat().
TG_STREAM_PACKETS =     0;


% Data type that can be requested from TG_GetValue().
TG_DATA_POOR_SIGNAL =     1;
TG_DATA_ATTENTION =       2;
TG_DATA_MEDITATION =      3;
TG_DATA_RAW =             4; 
TG_DATA_DELTA =           5;
TG_DATA_THETA =           6;
TG_DATA_ALPHA1 =          7;
TG_DATA_ALPHA2 =          8;
TG_DATA_BETA1 =           9;
TG_DATA_BETA2 =          10;
TG_DATA_GAMMA1 =         11;
TG_DATA_GAMMA2 =         12;
TG_DATA_BLINK_STRENGTH = 37;

%load thinkgear dll
loadlibrary('Thinkgear.dll');
fprintf('Thinkgear.dll loaded\n');

%get dll version
dllVersion = calllib('Thinkgear', 'TG_GetDriverVersion');
fprintf('ThinkGear DLL version: %d\n', dllVersion );


%%
% Get a connection ID handle to ThinkGear
connectionId1 = calllib('Thinkgear', 'TG_GetNewConnectionId');
if ( connectionId1 < 0 )
    error( sprintf( 'ERROR: TG_GetNewConnectionId() returned %d.\n', connectionId1 ) );
end;

% Set/open stream (raw bytes) log file for connection
errCode = calllib('Thinkgear', 'TG_SetStreamLog', connectionId1, 'streamLog.txt' );
if( errCode < 0 )
    error( sprintf( 'ERROR: TG_SetStreamLog() returned %d.\n', errCode ) );
end;

% Set/open data (ThinkGear values) log file for connection
errCode = calllib('Thinkgear', 'TG_SetDataLog', connectionId1, 'dataLog.txt' );
if( errCode < 0 )
    error( sprintf( 'ERROR: TG_SetDataLog() returned %d.\n', errCode ) );
end;

% Attempt to connect the connection ID handle to serial port "COM3"
errCode = calllib('Thinkgear', 'TG_Connect',  connectionId1,comPortName1,TG_BAUD_57600,TG_STREAM_PACKETS );
if ( errCode < 0 )
    error( sprintf( 'ERROR: TG_Connect() returned %d.\n', errCode ) );
end

fprintf( 'Connected.  Reading Packets...\n' );




%%
%record data


j = 0;
i = 0;
t = [];
s = [];
time = 0;

while (i < data_interval)
    if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1)   %if a packet was read...
        
        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_RAW) ~= 0)   %if RAW has been updated 
            j = j + 1;
            i = i + 1;
            time(i) = i/512; % time in seconds when sample was taken
            s(j) = j; % samples
            t(j) = j/512; % time in seconds when sample was taken
            t(j)
            data_signal(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_POOR_SIGNAL); % poor signal data
            data_attention(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ATTENTION); % attention data
            data_meditation(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_MEDITATION); % meditation data
            data_raw(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_RAW); % raw data
            data_delta(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_DELTA); % delta data
            data_theta(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_THETA); % theta data
            data_alpha1(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA1); % alpha1 data
            data_alpha2(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA2); % alpha2 data
            data_beta1(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA1); % beta1 data
            data_beta2(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA2); % beta2 data
            data_gamma1(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA1); % gamma1 data
            data_gamma2(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA2); % gamma2 data
            data_blink(j) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BLINK_STRENGTH); % blink strength data
            
        end
    end
     
%    if (i==256)
%         plotRAW(data_raw);    %plot the data, update every .5 seconds (256 points)
%         i = 0;
%    end

end


headers = {'Time','Sample','PoorSignal','Attention','Meditation','Raw','Delta',...
    'Theta','Alpha1','Alpha2','Beta1','Beta2','Gamma1','Gamma2','Blink'};
T = table(transpose(t),transpose(s),transpose(data_signal),transpose(data_attention),...
transpose(data_meditation),transpose(data_raw),transpose(data_delta),...
transpose(data_theta),transpose(data_alpha1),transpose(data_alpha2),...
transpose(data_beta1),transpose(data_beta2),transpose(data_gamma1),...
transpose(data_gamma2),transpose(data_blink),'VariableNames',headers );
writetable(T, output, 'WriteVariableNames', true);

%disconnect             
calllib('Thinkgear', 'TG_FreeConnection', connectionId1 );

