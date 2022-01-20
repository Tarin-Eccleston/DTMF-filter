function  Imatrix = dtmfdesign(fcent, L, fs)
%DTMFDESIGN
%     Imatrix = dtmfdesign(fcent, L, fs)
%       returns a matrix where each column is the
%       impulse response of a BPF, one for each frequency
%  fcent = vector of center frequencies
%      L = length of FIR bandpass filters
%     fs = sampling freq  
%
% The BPFs must be scaled so that the maximum magnitude
% of the frequency response is equal to one.
%==========================================
% [697;770;852;941;1209;1336;1477;1633]; list of centre frequencies

%%%% add your lines below to complete the code

% Init
% fcent = [697;770;852;941;1209;1336;1477;1633]; 
% freqs = 8000; 
% L = 40;


% Create filters
[Imatrix,Hmatrix,Wmatrix,CornerFreq] = FilterGenerator(fcent,fs,L); 

% Plotting
for j = 1:length(fcent)
    
    % Generate all responces on the same plot
    plot(Wmatrix(j,:),Hmatrix(j,:));
    hold on
    
    title('Normalised Magnitude vs Normalised Frequency Responce')
    xlabel('Normalised Frequency (1)')
    ylabel('Normalised Magnitude (1)')
    
end
hold off 

% L = FindFilterLength(fcent,fs); 

end 







