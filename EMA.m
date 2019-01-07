%function takes in the highs, lows and close values and returns average of
%each candle
function [average] = EMA(highs, lows, close)

%initialize the empty totals vector
totals = [];
%for loop runs through all values passed to it
for i=1: length(highs)
    %statement does (high + low + close) / 3 and adds it to the totals
    %vector
    totals = [totals,(highs(i) + lows(i) + close(i))/3];
end

%uses matlab function movavg to get the exponential moving average for each
%candle. I had to rotate the vector because that's how the movavg function
%wants it.
totals = rot90(totals);
average = movavg(totals,'exponential',length(highs));
end