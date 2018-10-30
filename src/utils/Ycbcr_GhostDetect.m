function [ Ghost] = Ycbcr_GhostDetect(im_ref,im,THRES,im_ref_o);
    
%%% conver to YCbCrspace %%%
	ycbcr_ref  = double(rgb2ycbcr(uint8(im_ref)));
    ycbcr_n  = double(rgb2ycbcr(uint8(im)));
	
    L_ref = ycbcr_ref(:,:,1);
    L_n = ycbcr_n(:,:,1);
	
%%% Compute Difference %%%
    D = abs(ycbcr_ref(:,:,1) - ycbcr_n(:,:,1));
    
%%% Obtain Ghost Region %%
    Ghost = D >= THRES;
        
     
end

