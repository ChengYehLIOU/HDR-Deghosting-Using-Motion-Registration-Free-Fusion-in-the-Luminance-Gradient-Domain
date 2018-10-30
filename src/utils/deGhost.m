function [G_out,new_im21] = deGhost( im1,im2,t1,t2,g,n,ref,Threshold,erode,dilate)
    disp(strcat('start to deGhost image',num2str(n)));

    new_im1 = double(reExposure(im1,g,t2-t1));
    new_im21 = double(reExposure(im2,g,t1-t2));
      
    new_im21 = imgColorTransfer(new_im21,im1);

    if n < ref  
        
        new_im1 = imgColorTransfer(new_im1,im2); 
        [G12] = ghost_detect(im2,new_im1,Threshold,im1,erode,dilate,im2);

    else
        
        [G12] = ghost_detect(new_im21,im1,Threshold,im1,erode,dilate,im2);

    end
 
    LDR = double(im1);
    G_out = G12(:,:,1);


end

