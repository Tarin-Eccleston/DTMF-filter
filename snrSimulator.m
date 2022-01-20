function [SNR,error] = snrSimulator()

L = 86;
fs = 8000;
str = '01205978436'; 

% for L = 50:10:500

    for SNR = 0:0.1:2
        error = 0;
        flag = 0; 
        for j = 1:100
            xx = dtmfdial(str,SNR);
            keys = dtmfrun(xx,L,fs) 

            if (length(keys) == length(str))
                for k = 1:length(str)
                    if (str(k) ~= keys(k))
                        error = error + 1
                        break
                    end
                end
            else
                error = error + 1
            end

            if (error >= 10)
                flag = 1;
                break 
            end
        end

        if (flag == 0) 
            break
        end
    end
    
    
%     X(L) = L; 
%     Y(L) = SNR;

% end
% 
% scatter(X,Y); 
% title('Filter Length vs SNR')
% xlabel('Filter Length')
% ylabel('SNR')



