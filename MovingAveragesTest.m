 data = IBMatlab('action','history', 'symbol','SPY','barSize','1 min', 'useRTH',1,'duration', '3 day');
total = (data.high + data.low + data.close)/3;
averages = movavg(total','simple',7)
disp(averages(1))