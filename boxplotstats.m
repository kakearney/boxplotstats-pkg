function A = boxplotstats(x, whis)
%BOXPLOTSTATS Calculates values used to construct a boxplot
%
% A = boxplotstats(x)
% A = boxplotstats(x, w)
%
% This function calculates the values that are used in a boxplot.
%
% Input variables:
%
%   x:  array of values to be analyzed.  Can be a vector or 2D array; for
%       2D arrays, operations are performed on columns.
%
%   w:  whisker length, i.e. w times interquartile range will define an
%       outlier
%
% Output variables:
%
%   A:  1 x 1 structure holding n x 1 arrays, where n is the number of
%       columns in the input array.  NaNs are ignored for all calculations. 
%
%       min:    minimum value
%
%       lo:     minimum value excluding outliers.  An outlier is defined as
%               any value outside 1.5 times the interquartile range.
%
%       q1:     lower quartile value
%
%       avg:    mean value
%
%       med:    median value
%
%       q3:     upper quartile value
%
%       hi:     maximum value excluding outliers
%
%       max:    maximum value

% Copyright 2008 Kelly Kearney

if nargin == 1
    whis = 1.5;
end

% define the median and the quantiles
pctiles = prctile(x,[25;50;75]);
q1 = pctiles(1,:);
med = pctiles(2,:);
q3 = pctiles(3,:);

% find the extreme values (to determine where whiskers appear)

vhi = q3+whis*(q3-q1);
vlo = q1-whis*(q3-q1);

isouthi = bsxfun(@gt, x, vhi);
isoutlo = bsxfun(@lt, x, vlo);

xtemp = x;
xtemp(isouthi) = NaN;
xtemp(isoutlo) = NaN;

A.min = min(x);
A.lo = min(xtemp);
A.q1 = q1;
A.avg = nanmean(x);
A.med = med;
A.q3 = q3;
A.hi = max(xtemp);
A.max = max(x);

