%%Iterates over a series of pictures (imagelist.txt), removes white
%backgrounds and replaces with transparent. Can set to iterate through a
%variety of "tolerances" because edges contrast varies for images. 


%wrote w LL 9/19/13
%HRZ edited 9/19/13 to play w starting position
%edited w RMD 9/21/13 to go over entire image [1:256] and play with various levels of tolerance tol=0:50:300
%cleaned up 9/24/13 to remove old bits of code that used while testing
%script


%DO THESE THINGS FIRST:
%CREATE THE IMAGELIST FILE (in Terminal):
%cd
%/Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/Stimuli/Objects_OkToUse_MagicWand/
%(or wherever to-be-converted files are)
%ls *.png > imagelist.txt

%DOWNLOAD MAGIC WAND MATLAB PROGRAM
%http://www.mathworks.com/matlabcentral/fileexchange/4698-simulating-photoshops-magic-wand-tool

currentwkspc=(pwd); %define current directory (where script is, probably) so can return to this when finished

pdir='/Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/'; %pdir = project directory

sdir=[pdir 'Stimuli/Objects_OkToUse_PngFormat/']; %sdir = stimuli directory

odir=[pdir 'Stimuli/Objects_OkToUse_Tolerance0to300/']; %odir = output directory

cd(sdir)  %change to directory where the files are located

fid=fopen([sdir 'imagelist.txt']); %sets a "file ID" to open the imagelist.txt
images=textscan(fid,'%s'); %read in the list of names in this file so that they're images
fclose(fid); %close the FID from memory
images=images{1}; %changes the images matrix from a nX1 matrix to a 1Xn so that each filename gets its own row.

[n,p]=mkdir(odir); %[n,p] dead local store


for i=1:length(images) %iterate over all of the images in imagelist.txt
    [pathname name ext]=fileparts(images{i}); %[] to the left of the equals sign means that when the function finishes, the ouput frm the funciton will be saved into the variables you specified in the sq brackets
    im=imread(images{i});
    for tol=0:50:300 %Tolerance is a setting w/in the magicwand script. COULD PROBABLY CHANGE TO 0:25:200 
        A=magicwand(im,[1 256],[1 256],tol); %look within all pixels from both y ([1 265]) and x ([1 256]) directions while iterating over the various tolerance levels set by tol.
        A=+~A; %~ Replaces 1s with 0s and vice versa. + Changes from a logical to a double matrix.
        imwrite(im,[odir name '_' num2str(tol) '.png'],'Alpha',A); %Write out these images using the magicwand output saved into matrix A to create your alpha map. 
    end
    disp([num2str(i) ' of ' num2str(length(images))]); %print progress in Matlab window. 
end
cd(currentwkspc); %change back to working directory when script was first executed. 
  


