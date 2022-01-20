function xx = dtmfdial(keyNames,varargin)
%DTMFDIAL Create a signal vector of tones which will dial
% a DTMF (Touch Tone) telephone system.
%
% usage: xx = dtmfdial(keyNames,SNR)
% keyNames = vector of characters containing valid key names (e.g. '12345567890')
% SNR = signal-to-noise ratio in dB (no noise will be added if this argment is left blank)
% xx = signal vector that is the concatenation of DTMF tones.
%

fs = 8000;

dtmf.keys = ...
['1','2','3','A';
'4','5','6','B';
'7','8','9','C';
'*','0','#','D'];
dtmf.rowTones = [1209,1336,1477,1633];
dtmf.colTones = [697;770;852;941];

t_tone = 0.2; %sec
t_gap = 0.05; %sec

chk = 0;
for k = 1:length(keyNames)
    chk = chk + not(sum(sum(keyNames(k)==dtmf.keys)));
end
if chk ~= 0
   error('input includes invalid characters (input should be either 0-9 or A-D or # or *)'); 
end

output = zeros(1,fs*t_gap);
for k = 1:length(keyNames)
    [ii, jj] = find(keyNames(k)==dtmf.keys);
    freq1 = dtmf.colTones(ii);
    freq2 = dtmf.rowTones(jj);
    tone1 = sin(2*pi*freq1*[1/fs:1/fs:t_tone]);
    tone2 = sin(2*pi*freq2*[1/fs:1/fs:t_tone]);

    output = [output, (tone1+tone2)];
    output = [output, zeros(1,fs*t_gap)];
end

noise = randn(1,length(output));

if nargin > 1
    SNR = varargin{1};
    xx= output + noise * 10^(-SNR/20);
else
    xx= output;
end