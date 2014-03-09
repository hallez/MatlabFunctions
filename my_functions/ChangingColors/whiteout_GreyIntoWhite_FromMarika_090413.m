function [] = whiteout()

for k = 1:8
    
    im = imread(['Obj_' num2str(k) '.jpg']);
    
    for i = 1:size(im,1) %loop through rows
        for j = 1:size(im,2) %loop through columns
            if im(i,j,1)>205 && im(i,j,1)<216 && im(i,j,2)>203 && im(i,j,2)<213 && im(i,j,3)>177 && im(i,j,3)<195
                im(i,j,1) = 255;
                im(i,j,2) = 255;
                im(i,j,3) = 255;
            end
        end
    end
    %keyboard;

    imwrite(im, ['corrected_Obj_' num2str(k) '.png'])
end

