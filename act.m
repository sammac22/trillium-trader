%function takes in a single trade and returns whether it bought or sold
function [sold, bought] = act(trade1)
sold = 0;
bought = 0;

%switch case checks which moving average is in question and retrieves
%relevant historical information
switch trade1.movingAvg
    case '1 min'
        %trade1.paramas.Symbol = ticker symbol
        %trade1.movingAvg = moving average
        data = IBMatlab('action','history', 'symbol',trade1.paramas.Symbol,'barSize',trade1.movingAvg, 'useRTH',1,'duration', '420 S');
    case '1 hour'
        data = IBMatlab('action','history', 'symbol',trade1.paramas.Symbol,'barSize',trade1.movingAvg, 'useRTH',1,'duration', '21 D');
    case '1 day'
        data = IBMatlab('action','history', 'symbol',trade1.paramas.Symbol,'barSize',trade1.movingAvg, 'useRTH',1,'duration', '2 Y');
    case '1 W'
        data = IBMatlab('action','history', 'symbol',trade1.paramas.Symbol,'barSize',trade1.movingAvg, 'useRTH',1,'duration', '10 Y');
end

%Gets the current information about the stock in question
current = IBMatlab('action', 'query', 'symbol', trade1.paramas.Symbol);

%sends the highs, lows and closes from the historical data to EMA() which
%returns the averages for each candle
averages = EMA(data.high,data.low,data.close);
disp(trade1.paramas.Action);

%outer if statement checks to see whether you are trying to buy or sell
if strcmp(trade1.paramas.Action, 'buy')
    %disp statements just to print out the prices that are being compared
    disp('in buy')
    disp('bid ');
    disp(current.bidPrice);
    disp('averages ');
    disp(averages(1));
    %if the current market price if above the most recent average then buy
    if current.bidPrice > averages(1)
        disp('bought');
        %IBMatlab statement is just taking the trade parameters which has
        %all the info needed to buy
        IBMatlab(trade1.paramas);
        
        %sets boolean value of bought
        bought = 1;
    else
        disp('did not buy');
    end
else
    %program will go in here if the action is 'sell'
    disp('bid ');
    disp(current.bidPrice);
    disp('averages ');
    disp(averages(1));
    %if market value if less than the most recent candle average then sell
    if current.bidPrice < averages(1)
        disp('sold');
        IBMatlab(trade1.paramas);
        
        %sets boolean value of sold
        sold = 1;
    else
        disp('didnt sell');
    end
end
end
