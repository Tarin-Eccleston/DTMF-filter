function keys = dtmfrun(xx,L,fs)
%DTMFRUN    keys = dtmfrun(xx,L,fs)
%    returns the list of key numbers corresponding
%      to the DTMF waveform, xx.
%      L = filter length
%     fs = sampling freq  

freqs = [697,770,852,941,1209,1336,1477,1633];  % list of centre frequencies

Imatrix = dtmfdesign(freqs,L,fs);
%   hh = MATRIX of all the filters. Each column contains the impulse
%        response of one BPF (bandpass filter)

dtmf.keys = ...
['1','2','3','A';
'4','5','6','B';
'7','8','9','C';
'*','0','#','D'];
dtmf.colTones = [1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941];
 
% Rectangular windowing, creates transient effects when put through filter
[nstart,nstop] = dtmfcut(xx,fs);   %<--Find the start and end points of each tone

%%%% add your lines below to complete the code

% Decoding signal

% Loop across each segment
l = 1; 
for i = 1:length(nstart) 
    % Loop across each of the 8 filters
    
    % Clear coordinates of keys
    s = []; 
    toggle1 = 0; 
    toggle2 = 0;
    for j = 1:length(freqs)
        
        wx = xx(nstart(i):nstop(i)); 
        
        % Score the prevalence of the DTMF frequency in each windowed signal
        % starts from rows to columns
        sc = dtmfscore(wx, Imatrix(j,:)); 
        
        % If DTMF is present, save index
        if (sc == 1 && j <= 4 && toggle1 == 0)
            % save index
            s(1) = j;
            toggle1 = 1;
        elseif (sc == 1 && j > 4 && toggle2 == 0)
            % save index
            s(2) = j; 
            toggle2 = 1; 
        end
    end
    
    % Save DTMF keys
    if (toggle1 == 1 && toggle2 == 1)
        keys(l) = dtmf.keys(s(1),(s(2)-4));
        l = l + 1;
    end
 
end

if l == 1
    keys = '404'; 
end






 





