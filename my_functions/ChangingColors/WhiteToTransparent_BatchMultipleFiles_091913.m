%wrote w LL 9/19/13

pdir='/Users/hrzucker/Desktop/Data/RanganathLab/ABCDContext_FirstYrProject/';
sdir=[pdir 'Stimuli/Objects_OkToUse_PngFormat/'];
odir=[pdir 'Stimuli/Objects_OkToUse_MagicWand/']; %This concatenates the
% "project directory" (pdir) with the "output directory" (odir) by using []

fid=fopen([sdir 'imagelist.txt']);
images=textscan(fid,'%s');
fclose(fid);
images=images{1};

[n,p]=mkdir(odir);

for i=1:length(images) 
    [pathname name ext]=fileparts(images{i}); %[] to the left of the equals sign means that when the function finishes, the ouput frm the funciton will be saved into the variables you specified in the sq brackets
    im=imread(images{i});
    A=magicwand(im,1,1,15);
    A=+~A;
%    A=+A; %Changes from a logical to a double matrix)
%     imagesidx=find(im(:,:,1)==255);
%     A=ones(size(im,1),size(im,2));
%     A(imagesidx)=0;
    imwrite(im,[odir name '_nowhite.png'],'Alpha',A)
end
  


