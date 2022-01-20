function [Imatrix,Hmatrix,Wmatrix,CornerFreq] = FilterGenerator(fcent,freqs,L) 

% Frequency Responce Magnitude
Hmatrix = zeros(8,4096); 

% Normalised Frequency
Wmatrix = zeros(8,4096); 

% Impulse Responce (filter coefficients)
Imatrix = zeros(8,L+1); 

Beta = zeros(8,1);
CornerFreq = zeros(8,1); 
AnalFreqWidth = zeros(8,1);

w(1:L+1) = 1;
n = (0:L);
 
% Square Cosine Window
% for k = 1:(L+1) 
%             index = pi*k/L - pi/2; 
%             w(k) = (cos(index).^2);
% end


for i = 1:length(fcent)
    
    % Corner frequency
    CornerFreq(i) = 2*pi*(fcent(i)/freqs);

    B = cos(CornerFreq(i).*n).*w; 

    % Found the freq responce H, 
    % W normalised freq
    % Complex result because phase is in H
    a = 1;
    N = 4096;

    [H,W] = freqz(B, a, N);

    Wmatrix(i,:) = W;  

    % Find magnitude
    Hmatrix(i,:) = abs(H); 

    % Find maximum value
    Max = max(Hmatrix(i,:));

    % Finding scaling factor
    Beta(i) = 1/Max;
    
    % Normalised Filter coefficients (impulse responce)
    Imatrix(i,:) = Beta(i).*B; 

     % Normalise Frequency Responce
    Hmatrix(i,:) = Beta(i).*Hmatrix(i,:);
    
    % Values which exceed 1/sqrt(2) in passband
    index = find(Hmatrix(i,:) > 1/sqrt(2));

    % Normalised cut-off frequencies
    NormFreqFirst = Wmatrix(i,index(1));
    NormFreqLast = Wmatrix(i,index(end)); 

    % Analog cut-off frequencies
    AnalFreqFirst = (NormFreqFirst / (2*pi)) * freqs;  
    AnalFreqLast = (NormFreqLast / (2*pi)) * freqs; 

    % Analog passband frequency width
    AnalFreqWidth(i) = AnalFreqLast - AnalFreqFirst; 
    
end











