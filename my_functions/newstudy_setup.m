function newstudy_setup(newstudyname,labdir,PILOTDATA_FLAG,BEHAV_FLAG,MRI_FLAG)
% creates generic folders for a new behavioral or MRI study
%
% Required input: newstudy_setup(newstudyname,labdir)
% e.g., newstudy_setup('ABCDContext_FirstYrProject/','RanganathLab/')
%
% Optional input: newstudy_setup(newstudyname,labdir,PILOTDATA_FLAG,BEHAV_FLAG,MRI_FLAG)
% e.g., newstudy_setup('ABCDContext_FirstYrProject/','RanganathLab/',1,1,1)
%
% Usage Notes:
% (1) be sure to include '/' after folder names
% (2) the FLAG fields are optional where the default behavior is PILOTDATA_FLAG = 1, 
% BEHAV_FLAG = 1, MRI_FLAG = 0
%
% originally written as part of final project for Petr Janata's matlab
% class Fall 2014; modified 2/6/14, HRZ

%Check to see if flag arguments have been entered. If not, set defaults. 
if nargin < 3
    fprintf('setting PILOTDATA_FLAG to 1\n')
    PILOTDATA_FLAG = 1;
end

if nargin < 4
    fprintf('setting BEHAV_FLAG to 1\n')
    BEHAV_FLAG = 1;
end

if nargin < 5
    fprintf('setting MRI_FLAG to 0\n')
    MRI_FLAG = 0;
end


%% Variables & paths

% Working paths
fprintf('Setting paths\n');

name = getComputerName(); %this is a function downloaded from: http://www.mathworks.com/matlabcentral/fileexchange/16450-get-computer-namehostname

if strcmp(name,'pilots-mac-mini.local') 
    datadir = '/Users/hrzucker/Desktop/Data/';
    workingdir = [datadir labdir];
    newstudydir = [workingdir newstudyname];
elseif strcmp(name,'hallesmacbookair.local')
    datadir = '/Users/hzucker/Desktop/Data/';
    studiesdir = 'Studies/';
    workingdir = [datadir labdir studiesdir];
    newstudydir = [workingdir newstudyname];
end %if

if ~exist(newstudydir,'dir');
    fprintf('Making new directory: %s\n', newstudydir);
    mkdir(newstudydir);
end %if=

%% Create file structure

% create non-data-related study folders
conferences = [newstudydir 'ConferencePresentations/'];
readings = [newstudydir 'RelatedReadings/'];
writeups = [newstudydir 'WriteUps/'];
notes = [newstudydir 'MiscNotes/'];

miscdirs = {conferences, readings, writeups};

for idir=1:length(miscdirs)
    if ~exist(miscdirs{idir},'dir')
        mkdir(miscdirs{idir});
    end %if
end %for idir=

% pilot data folders
pilotdatadir = [newstudydir 'PilotData/'];
pilot_instrucdir = [pilotdatadir 'InstructionsANDForms/'];
pilot_rawbehavdir = [pilotdatadir 'Data_raw/'];
pilot_scoredBehav = [pilotdatadir 'Data_scored/'];
pilot_rtData = [pilot_scoredBehav 'Data_scoredRT/'];
pilot_scoringTemplates = [pilot_scoredBehav 'ScoringTemplates/'];
pilot_statsanal = [pilot_scoredBehav 'StatsAnal/'];
% pilot_stim = [pilotdatadir 'Stimuli/']; %POTENTIALLY JUST FOLDER W/IN NEWSTUDYDIR?
pilot_scripts = [pilotdatadir 'Scripts/'];
%pilot_demog = [pilotdatadir 'DemographicsANDNeuropsych/']; %POTENTIALLY JUST FOLDER W/IN NEWSTUDYDIR?

pilotdirs = {pilotdatadir,pilot_instrucdir,pilot_rawbehavdir,...
    pilot_scoredBehav,pilot_rtData,pilot_scoringTemplates,...
    pilot_statsanal, pilot_stim, pilot_scripts, pilot_demog};
    
if PILOTDATA_FLAG  
    fprintf('Making pilot folders\n')
    for idir=1:length(pilotdirs)
        if ~exist(pilotdirs{idir},'dir')
            mkdir(pilotdirs{idir});
        end %if
    end %for idir=
end %if 


% raw data folders
instrucdir = [newstudydir 'InstructionsANDForms/'];
rawbehavdir = [newstudydir 'Data_raw/'];
stim = [newstudydir 'Stimuli/'];
scoredBehav = [newstudydir 'Data_scored/'];
rtData = [scoredBehav 'Data_scoredRT/'];
demog = [newstudydir 'DemographicsANDNeuropsych/'];
scoringTemplates = [scoredBehav 'ScoringTemplates/'];
statsanal = [scoredBehav 'StatsAnal/'];
scriptsdir = [newstudydir 'Scripts/'];

datadirs = {instrucdir, rawbehavdir, stim, scoredBehav, rtData,...
    demog, scoringTemplates, statsanal, scriptsdir};
    
if BEHAV_FLAG
    fprintf('Making behav folders\n');
    for idir=1:length(datadirs)
        if ~exist(datadirs{idir},'dir')
            mkdir(datadirs{idir});
        end
    end %idir=
end %if

% for MRI study
mridir = [newstudydir 'MRIData/'];
motionSPM = [mridir 'Motion/SPMOutput/'];
motionART = [mridir 'Motion/ARTOutput/'];
contrasts = [mridir 'Contrasts/'];
groupAnal = [mridir 'GroupLevelAnal/'];
montecarlo = [mridir 'MonteCarloSimulations/'];
resultsMRICron = [mridir 'MRICronFiles/'];
roiResults = [mridir 'ROIResutls/'];
screenshots = [mridir 'Screenshots/'];
timingFiles = [mridir 'TimingFiles/'];
mri_rawbehavdir = [mridir 'Data_rawBehav/'];
mri_scoredBehav = [mridir 'Data_scoredBehav/'];
mri_statsanal = [mri_scoredBehav 'StatsAnal/'];
mri_rawdir = [mridir 'Data_rawMRI/'];
mri_scoredRT = [mri_scoredBehav 'Data_scoredRT/'];

mridatadirs = {mridir motionSPM motionART contrasts groupAnal montecarlo...
    resultsMRICron roiResults screenshots timingFiles,...
    mri_rawbehavdir, mri_scoredBehav, mri_statsanal, mri_rawdir,mri_scoredRT};

if MRI_FLAG
    fprintf('Making MRI folders\n');
    for idir=1:length(mridatadirs)
        if ~exist(mridatadirs{idir},'dir')
            mkdir(mridatadirs{idir});
        end %if
    end %idir=
end %if
