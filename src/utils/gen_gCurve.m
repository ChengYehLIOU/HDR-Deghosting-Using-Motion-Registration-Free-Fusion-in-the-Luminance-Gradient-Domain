function g = gen_gCurve(imgs,ishistZ,B,w)
    P = size(imgs,4);
    lamda = 1000;
    sImg_h = 20; sImg_w = 25;
    vertical_bin = 500;
    if ishistZ
       Z = gen_hist_Z(imgs,P,vertical_bin);
    else
       Z = gen_resize_Z(imgs,P,sImg_h,sImg_w);
    end
    [g,~]=mygsolve(Z,B,lamda,w);
    %size(Z)
    
    
end
