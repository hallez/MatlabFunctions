%drift_lin_trend
%Use: to regress out linear drift from each run in a concatenated
%timeseries.
%Enter: a number for each run in concatenated timeseries; enter number of
%TR's for each run
%Output: txt file called trend_drift.txt; contains a regressor (i.e., column)
%for each run, with a linear trend corresponding to scans in that run and padded with
%zeros. 
%In SPM: Enter this file as a user specified regressor during the modelling step.
%nb: Code modified from a portion of an SPM batch script by Itamar Kahn
%DRA 04/06/06

scan_dirs=str2num(input('Enter number for each run (e.g., 1 2 3 or 1:3):  ','s'));
    
shift=str2num(input('Enter number of TRs for each run (e.g., 312 312 312):  ','s')); 

trend = [];
factor = [];

for i=1:length(scan_dirs),
   if (i-1 >= 1),
     before_zeros = zeros(1,sum(shift(1:i-1)));
   else
     before_zeros = [];
   end

   if (i+1 <= length(scan_dirs))
     after_zeros = zeros(1,sum(shift(i+1:end)));
   else
     after_zeros = [];
   end
   trend =  [trend  ; [before_zeros linspace(-1,1,shift(i)) after_zeros]];
   if (i < length(scan_dirs))
     factor = [factor ; [before_zeros ones(1,shift(i)) after_zeros]];
   end
end

trend_col=trend'

save trend_drift.txt trend_col -ascii;
