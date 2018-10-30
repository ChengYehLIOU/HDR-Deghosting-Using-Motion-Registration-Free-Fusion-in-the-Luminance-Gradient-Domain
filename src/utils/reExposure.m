function [output_img] = reExposure( im,g,exp_diff )
	new_im = zeros(size(im,1),size(im,2),size(im,3));
    output_img = zeros(size(im,1),size(im,2),size(im,3));
    %tic;
    %{
    for channel = 1:size(im,3)
        temp = im(:,:,channel);
        for i = 0:size(g,1) -1
            temp(temp == i) = g(i+1,channel);
        end
        new_im(:,:,channel ) = temp;
    end
    %}
    
    x = 0:size(g,1)-1;
    x = x';
    % map intensity to radiance by g
    %{
  
    
    
    for channel = 1:size(im,3)
        new_im(:,:,channel) = interp1(x,g(:,channel),im(:,:,channel));
    end
    

    for channel = 1:size(im,3)
        temp = g(:,channel);
        new_im(:,:,channel) = temp(im(:,:,channel)+1);
    end
    %}
    % easiest way
    new_im = g(im+1);
    
    % add exposure difference
    new_im = new_im + exp_diff;
  
    
    EXCEED_MAX = zeros(size(new_im,1),size(new_im,2),size(new_im,3));
    for channel = 1:size(im,3)
         %output_img(:,:,channel) = interp1(g(:,channel),x,new_im(:,:,channel),'spline');
         %output_img(:,:,channel) = interp1(g(:,channel),x,new_im(:,:,channel),'nearest');
         output_img(:,:,channel) = interp1(g(:,channel),x,new_im(:,:,channel),'pchip','extrap');
         EXCEED_MAX(:,:,channel) = new_im(:,:,channel) > g(256,channel);
    end
    output_img(logical(EXCEED_MAX)) = 255;
    output_img(isnan(output_img)) = size(g,1) - 1;
    
    output_img = uint8(output_img);
    %toc;
    %{
    
    for channel = 1:size(im,3)
        temp = new_im(:,:,channel);
        temp(temp>g(256,channel)) = 255;
        tt = temp;
        for i = 0:255
            tt(abs(temp - g(i+1,channel))< epsilon ) = i;
        end
        tt(tt<g(1,channel)) = 0; 
        new_im(:,:,channel ) = tt;
    end
    
    sum(sum(sum(new_im ~= output_img)))
    %}
    
end
