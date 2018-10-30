function [ref_num] = referenceSelection(imgs)
    low_bound = 20;
    upp_bound = 230;

    for i = 1 :size(imgs,4)        
        ycbcr_img = rgb2ycbcr(imgs(:,:,:,i));
        temp = ycbcr_img(:,:,1) > low_bound & ycbcr_img(:,:,1) < upp_bound;
        count(i) = sum(temp(:));
     
    end
    count
    [~,ref_num] = max(count);
end

