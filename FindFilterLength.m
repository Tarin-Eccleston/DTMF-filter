function L = FindFilterLength(fcent,freqs)
% Find minimum L to satisfy filter design specifications
L = 0; 
flag = 0; 
while (flag ~= 1)
    
    flag = 1;
    
    % Increment window length and generate new array of filters
    L = L + 1;  
    [Imatrix,Hmatrix,Wmatrix,CornerFreq] = FilterGenerator(fcent,freqs,L); 
    
    for i = 1:length(fcent) 
    
        % Passband frequencies
        indexPass = find(Hmatrix(i,:) > 1/sqrt(2));
        freqPass = Wmatrix(i,indexPass(1):indexPass(end)); 
        
        % Inverted stopband frequencies
        indexStop = find(Hmatrix(i,:) > (1/4));
        freqStop = Wmatrix(i,indexStop(1):indexStop(end));

        % Check if corner frequency is outside passband
        % send a flag if so
        if (CornerFreq(i) <= freqPass(1) && CornerFreq(i) >= freqPass(end))
            flag = 0;
            break
        end
        
        % Check if only one corner frequency is in the stopband region
        % send a flag if not
        k = 0; 
        for j = 1:length(fcent)
        
            if (CornerFreq(j) >= freqStop(1) && CornerFreq(j) <= freqStop(end)) 
                k = k + 1; 
            end
        end
        
        % Checking number of corner frequencies in passband
        if (k == 1)
            flag = 1;
        else
            flag = 0;
            break 
        end    
    end
end 

% Print out finalised filter length result
fprintf('The ideal filter window length is = %i\n', L);

end