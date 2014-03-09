%% Demographics

% ASK PETR ABOUT FORMATTING OF DEMOGRAPHICS FILE (EVENTUALLY JUST MANUALLY
% TYPED IN TEXTWRANGLER

    demo_fname = fullfile(newstudydir, demog,'DML_Demographics.txt');
    demo = tdfread(demo_fname);
    demo.Sex = cellstr(demo.Sex);
    demo.Hispanic = cellstr(demo.Hispanic);
    demo.Race = cellstr(demo.Race);
    demo.Experiment = cellstr(demo.Experiment);
    nsub = length(demo.SubjectID);
    
if DEMOG_FLAG
    fprintf('\nCalculating demographics.\n');
    %initialize empty variables
    ethnic_demog = zeros(4,1,4);
    racial_demog = zeros(8,1,4);
    hisp_racial_demog = zeros(8,1,4);
    %masks by gender
    femaleMask = ismember(demo.Sex,'F');
    maleMask = ismember(demo.Sex,'M');
    nogenderMask = ismember(demo.Sex,' ');
    genderhdr = 'Female\tMale\tNonReported\n';
    %masks by ethnicity
    hispanicMask = ismember(demo.Hispanic,'Yes');
    nonhispanicMask = ismember(demo.Hispanic,'No');
    noethMask = ismember(demo.Hispanic,' ');
    %masks by race
    asianMask = ismember(demo.Race,'Asian');
    nativeAmerMask = ismember(demo.Race,'AmericanIndian');
    pacificIslMask = ismember(demo.Race,'PacificIslander');
    blackMask = ismember(demo.Race,'Black');
    whiteMask = ismember(demo.Race,'White');
    noraceMask = ismember(demo.Race,'');
    multipleraceMask = ismember(demo.Race,'MoreThanOne'); %% how would you deal w this from the actual subj responses? (ie, not my manually entered ones) logical |?

    % Demographics by ethnicity
    %females
    ethnic_demog(1,1,1) = sum(femaleMask & hispanicMask);
    ethnic_demog(2,1,1) = sum(femaleMask & nonhispanicMask);
    ethnic_demog(3,1,1) = sum(femaleMask & noethMask);
    ethnic_demog(4,1,1) = sum(ethnic_demog(1:3,1,1));
    %males
    ethnic_demog(1,1,2) = sum(maleMask & hispanicMask);
    ethnic_demog(2,1,2) = sum(maleMask & nonhispanicMask);
    ethnic_demog(3,1,2) = sum(maleMask & noethMask);
    ethnic_demog(4,1,2) = sum(ethnic_demog(1:3,1,2));
    %no gender reported
    ethnic_demog(1,1,3) = sum(nogenderMask & hispanicMask);
    ethnic_demog(2,1,3) = sum(nogenderMask & nonhispanicMask);
    ethnic_demog(3,1,3) = sum(nogenderMask & noethMask);
    ethnic_demog(4,1,3) = sum(ethnic_demog(1:3,1,3));
    % all subjs
    ethnic_demog(1,1,4) = sum(ethnic_demog(1,1,1:3));
    ethnic_demog(2,1,4) = sum(ethnic_demog(2,1,1:3));
    ethnic_demog(3,1,4) = sum(ethnic_demog(3,1,1:3));
    ethnic_demog(4,1,4) = sum(ethnic_demog(4,1,1:3));

    fprintf('There are %d participants.\n', nsub);
    fprintf('\nDemographics split by ethnicity:\n');
    if ethnic_demog(1,1,4) == 0 %%WOULD HAVE BEEN BETTER IN A FOR LOOP SINCE DOING THE SAME PRINTING OVER AND OVER??
        fprintf('There are %d Hispanic participants\n',ethnic_demog(1,1,4)); 
    elseif ethnic_demog(1,1,4) == 1
        fprintf('There is %d Hispanic participant\n',ethnic_demog(1,1,4));
        fprintf(genderhdr); 
        fprintf('%d\t%d\t%d\n',ethnic_demog(1,1,1),ethnic_demog(1,1,2),ethnic_demog(1,1,3)); 
    else
        fprintf('There are %d Hispanic participants\n',ethnic_demog(1,1,4));
        fprintf(genderhdr); 
        fprintf('%d\t%d\t%d\n',ethnic_demog(1,1,1),ethnic_demog(1,1,2),ethnic_demog(1,1,3)); 
    end
    
    if ethnic_demog(2,1,4) == 0
        fprintf('There are %d Non-Hispanic participants\n',ethnic_demog(2,1,4));
    elseif ethnic_demog(2,1,4) == 1
        fprintf('There is %d Non-Hispanic participant\n',ethnic_demog(2,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', ethnic_demog(2,1,1),ethnic_demog(2,1,2),ethnic_demog(2,1,3));
    else
       fprintf('There are %d Non-Hispanic participants\n',ethnic_demog(2,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', ethnic_demog(2,1,1),ethnic_demog(2,1,2),ethnic_demog(2,1,3)); 
    end
    
    if ethnic_demog(3,1,4) == 0
        fprintf('There are %d participants with no ethnicity reported\n',ethnic_demog(3,1,4));
    elseif ethnic_demog(3,1,4) == 1
       fprintf('There is %d participant with no ethnicity reported\n',ethnic_demog(3,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', ethnic_demog(3,1,1),ethnic_demog(3,1,2),ethnic_demog(3,1,3));    
    else
        fprintf('There are %d participants with no ethnicity reported\n',ethnic_demog(3,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', ethnic_demog(3,1,1),ethnic_demog(3,1,2),ethnic_demog(3,1,3));
    end 
    
    
    % Demographics by race
    %females
    racial_demog(1,1,1) = sum(femaleMask & asianMask);
    racial_demog(2,1,1) = sum(femaleMask & nativeAmerMask);
    racial_demog(3,1,1) = sum(femaleMask & pacificIslMask);
    racial_demog(4,1,1) = sum(femaleMask & blackMask);
    racial_demog(5,1,1) = sum(femaleMask & whiteMask);
    racial_demog(6,1,1) = sum(femaleMask & noraceMask);
    racial_demog(7,1,1) = sum(femaleMask & multipleraceMask);
    racial_demog(8,1,1) = sum(racial_demog(1:7,1,1));
    %males
    racial_demog(1,1,2) = sum(maleMask & asianMask);
    racial_demog(2,1,2) = sum(maleMask & nativeAmerMask);
    racial_demog(3,1,2) = sum(maleMask & pacificIslMask);
    racial_demog(4,1,2) = sum(maleMask & blackMask);
    racial_demog(5,1,2) = sum(maleMask & whiteMask);
    racial_demog(6,1,2) = sum(maleMask & noraceMask);
    racial_demog(7,1,2) = sum(maleMask & multipleraceMask);
    racial_demog(8,1,2) = sum(racial_demog(1:7,1,2));
    %no gender reported
    racial_demog(1,1,3) = sum(nogenderMask & asianMask);
    racial_demog(2,1,3) = sum(nogenderMask & nativeAmerMask);
    racial_demog(3,1,3) = sum(nogenderMask & pacificIslMask);
    racial_demog(4,1,3) = sum(nogenderMask & blackMask);
    racial_demog(5,1,3) = sum(nogenderMask & whiteMask);
    racial_demog(6,1,3) = sum(nogenderMask & noraceMask);
    racial_demog(7,1,3) = sum(nogenderMask & multipleraceMask);
    racial_demog(8,1,3) = sum(racial_demog(1:7,1,3));
    %all subjs
    racial_demog(1,1,4) = sum(racial_demog(1,1,1:3));
    racial_demog(2,1,4) = sum(racial_demog(2,1,1:3));
    racial_demog(3,1,4) = sum(racial_demog(3,1,1:3));
    racial_demog(4,1,4) = sum(racial_demog(4,1,1:3));
    racial_demog(5,1,4) = sum(racial_demog(5,1,1:3));
    racial_demog(6,1,4) = sum(racial_demog(6,1,1:3));
    racial_demog(7,1,4) = sum(racial_demog(7,1,1:3));
    racial_demog(8,1,4) = sum(racial_demog(8,1,1:3));
    
    fprintf('\nDemographics split by race:\n');
    if racial_demog(1,1,4) == 0
        fprintf('There are %d Asian participants.\n',racial_demog(1,1,4));
    elseif racial_demog(1,1,4) ==1
        fprintf('There is %d Asian participant.\n',racial_demog(1,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(1,1,1),racial_demog(1,1,2),racial_demog(1,1,3));
    else
        fprintf('There are %d Asian participants.\n',racial_demog(1,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(1,1,1),racial_demog(1,1,2),racial_demog(1,1,3));
    end %if
    
    if racial_demog(2,1,4) == 0
        fprintf('There are %d Native American participants.\n',racial_demog(2,1,4));  
    elseif racial_demog(2,1,4) == 1
        fprintf('There is %d Native American participant.\n',racial_demog(2,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(2,1,1),racial_demog(2,1,2),racial_demog(2,1,3));
    else
        fprintf('There are %d Native American participants.\n',racial_demog(2,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(2,1,1),racial_demog(2,1,2),racial_demog(2,1,3));
    end
    
    if racial_demog(3,1,4) == 0
        fprintf('There are %d Pacific Islander participants.\n',racial_demog(3,1,4));
    elseif racial_demog(3,1,4) == 1
        fprintf('There is %d Pacific Islander participant.\n',racial_demog(3,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(3,1,1),racial_demog(3,1,2),racial_demog(3,1,3));
    else
        fprintf('There are %d Pacific Islander participants.\n',racial_demog(3,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(3,1,1),racial_demog(3,1,2),racial_demog(3,1,3)); 
    end
    
    if racial_demog(4,1,4) == 0
       fprintf('There are %d Black/African American participants.\n',racial_demog(4,1,4)); 
    elseif racial_demog(4,1,4) == 1
       fprintf('There is %d Black/African American participant.\n',racial_demog(4,1,4));
       fprintf(genderhdr);
       fprintf('%d\t%d\t%d\n', racial_demog(4,1,1),racial_demog(4,1,2),racial_demog(4,1,3)); 
    else
        fprintf('There are %d Black/African American participants.\n',racial_demog(4,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(4,1,1),racial_demog(4,1,2),racial_demog(4,1,3));
    end
    
    if racial_demog(5,1,4) == 0
        fprintf('There are %d White/Caucasian participants.\n',racial_demog(5,1,4));
    elseif racial_demog(5,1,4) == 1
        fprintf('There is %d White/Caucasian participant.\n',racial_demog(5,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(5,1,1),racial_demog(5,1,2),racial_demog(5,1,3));
    else 
        fprintf('There are %d White/Caucasian participants.\n',racial_demog(5,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(5,1,1),racial_demog(5,1,2),racial_demog(5,1,3));
    end
    
    if racial_demog(6,1,4) == 0
        fprintf('There are %d participants with no race reported.\n',racial_demog(6,1,4));
    elseif racial_demog(6,1,4) == 1
        fprintf('There is %d participant with no race reported.\n',racial_demog(6,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(6,1,1),racial_demog(6,1,2),racial_demog(6,1,3));
    else 
        fprintf('There are %d participants with no race reported.\n',racial_demog(6,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(6,1,1),racial_demog(6,1,2),racial_demog(6,1,3));
    end 
    
    if racial_demog(7,1,4) == 0
        fprintf('There are %d participants of multiple races.\n',racial_demog(7,1,4));
    elseif racial_demog(7,1,4) == 1
        fprintf('There is %d participant of multiple races.\n',racial_demog(7,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(7,1,1),racial_demog(7,1,2),racial_demog(7,1,3));
    else
       fprintf('There are %d participants of multiple races.\n',racial_demog(7,1,4));
        fprintf(genderhdr);
        fprintf('%d\t%d\t%d\n', racial_demog(7,1,1),racial_demog(7,1,2),racial_demog(7,1,3));
    end
       
    
    if ethnic_demog(1,1,4) == 0
        fprintf ('\nThere are no hispanic participants. Skipping hispanic racial calculations.\n');
    else
        fprintf('\nHispanic participants split by race:\n)')
        %Hispanic demographics by race
        %females
        hisp_racial_demog(1,1,1) = sum(femaleMask & asianMask & hispanicMask);
        hisp_racial_demog(2,1,1) = sum(femaleMask & nativeAmerMask & hispanicMask);
        hisp_racial_demog(3,1,1) = sum(femaleMask & pacificIslMask & hispanicMask);
        hisp_racial_demog(4,1,1) = sum(femaleMask & blackMask & hispanicMask);
        hisp_racial_demog(5,1,1) = sum(femaleMask & whiteMask & hispanicMask);
        hisp_racial_demog(6,1,1) = sum(femaleMask & noraceMask & hispanicMask);
        hisp_racial_demog(7,1,1) = sum(femaleMask & multipleraceMask & hispanicMask);
        hisp_racial_demog(8,1,1) = sum(hisp_racial_demog(1:7,1,1));
        %males
        hisp_racial_demog(1,1,2) = sum(maleMask & asianMask & hispanicMask);
        hisp_racial_demog(2,1,2) = sum(maleMask & nativeAmerMask & hispanicMask);
        hisp_racial_demog(3,1,2) = sum(maleMask & pacificIslMask & hispanicMask);
        hisp_racial_demog(4,1,2) = sum(maleMask & blackMask & hispanicMask);
        hisp_racial_demog(5,1,2) = sum(maleMask & whiteMask & hispanicMask);
        hisp_racial_demog(6,1,2) = sum(maleMask & noraceMask & hispanicMask);
        hisp_racial_demog(7,1,2) = sum(maleMask & multipleraceMask & hispanicMask);
        hisp_racial_demog(8,1,2) = sum(hisp_racial_demog(1:7,1,2));
        %no gender reported
        hisp_racial_demog(1,1,3) = sum(nogenderMask & asianMask & hispanicMask);
        hisp_racial_demog(2,1,3) = sum(nogenderMask & nativeAmerMask & hispanicMask);
        hisp_racial_demog(3,1,3) = sum(nogenderMask & pacificIslMask & hispanicMask);
        hisp_racial_demog(4,1,3) = sum(nogenderMask & blackMask & hispanicMask);
        hisp_racial_demog(5,1,3) = sum(nogenderMask & whiteMask & hispanicMask);
        hisp_racial_demog(6,1,3) = sum(nogenderMask & noraceMask & hispanicMask);
        hisp_racial_demog(7,1,3) = sum(nogenderMask & multipleraceMask & hispanicMask);
        hisp_racial_demog(8,1,3) = sum(hisp_racial_demog(1:7,1,3));
        %all subjs
        hisp_racial_demog(1,1,4) = sum(hisp_racial_demog(1,1,1:3));
        hisp_racial_demog(2,1,4) = sum(hisp_racial_demog(2,1,1:3));
        hisp_racial_demog(3,1,4) = sum(hisp_racial_demog(3,1,1:3));
        hisp_racial_demog(4,1,4) = sum(hisp_racial_demog(4,1,1:3));
        hisp_racial_demog(5,1,4) = sum(hisp_racial_demog(5,1,1:3));
        hisp_racial_demog(6,1,4) = sum(hisp_racial_demog(6,1,1:3));
        hisp_racial_demog(7,1,4) = sum(hisp_racial_demog(7,1,1:3));
        hisp_racial_demog(8,1,4) = sum(hisp_racial_demog(8,1,1:3));
        
        if hisp_racial_demog(1,1,4) == 0
            fprintf('There are %d  Hispanic Asian participants.\n',hisp_racial_demog(1,1,4));
        elseif hisp_racial_demog(1,1,4) == 1
            fprintf('There is %d  Hispanic Asian participant.\n',hisp_racial_demog(1,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(1,1,1),hisp_racial_demog(1,1,2),hisp_racial_demog(1,1,3));
        else
          fprintf('There are %d  Hispanic Asian participants.\n',hisp_racial_demog(1,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(1,1,1),hisp_racial_demog(1,1,2),hisp_racial_demog(1,1,3));
          
        end
        
        if hisp_racial_demog(2,1,4) == 0
            fprintf('There are %d Hispanic Native American participants.\n',hisp_racial_demog(2,1,4));
        elseif hisp_racial_demog(2,1,4) == 1
            fprintf('There is %d Hispanic Native American participant.\n',hisp_racial_demog(2,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(2,1,1),hisp_racial_demog(2,1,2),hisp_racial_demog(2,1,3));
        else
           fprintf('There are %d Hispanic Native American participants.\n',hisp_racial_demog(2,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(2,1,1),hisp_racial_demog(2,1,2),hisp_racial_demog(2,1,3));
         
        end
        
        if hisp_racial_demog(3,1,4) == 0
             fprintf('There are %d Hispanic Pacific Islander participants.\n',hisp_racial_demog(3,1,4));
        elseif hisp_racial_demog(3,1,4) == 1
            fprintf('There is %d Hispanic Pacific Islander participant.\n',hisp_racial_demog(3,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(3,1,1),hisp_racial_demog(3,1,2),hisp_racial_demog(3,1,3));
        else 
            fprintf('There are %d Hispanic Pacific Islander participants.\n',hisp_racial_demog(3,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(3,1,1),hisp_racial_demog(3,1,2),hisp_racial_demog(3,1,3));
        end
        
        
        if hisp_racial_demog(4,1,4) == 0
            fprintf('There are %d Hispanic Black/African American participants.\n',hisp_racial_demog(4,1,4));
        elseif hisp_racial_demog(4,1,4) == 1
            fprintf('There is %d Hispanic Black/African American participant.\n',hisp_racial_demog(4,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(4,1,1),hisp_racial_demog(4,1,2),hisp_racial_demog(4,1,3));
        else 
            fprintf('There are %d Hispanic Black/African American participants.\n',hisp_racial_demog(4,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(4,1,1),hisp_racial_demog(4,1,2),hisp_racial_demog(4,1,3));
        end 
        
        
        if hisp_racial_demog(5,1,4) == 0
            fprintf('There are %d Hispanic White/Caucasian participants.\n',hisp_racial_demog(5,1,4));
        elseif hisp_racial_demog(5,1,4) == 1
            fprintf('There is %d Hispanic White/Caucasian participant.\n',hisp_racial_demog(5,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(5,1,1),hisp_racial_demog(5,1,2),hisp_racial_demog(5,1,3));
        else
            fprintf('There are %d Hispanic White/Caucasian participants.\n',hisp_racial_demog(5,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(5,1,1),hisp_racial_demog(5,1,2),hisp_racial_demog(5,1,3)); 
        end 
        
        
        if hisp_racial_demog(6,1,4) == 0
            fprintf('There are %d Hispanic participants with no race reported.\n',hisp_racial_demog(6,1,4));
        elseif hisp_racial_demog(6,1,4) == 1
            fprintf('There is %d Hispanic participant with no race reported.\n',hisp_racial_demog(6,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(6,1,1),hisp_racial_demog(6,1,2),hisp_racial_demog(6,1,3));  
        else
            fprintf('There are %d Hispanic participants with no race reported.\n',hisp_racial_demog(6,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(6,1,1),hisp_racial_demog(6,1,2),hisp_racial_demog(6,1,3)); 
        end 
        
        
        if hisp_racial_demog(7,1,4) == 0
            fprintf('There are %d Hispanic participants of multiple races.\n',hisp_racial_demog(7,1,4));
        elseif hisp_racial_demog(7,1,4) == 1
            fprintf('There is %d Hispanic participant of multiple races.\n',hisp_racial_demog(7,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(7,1,1),hisp_racial_demog(7,1,2),hisp_racial_demog(7,1,3));
        else 
            fprintf('There are %d Hispanic participants of multiple races.\n',hisp_racial_demog(7,1,4));
            fprintf(genderhdr);
            fprintf('%d\t%d\t%d\n', hisp_racial_demog(7,1,1),hisp_racial_demog(7,1,2),hisp_racial_demog(7,1,3)); 
        end 
    end %if
end %if