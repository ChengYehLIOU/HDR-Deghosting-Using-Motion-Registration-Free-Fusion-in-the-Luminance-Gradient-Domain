function [ img ] = imgColorTransfer( im1,im2)
    
    img = im2double(imhistmatch(uint8(im1),uint8(im2),256));
    img_hist = img;
    
    LV_MAX = ceil(log2(min(size(im1,1),size(im1,2)))) - 5;

    LP = buildLP(im2double(uint8(im1)),LV_MAX);
    LP_test = buildLP(img_hist,LV_MAX);
    LP{end} = LP_test{end};
    out_img = collapse(LP);
  
    out_img = double(uint8(out_img.*255));
   
    img = out_img;
        
end


