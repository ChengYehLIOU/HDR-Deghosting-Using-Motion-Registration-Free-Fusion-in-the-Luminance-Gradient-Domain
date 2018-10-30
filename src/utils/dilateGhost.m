function [Ghost_w] = dilateGhost( Ghost,blend_max)  
	%{
    tic;
    Ghost_w = double(Ghost(:,:,1));    
	Ghost_out = ~Ghost(:,:,1);
	se = strel('diamond',1);
	Ghost_edge = edge(uint8(Ghost(:,:,1).*255));
	Ghost_w(Ghost_edge) = 1.0;
	for zone = 1:blend_max
		Ghost_edge_dilate = imdilate(Ghost_edge,se);
		Ghost_new_dilate = and(and(Ghost_out,Ghost_edge_dilate),~Ghost_edge);
		Ghost_w(Ghost_new_dilate) = 1.0 - zone/blend_max;
		Ghost_out = Ghost_w == 0;
		Ghost_edge = Ghost_new_dilate;
    end
    disp('original for loop');
    toc;
    %}

    dist = bwdist(Ghost);
    dist(dist>blend_max) = blend_max;
    dist = dist./(blend_max);
    

    
    Ghost_w = 1-dist;
    
end

