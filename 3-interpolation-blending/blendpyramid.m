

function pyramidblend_im = blendpyramid(im,second_im,depth)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% As in the other blend function we resized and crop the inputs image
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

second_size=size(second_im);

im_size=size(im);

horizontalindex=1;


second_resizedimage=imresize(second_im,im_size(1)/second_size(1));
second_resizedsize=size(second_resizedimage);

for index_blendhorizontal = round(im_size(2)/2-second_resizedsize(2)/2)+1: round(im_size(2)/2+second_resizedsize(2)/2)
    
    for index_blendvertical = 1:im_size(1)
        
        for index_matrix=1:im_size(3);
            
            first_im(index_blendvertical,horizontalindex,index_matrix)=im(index_blendvertical,index_blendhorizontal,index_matrix);
            
        end
        
    end
    horizontalindex=horizontalindex+1;
end


first_size=size(first_im);


size_resizedimage=size(second_resizedimage);

second_resizedimage=imresize(second_im,first_size(1)/second_size(1));
size_resizedimage=size(second_resizedimage);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

first_laplacian=genPyr(first_im,'lap',depth); % give the Laplacian pyramid at a certain depth for the first image(0 give back the exact inuput image)
second_laplacian=genPyr(second_resizedimage,'lap',depth); % give the Laplacian pyramid at a certain depth for the second image(0 give back the exact inuput image)


% % % % % % % % % % % % % % % % % % % % %

firstlap_size=size(first_laplacian{1});

maska = zeros(firstlap_size(1),firstlap_size(2),3); %create a blank mask with 3 dimension to correspond to RGB
maska(:,1:first_size(2)/2,:) = 1; %fill the second half of the mask with 1
maskb = 1-maska; %create a maskb wich is the opposite of the first mask

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% For each piramyd depth I add the two image and multiply them at each step
% by their respective mask (resized thanks to a gaussian)
% % % % % % % % % % % % % % % % % % % % % % % % % %

for p = 1:depth
    
    laplace_pyrim{p}=first_laplacian{p}.*maska+second_laplacian{p}.*maskb;
    maska=impyramid(maska, 'reduce');
    maskb=impyramid(maskb, 'reduce');
    
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

pyramidblend_im = pyrReconstruct(laplace_pyrim);

end
