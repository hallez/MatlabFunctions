%wrote w LL 9/19/13
%HRZ edited to not use magic wand

%DO THIS IN TERMINAL TO CREATE THE IMAGELIST FILE:
%cd
%/Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/Stimuli/Objects_OkToUse_MagicWand/
%(or wherever to-be-converted files are)
%ls *.png > imagelist.txt


pdir='/Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/'; %project directory
sdir=[pdir 'Stimuli/Objects_OkToUse_MagicWand/']; %stimuli directory
odir=[pdir 'Stimuli/Objects_OkToUse_MWThenElim255/']; %This concatenates the
% "project directory" (pdir) with the "output directory" (odir) by using []

cd /Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/Stimuli/Objects_OkToUse_MagicWand/ %change to directory where the files are located

fid=fopen([sdir 'imagelist.txt']);
images=textscan(fid,'%s');
fclose(fid);
images=images{1};

[n,p]=mkdir(odir);

for i=1:length(images) 
    [pathname name ext]=fileparts(images{i}); %[] to the left of the equals sign means that when the function finishes, the ouput frm the funciton will be saved into the variables you specified in the sq brackets
    im=imread(images{i});
    %A=magicwand(im,1,1,15);
    %A=+~A; %~ Replaces 1s with 0s and vice versa. 
    %A=+A; %Changes from a logical to a double matrix)
    imagesidx=find(im(:,:,1)==255);
    A=ones(size(im,1),size(im,2));
    A(imagesidx)=0;
    imwrite(im,[odir name '_no255.png'],'Alpha',A)
end
  


