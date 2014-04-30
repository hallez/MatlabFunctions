%% function [] = RSA_ITI
% Edited code from Maureen, creates jitters.
%
% Mean is 4000 ms but range is from 2000ms to 8000 ms -- these are
% hardcoded below and will need to be changed for different studies
%
% MCI 09/01/13, more edits HRZ 04/29/14 

function [] = RSA_ITI_Ritchey

savedir = input('Savedir: ');
trial_no = input('Number of trials per run: '); % input number of trials in each run

jitflag = 1;
while jitflag == 1
    jitters = exprnd(2000,trial_no,1);
    if max(jitters) < 8000, jitflag = 0; end % ensure all jitters < 10s
end
jitters = jitters + 2000;
jitters = round(jitters);
hist(jitters,20);

ITI = jitters-(mean(jitters)-4000);

save([savedir '/ABCDCon_jitter.mat'],'ITI');

end