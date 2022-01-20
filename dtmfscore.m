function  sc = dtmfscore(xx, Imatrix)
%DTMFSCORE
%          sc = dtmfscore(xx, Imatrix)
%    returns a score based on the maximum amplitude of the filtered output
%     xx = input DTMF signal
%     Imatrix = impulse response of ONE bandpass filter
%
% The signal detection is done by filtering xx with a length-L
% BPF, Imatrix, and then finding the maximum amplitude of the output.
% The score is either 1 or 0.
%      sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
%      sc = 0 if max(|y[n]|) is less than 0.59

xx = xx*(2/max(abs(xx)));   %---Scale x[n] to the range [-2,+2]

%%%% add your lines below to complete the code

% Convolution of xx with Imatrix
% Produces in ... domain
yy = conv(Imatrix, xx); 
Max = max(yy); 

if Max >= 0.45
    sc = 1;
else
    sc = 0;
end



