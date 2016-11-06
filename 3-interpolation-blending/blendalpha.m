

function blend_im = blendalpha(im,second_im,alpha)

second_size=size(second_im); %get the size ofthe second image
im_size=size(im); %get the size of the input image

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% A function to crop the first image by the middle so it be as large as the
% second image
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
horizontalindex=1; %an index that we will use during the cropping
for index_blendhorizontal = round(im_size(2)/2-second_size(2)/2)+1: round(im_size(2)/2+second_size(2)/2)
    
    for index_blendvertical = 1:im_size(1)
        for index_matrix=1:im_size(3);
            
            first_im(index_blendvertical,horizontalindex,index_matrix)=im(index_blendvertical,index_blendhorizontal,index_matrix);
            
        end
        
    end
    horizontalindex=horizontalindex+1;
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

first_size=size(first_im); %get the size of the cropped first input image

second_resizedimage=imresize(second_im,first_size(1)/second_size(1)); %resize the second image as so it become as tall as the first one
size_resizedimage=size(second_resizedimage); %get the size of the second resized image (it now should be the same as first_image)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% this triple loop copy the first half of the first cropped image into the output
% image
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

for index_blendhorizontal = 1 : (round(first_size(2)/2))
    for index_blendvertical = 1:first_size(1)
        for index_matrix=1:first_size(3);
            blend_im(index_blendvertical,index_blendhorizontal,index_matrix)=first_im(index_blendvertical,index_blendhorizontal,index_matrix);
        end
    end
    
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% this double loop copy the second half of the first cropped image multiply by a constant1 + the second resized image multiply by a constant 2.
% constant 1+constant 2=1
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

index_secondhorizontal=first_size(2)/2;
for index_blendhorizontal = (round(first_size(2)/2) : round(first_size(2)))
    
    for index_blendvertical = 1:first_size(1)
        for index_matrix=1:first_size(3);
            
            blend_im(index_blendvertical,index_blendhorizontal,index_matrix)=first_im(index_blendvertical,index_blendhorizontal,index_matrix)*(1-alpha)+second_resizedimage(index_blendvertical,index_secondhorizontal,index_matrix)*alpha;
            
        end
    end
    index_secondhorizontal=index_secondhorizontal+1;
    
end


end
