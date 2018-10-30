function LP= buildLP( im,LV_MAX)
    gauss_pyr = gauss_pyramid(im,LV_MAX);
    LP = lapl_pyramid(gauss_pyr);
    
    %{
    for level = 1:LV_MAX
        %im_G = impyramid(im,'reduce');
        %im_G_expanded = impyramid(im_G,'expand');
        im_G = reduce(im);
        im_G_expanded = expand(im_G);
        size(im_G_expanded)
        size(im)
        %im_G_expanded = imresize(im_G,[size(im,1),size(im,2)],'bicubic');
        LP{level} = (im - im_G_expanded);
        im = im_G;
        %figure;imshow(LP{level}+0.6);
    end
    im_s = im;
    %}
end

