function best_seq = optseq3()
% http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency
% Each ITI precedes follows the corresponding stimulus.
% Each row of the design matrix corresponds to a second.
%
% Creates jitters for learning portion of RewCon experiment
%
% MarikaCI with help from ChrisPS 09/08/13

nconds = 16; % number of conditions
nrepeats = 3; % number of times each condition is repeated in each run
n = nconds*nrepeats;
len_cond = 2; % in seconds. Only considering the first 1/3 of 6 second trial, and adding the rest to the ITI
niter = 1000;

%Generate very orderly sequence of ITIs, to be randomized later.
ITI_opts = [2; 3; 4] + 4; % specify what other ITI lengths you want -- adding 4 to each ITI to cover the last 2/3 of 6 second trial
orderly_ITI_seq = repmat(ITI_opts, [n/3, 1]);

eff = nan(niter,1); %initializing vector of efficiencies (each element corresponding to an iteration)
max_eff = 0;



%Go through iterations
for iter = 1:niter
    
    %Randomize order of ITIs
    ITI_seq = orderly_ITI_seq(randperm(n));
    
    %Randomize order of conds, with constraint that all 16 be randomized in
    %groups (i.e. conds 1:16;1:16;1:16)
    cond_seq = nan(n,1); %initializing
    not_good = 1;
    while not_good == 1;
        for i = 1:nrepeats
            cond_seq((i-1)*nconds+1:i*nconds) = randperm(nconds);
        end
        if sum(diff(cond_seq)==0)==0
            not_good = 0;
        end
    end    
    if (sum(diff(cond_seq)==0))==0
    else
        error('bad')
    end% super make sure that there are no immediate repeats of the same condition
 
    %Put everything in a design matrix, X
    start_times = cumsum(ITI_seq) - ITI_seq(1) + cumsum(len_cond*ones(n,1)) - len_cond;
    cooldown = 8;
    nsec = sum(ITI_seq) + len_cond*n + cooldown; %Sum of all ITIs plus sum of all trial durations plus cooldown
    X = zeros(nsec, nconds);
    for i = 1:n
        X(start_times(i)+1:start_times(i)+len_cond, cond_seq(i)) = 1;
    end
    
    %Convolve design matrix with canonical HRF
    t = 0:nsec;
    hrf = gampdf(t,6,1)'-gampdf(t,16,1)'/6;
    X_conv = conv2sep(X,1,hrf);
    X_conv = X_conv(1:nsec,:); %truncating extra pad from full convolution
    X_conv = X_conv - repmat(mean(X_conv), [size(X_conv,1) 1]); %centering regressors
    
    %Get efficiency for this iteration. Only considers your condition
    %parameter estimates. Does not take into account your contrast matrix.
    eff(iter) = 1/trace(inv(X_conv'*X_conv));
    if eff(iter)>max_eff
        max_eff = eff(iter);
        best_seq = {cond_seq, ITI_seq, X};
    end
end

best_seq


hist(eff)