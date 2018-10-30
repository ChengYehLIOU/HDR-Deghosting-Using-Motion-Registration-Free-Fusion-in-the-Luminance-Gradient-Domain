close all;
clear all;

addpath(genpath('./src'));

tic;

store_path = './result';


scale = 1.0;
dataFolder = './Data';
%datasetName = 'pingpong';
datasetName ='SculptureGardenSequence';


dataFolder = fullfile(dataFolder,datasetName);
[imgs,t,num,info] = readfiles(dataFolder,'jpg',scale);
if strcmp(datasetName,'pingpong')
	erode = 12; 
	dilate = 22;
	Threshold = 11;

elseif strcmp(datasetName,'SculptureGardenSequence')  
	erode = 1; 
	dilate = 4;
	Threshold = 11;
	t = log([1/320, 1/160,1/80,1/40,1/20]);
end
	

dataFolder = fullfile(dataFolder,datasetName);
store_path = fullfile(store_path,datasetName);
    



%%%% luminance weight function for CRF %%%
w = [1/64:1/64:1, ones(1,128), 1:-1/64:1/64];

  
if exist(store_path) == 0
    mkdir(store_path);
end


if ~strcmp(class(imgs(:,:,:,1)) ,'uint8')
    for i = 1:size(imgs,4)
        im = im2double(imgs(:,:,:,i));
        im = uint8(im.*255);
        imgs(:,:,:,i) = im;
    end
    imgs = uint8(imgs);
end

% Reference Selection
    % Select the image with the most well-exposed pixel
        %ref_num = referenceSelection(imgs)
    % Select the middle exposure image
        ref_num = round(size(imgs,4)/2);






ref_img = imgs(:,:,:,ref_num);
aligned_imgs = uint8(zeros(size(imgs)));
disp('start to align images');
for i = 1:size(imgs,4)
    aligned_imgs(:,:,:,i) = Align(imgs(:,:,:,i),ref_img,store_path,1);  
end

%%%%%%%%%
imgs = aligned_imgs;





disp('start to generate gCurve');
g  = gen_gCurve(imgs,1,t,w);


imgs = double(imgs);
CTs = zeros(size(imgs));
G = zeros(size(imgs,1),size(imgs,2),size(imgs,4));

for i = 1:size(imgs,4)
    if i == ref_num
        continue
    end
    
    [G(:,:,i),CTs(:,:,:,i)] = deGhost(imgs(:,:,:,i),imgs(:,:,:,ref_num),t(i),t(ref_num),g,i,ref_num,Threshold,erode,dilate);
    
end
CTs(:,:,:,ref_num) = double(imgs(:,:,:,ref_num));




disp('start Modified Gradient Fusion');
[output_img] = ModifiedGradientFusion(uint8(imgs),CTs,~G,1,ref_num,0.01);
imwrite((output_img),fullfile(store_path,'final_HDR.jpg'));
figure;imshow(output_img);title('Proposed');
