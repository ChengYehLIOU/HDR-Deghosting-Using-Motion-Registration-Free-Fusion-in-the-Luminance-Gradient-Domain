function Z = gen_hist_Z(imgs,P,vertical_bin)
    bin = 256;
    hists = zeros(bin,size(imgs,3),P);
    for channel = 1:size(imgs,3)	
        for i = 1:P
            hists(:,channel,i) = cumsum(imhist(imgs(:,:,channel,i),bin));
            hists(:,channel,i) = hists(:,channel,i)/max(hists(:,channel,i));
        end
    end

    %vertical_bin = 300;
    Z = zeros(vertical_bin,P,3);

    for i = 1:vertical_bin
        for channel = 1:3
            for j = 1:P
                temp = find(hists(:,channel,j)>= (i/vertical_bin));

                if ~isempty(temp)
                    Z(i,j,channel) = min(temp)-1;
                else
                    Z(i,j,channel) = 0;
                end
            end
        end
    end
end
