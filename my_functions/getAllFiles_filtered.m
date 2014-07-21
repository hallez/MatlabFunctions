% This function emulates SPM's file selector. 
%
% Author: Maureen Ritchey
function [fileList filteredList] = getAllFiles_filtered(dirName, extfilter, prefilter)

if nargin<3
    prefilter_flag = 0; prefilter = '';
else
    prefilter_flag = 1;
end

dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files

if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
        fileList,'UniformOutput',false);
end
subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
validIndex = ~ismember(subDirs,{'.','..'});  %# Find index of subdirectories
%#   that are not '.' or '..'
for iDir = find(validIndex)                  %# Loop over valid subdirectories
    nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
    fileList = [fileList; getAllFiles_filtered(nextDir,extfilter,prefilter)];  %# Recursively call getAllFiles
end

filteredList = {};
for i=1:length(fileList)
    [path name ext] = fileparts(fileList{i});
    if prefilter_flag==1 & strfind(name,prefilter)==1 & strfind(ext,extfilter) & ~strncmp(name,'._',2) %filter by prefix & extension avoiding system files
        filteredList = [filteredList; fileList{i}];
    elseif prefilter_flag==0 & strfind(ext,extfilter) & ~strncmp(name,'._',2) %filter by extension avoiding system files
        filteredList = [filteredList; fileList{i}];
    end
end
    
end