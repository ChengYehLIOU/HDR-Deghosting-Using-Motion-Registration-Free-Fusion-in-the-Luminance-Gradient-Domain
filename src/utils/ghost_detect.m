function [Ghost]= ghost_detect( im_ref,im,THRES,original_im,erode,dilate,im_ref_o)
	


    %%% Ycbcr ghost detection  %%%
        Ghost = Ycbcr_GhostDetect(im_ref,im,THRES,im_ref_o);
        
    %%% end %%%

 
    %%% Refinement by Morphological Operations %%%
        se = strel('square',erode);
        se2 = strel('square',dilate);
        Ghost = imdilate(imerode(Ghost,se),se2);

        
    %%% end %%%
        
end