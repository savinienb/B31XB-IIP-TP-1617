close all
clear all


lena_im=imread('lena.jpeg');
vibot_im=imread('vibot.jpg');
apple_im=imread('apple1.jpg');
orange_im=imread('orange1.jpg');

figure
subplot(1,3,1)
imshow(blend(lena_im,vibot_im));
title('simple blending');
subplot(1,3,2)
imshow(blendalpha(lena_im,vibot_im,0.5));
title('alpha blending');
subplot(1,3,3)
imshow(blendpyramid(lena_im,vibot_im,5));
title('pyramid blending');
    

figure
subplot(1,3,1)
imshow(blend(apple_im,orange_im));
title('simple blending');
subplot(1,3,2)
imshow(blendalpha(apple_im,orange_im,0.5));
title('alpha blending');
subplot(1,3,3)
imshow(blendpyramid(apple_im,orange_im,5));
title('pyramid blending');

