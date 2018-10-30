function [out_img] = ModifiedGradientFusion(I,CTs,G,ycbcr,ref_num,clip_limit)



sigpara1 = 2;
sigpara2 = 5;

use_max = 0;
use_wsum  = 1;
use_dilate_ghost = 1;
dilate_max = 20;



N = size(I,4);    

% padding for multigrid Poisson solver %
[I,CTs,G,padded_mask,guard,pad_size_x,pad_size_y] = pad_for_multigrid(I,CTs,G);


%% Transformation of the color images from RGB to YCbCr
for i = 1:N
	I(:,:,:,i)=double(rgb2ycbcr(uint8(I(:,:,:,i))));
	CTs(:,:,:,i) = double(rgb2ycbcr(uint8(CTs(:,:,:,i))));
end



%% Get the Gradients of Luminance and separate the Chrominance
% Preallocate
xH = zeros(size(I,1),size(I,2),N);
yH = xH;

G_w = zeros(size(G));

I_Cb = xH;
I_Cr = I_Cb;
    
    

for i = 1:N
	% Compute gradients of Luminance %
    [xH(:,:,i), yH(:,:,i)] = getGradientH(I(:,:,1,i),1);  
    
	if use_dilate_ghost
		% use linear feathered moving region detection result %
		G_w(:,:,i) = 1-(dilateGhost(not(G(:,:,i)),dilate_max));
	else
		G_w(:,:,i) = G(:,:,i);
	end
	
	% new version of gradient %
    xH(:,:,i) = xH(:,:,i).*G_w(:,:,i);
	yH(:,:,i) = yH(:,:,i).*G_w(:,:,i);
    


        

	% chrominance value from color transferred images %
	I_Cb(:,:,i) = CTs(:,:,2,i);
	I_Cr(:,:,i) = CTs(:,:,3,i);

end

% compute guiding gradient %
if use_max
	% use gradient with max 2-norm %
    [fxH, fyH,pos] = getFusedGradients(xH,yH);
elseif use_wsum
    % use proposed weighted sum gradient %
		
		% sigmoid weight %
		xH_weight = sigmf(abs(xH),[sigpara1,sigpara2]);
		yH_weight = sigmf(abs(yH),[sigpara1,sigpara2]);	
		
		fxH = sum(xH .* xH_weight .* G_w,3) ./ sum(xH_weight .* G_w,3);
        fyH = sum(yH .* yH_weight .* G_w,3) ./ sum(yH_weight .* G_w,3);
        

        % rounding to integer %
        fxH = round(fxH);
        fyH = round(fyH);

else
    disp(' either use_max or use_wsum should be specified');
    return;
end

%% Get the fused Chrominance components by weighted sum

I_Cb128 = abs(double(I_Cb)-128);
I_Cr128 = abs(double(I_Cr)-128);

	 
I_CbNew = sum((I_Cb.*I_Cb128)./repmat(sum(I_Cb128,3),[1 1 N ]),3);
I_CrNew = sum((I_Cr.*I_Cr128)./repmat(sum(I_Cr128,3),[1 1 N ]),3);
	
I_CbNew(isnan(I_CbNew)) = 128;
I_CrNew(isnan(I_CrNew)) = 128;
   



% compute divergence %
L = [0,-1,0;-1,4,-1;0,-1,0];
lap = myDivergence(fxH,fyH);

% apply multigrid poisson solver %
[R,~] = Multigrid_Solver(L,I(:,:,1,ref_num),lap,logical(padded_mask),2,@Jacobi_Iter, 1, 1, 1e-7);

%% Transform the result of Poisson solver to range of 16~235 %
J1 = zeros(size(R(:,:,1)));
K = uint8(ChannelNorm(R(:,:,1),[16 235]));

K(:,:,2) = I_CbNew;
K(:,:,3) = I_CrNew;
K = double(K);
 





% crop to original size %
guard = guard * 2;      
K = K(guard+1:end-guard-pad_size_y,guard+1:end-guard-pad_size_x,:); 

%Adaptive histogram equalization on Y channel%
O = (K(:,:,1)-min(min(K(:,:,1))))/(max(max(K(:,:,1)))-min(min(K(:,:,1))));        
O = adapthisteq(O,'NumTiles',[8 8],'ClipLimit',clip_limit)*219+16;

K(:,:,1) = uint8(O);


% convert final image from YCbCr back to RGB %
out_img = ycbcr2rgb(uint8(K));
	
        


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function div = myDivergence(fxH,fyH)
div = circshift(fxH,[0,1]) + circshift(fyH,[1,0]) - fxH - fyH;
div(1,:) = div(2,:);
div(:,1) = div(:,2);


