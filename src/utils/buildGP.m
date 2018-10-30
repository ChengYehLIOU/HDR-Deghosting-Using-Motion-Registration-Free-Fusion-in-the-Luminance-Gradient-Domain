function [ GP] = buildGP( im,LV_MAX)
    GP{1} = im;
    for level = 2:LV_MAX+1
        im_G = impyramid(im,'reduce');
        GP{level} = im2double(im_G);
        im = im_G;
        %figure;imshow(im);
    end
end

