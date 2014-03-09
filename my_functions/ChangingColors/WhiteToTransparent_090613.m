%function [] = whiteout(). Marika's code--commented out. Names the
%function. 

%for k = 1:8 %I commented this out of Marika's code because I didn't want
%it to repeat over numbers. Can rename images something like Obj1_ etc. 
    
    %im = imread(['Obj_' num2str(k) '.jpg']); %again, commented out. 
    
     im = imread('duck_previewcreated.png');
    
    
    %for i = 1:size(im,1) %loop through rows. Marika's code--commented out.
    %
        %for j = 1:size(im,2) %loop through columns. Marika's code--commented out.
            %if im(i,j,1)==255 && im(i,j,1)==255 && im(i,j,2)==255 && im(i,j,2)==255 && im(i,j,3)==255 && im(i,j,3)==255. Marika's code--commented out. This looks for each value of 255 w/in the image.  
                [M,N,O] = size(im)
                A = ones(M,N);
                for i=1:M
                    for j=1:N
                        if im(i,j,1)==255 && im(i,j,1)==255 && im(i,j,2)==255 && im(i,j,2)==255 && im(i,j,3)==255 && im(i,j,3)==255 %find other values and set w/in range. use data cursor (to get there, in matlab imagesc(duck) tools data cursor). 
                            A(i,j) = 0;
                            %A(i,j,2) = 1;
                            %A(i,j,3) = 1;
                        end
                    end
                end
                imwrite(im, 'duck_nowhite.png','Alpha',A)
                
                %im(i,j,1) = 255; Marika's code--commented out
                %im(i,j,2) = 255;
                %im(i,j,3) = 255;
            %end
        %end
    %end
    %keyboard;

    %imwrite(im, ['corrected_Obj_' num2str(k) '.png']) %commented out of
    %Marika's code, but will need something like this to say 
%end Marika's code--commented out. Ends the function. 

