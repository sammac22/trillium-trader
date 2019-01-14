function avgValues = getMA(symbol, avgType, windowSizes, varargin)
%GETMA Get latest moving average values of a time series, for various windowSizes
%
% Syntax:
%
%   avgValues = getMA(symbol, avgType, windowSizes)
%   avgValues = getMA(symbol, avgType, windowSizes, parameterName,parameterValue, ...)
%
% Description:
%
%   GETMA computes a time-series' moving average (MA) of historic data from IB
%   and returns the latest value. By default, the history is of 1-min bars, but
%   this can be modified using the optional parameters.
%
% Input arguments:
%
%   symbol      - the asset ticker (string/char)
%   avgType     - one of 'simple','square-root','linear','square','exponential', 
%                 'triangular', 'modified', 'custom' (or a non-ambiguous abbreviation)
%   windowSizes - numeric array of window sizes
%   parameters  - optional IBMatlab parameters as Name,Value pairs
%
% Output argument:
%
%   avgValue    - numeric array (same size as windowSizes) with the latest MA
%                 value for each of the requested windowSizes
%
% Usage example: get the latest 5-min and 30-min SMA values for IBM
%
%   avgValues = getMA('IBM', 'simple', [5,30], 'BarSize','1 min', 'UseRTH',1);

% Get the historical data from IB
data = IBMatlab('action','history', 'symbol',symbol, 'BarSize','1 min', varargin{:});

% Compute a representative value for each data bar (transposed for column vector)
% Note: the latest (current, partial) data bar is ignored
rawValues = (data.high(1:end) + data.low(1:end) + data.close(1:end))'/3;

% Compute the corresponding moving-average vector, for each specified windowSize
for idx = numel(windowSizes) : -1 : 1
    maValues = movavg(rawValues, avgType, windowSizes(idx));
    avgValues(idx) = maValues(end);
end
