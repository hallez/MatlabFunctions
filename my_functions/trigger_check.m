function trigger_check
%% trigger_check
% This script checks the triggers at Skyra to make sure they're working
% correctly and being sent at the right times.
%
% If triggers are working, script will display trigger message with
% timestamp indicating when the trigger was sent from the scanner.
%
% If triggers are NOT working, the script will hang at "Waiting for scanner to trigger..."
%
% Press escape key to quit.
% PTB must be loaded into the path.
%
% MI 07/16/14

    %% Setup
    addpath(genpath('~/Documents/MATLAB/my_functions')) % load in psychtoolbox

    % get Keyboard number
    function k = getKeyboardNumber();
    d=PsychHID('Devices');
    k = 0;
        for n = 1:length(d)
            if strcmp(d(n).usageName,'Keyboard');
                k=n;
                break
            end
        end
    end

    % PTB keyboard variables
    deviceNumber = getKeyboardNumber;
    AssertOpenGL;
    KbName('UnifyKeyNames');
    escapeKey  = KbName('ESCAPE');
    trigger    = KbName('5%');

    %% Start up
    disp('Waiting for scanner to trigger...')

    KbQueueCreate(deviceNumber);
    while KbCheck; end % Wait until all keys are released.

    KbQueueStart(deviceNumber);

    while 1
        % Check the queue for key presses.
        [ pressed, firstPress]=KbQueueCheck(deviceNumber);

        % If trigger registered correctly by PTB, display trigger message
        if pressed
            if firstPress(trigger);
                disp(['--- Trigger sent at ' datestr(now,13)]);
            end

            if firstPress(escapeKey);
                break;
            end
        end
    end
    KbQueueRelease(deviceNumber);
    return
end