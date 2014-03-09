function [data,varnames] = read_presentation(fname)
% reads a presentation file
%
%[namefordatatooutput, nameforvariablestooutput] = read_presentation(fname);


if nargin < 1 %nargin means number of arguments
    error ('Put in a filename!')
end %if

if ~exist(fname)
    error('Could not find file: %s\n',fname)
end %if

% if want to save out the variables that are read in, must specify what
% values function should return 

% this stuff isn't general enough--we need to contruct the filename OUTSIDE
% of the function
% % Reading a Presentation file
% fpath = 'datafiles';
% fstub = 'presentation.log';
% fname = fullfile(fpath, fstub);

% Open the file for reading
fid = fopen(fname,'rt');
if fid == -1
    error('Could not find file: %s', fname)
end

% Start reading lines from the file
% Loop over all lines in file until we are done
data = {};
nrow = 0;
while ~feof(fid)
    str = fgetl(fid);
    
    % Ignore lines of no interest
    firstStr = strtok(str);
    
    switch firstStr
        case {'Scenario','Logfile','','B'}
            fprintf('Skipping line beginning with %s ...\n', firstStr);
            continue
        otherwise
    end
    
    % Handle our line with variable names
    targStr = 'Subject';
    if strncmp(str, targStr, length(targStr)) 
        varnames = regexp(str,'\t','split');
        
        % Replace whitespace with underscores in our variable names
        varnames = strrep(varnames, ' ', '_');
        nvar = length(varnames);
        
        % Build a formatting string that we will use to read in the data
        fmtstr = '';
        for ivar = 1:nvar
            currVar = varnames{ivar};
            switch currVar
                case {'Subject','Event_Type','Code'}
                    fmtstr = [fmtstr '%s'];
                otherwise
                    fmtstr = [fmtstr '%d'];
            end
            if ivar < nvar
               fmtstr = [fmtstr '\t'];
            else
                fmtstr = [fmtstr '\n'];
            end
        end
        continue
    end
    
    % Everything else should be a data line
    
    % Parse the data based on fmtstr
    tmp = textscan(str,fmtstr);
    nrow = nrow + 1;
    for ivar = 1:nvar
        if ~isempty(tmp{ivar})
            data{ivar}(nrow,1) = tmp{ivar};
        else
            data{ivar}(nrow,1) = NaN;
        end
    end
end



% Close file
fclose(fid);
