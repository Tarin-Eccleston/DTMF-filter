% For task 1.7.2
% 1)
L = 50; 
OmegaN = 0.2*pi;

w(1:L+1) = 1; 
n = (0:L);

B = cos(OmegaN*n).*w; 

% Found the impulse responce H, 
% W normalised freq
% Complex result because phase is in H
a = 1;
N = 4096; 
[H, W] = freqz(B, a, N);

% Find magnitude
H = abs(H); 

Max = max(H);

% Finding scaling factor
Beta = 1/Max; 

% 2) 

% Normalise responce
Norm = Beta.*H;

% Values which exceed 1/sqrt(2)
index = find(Norm > 1/sqrt(2));

% Cutoff frequencies
First = Norm(index(1)); 
Last = Norm(index(end)); 

% Normalised freq
NormFreqFirst = W(index(1));
NormFreqLast = W(index(end));

% 3)
SamplingRate = 8000; 

% Analog cut-off frequencies
AnalFreqFirst = (NormFreqFirst / (2*pi)) * SamplingRate;  
AnalFreqLast = (NormFreqLast / (2*pi)) * SamplingRate; 

% Analog passband width frequencies
AnalFreqWidth = AnalFreqLast - AnalFreqFirst; 




