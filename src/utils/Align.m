function [ source_im] = Align( source_im,target_im,store_path,symmetric)
    o_img = source_im;	
	[y x] = MTB(source_im,target_im,store_path);
	source_im= circshift(source_im,y,1);
    %{
    if y >0
		source_im(1:y,:,:) = repmat(o_img(1,:,:),y,1,1);
	elseif y<0
        source_im(end+y:end,:,:) = repmat(o_img(end,:,:),abs(y)+1,1,1);
    end
    %}
    if symmetric 
        if y >0
            source_im(1:y,:,:) = flip(o_img(1:y,:,:),1);
        elseif y<0
            source_im(end+y:end,:,:) = flip(o_img(end+y:end,:,:),1);
        end
    else
        if y >0
            source_im(1:y,:,:) = 0;
        elseif y<0
            source_im(end+y:end,:,:) = 0;
        end
    end
    
   source_im= circshift(source_im,x,2);

   if symmetric 
        if x > 0
            source_im(:,1:x,:) = flip(o_img(:,1:x,:),2);
        elseif x<0
            source_im(:,end+x:end,:) = flip(o_img(:,end+x:end,:),2);
        end
   else
        if x > 0
            source_im(:,1:x,:) = 0;
        elseif x<0
            source_im(:,end+x:end,:) = 0;
        end
   end    
end

