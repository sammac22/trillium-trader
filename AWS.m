%This function takes the allTrades vector as input and returns a new one
function newTrades = AWS(allTrades)
%It loops through every trade in the vector.
for i=1:length(allTrades)
    %Boolean values to tell AWS whether or not the trade bought or sold
    sold = 0;
    bought = 0;
    disp(allTrades(i).paramas.Action);
    
    %Passes current trade to act() and act() tells us whether it bought or
    %sold
    [sold, bought] = act(allTrades(i));
    
    %if act() sold then delete the current trade from allTrades
    if sold == 1
        allTrades(i) = [];
    end
    
    %if act() bought then change the 'buy' parameter to a 'sell' so next
    %time it is checking the trade, it is trying to sell.
    if bought == 1
        disp('in change');
        allTrades(i).paramas.Action = 'sell';
    end
end

%returns the new vector
newTrades = allTrades;
end