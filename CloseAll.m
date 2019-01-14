function CloseAll(allTrades)
%CLOSEALL Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(allTrades)
    if allTrades(i).done == 1
        IBMatlab(allTrades(i).paramas);  
    end
end

end