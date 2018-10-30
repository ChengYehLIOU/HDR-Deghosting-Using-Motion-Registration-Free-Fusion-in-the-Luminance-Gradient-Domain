function [imgs,B,P,info] = readfiles(folder,extension,scale)
  
  files = dir([folder, '/*.', extension]);
  i = 0;
  extension_candidate{1} =  'jpg';
  extension_candidate{2} =  'tif';
  extension_candidate{3} =  'tiff';
  extension_candidate{4} =  'png';

  
  while isempty(files)
      i = i +1;
      files = dir([folder, '/*.', extension_candidate{i}]);
      extension = extension_candidate{i};
      if i >= 4
          break;
      end
  end
  num = length(files);
  B = zeros(num,1);
%   
%   if max_num == 0
%       num = num;
%   else
%       num = max_num;
%   end
  for i =1:num
 	filename = [folder, '/', files(i).name];
	im = imresize(imread(filename),scale); 
%     im = imrotate(im,90);
    if i == 1
        imgs = (zeros([size(im,1),size(im,2),size(im,3),num]));
        imgs = cast(imgs, class(im));
    end
%     if size(im,1) ~= size(imgs,1)
%         if i == 2
%             im = imrotate(im,-90);
%         else
%             im = imrotate(im,90);
%         end
%     end
	imgs(:,:,:,i) = im;
    
	info = imfinfo(filename,extension);
 
    if ~isfield(info,'DigitalCamera')
        B(i) = 0;
    else
        B(i) = log(info.DigitalCamera.ExposureTime);
    end
     
  end
  P = num;
  
  
end
