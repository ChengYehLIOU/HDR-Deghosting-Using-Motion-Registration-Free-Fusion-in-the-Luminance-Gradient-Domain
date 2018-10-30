%function [motion_m, motion_n] = MTB(A, B)
function [motion_m, motion_n] = MTB(A, B,store_path)
    [w, h, chnl] = size(A);
    %imshow(uint8(A));
    A = uint8(A);
    B = uint8(B);
    A_gray = rgb2gray(A);
    B_gray = rgb2gray(B);
   % imshow(A_gray);
    A_gray_2 = imresize(A_gray, 1/2, 'bilinear');
    B_gray_2 = imresize(B_gray, 1/2, 'bilinear');
    A_gray_4 = imresize(A_gray, 1/4, 'bilinear');
    B_gray_4 = imresize(B_gray, 1/4, 'bilinear');
    A_gray_8 = imresize(A_gray, 1/8, 'bilinear');
    B_gray_8 = imresize(B_gray, 1/8, 'bilinear');
    A_gray_16 = imresize(A_gray, 1/16, 'bilinear');
    B_gray_16 = imresize(B_gray, 1/16, 'bilinear');
    A_gray_32 = imresize(A_gray, 1/32, 'bilinear');
    B_gray_32 = imresize(B_gray, 1/32, 'bilinear');
    M_A = median(A_gray(:));
    M_B = median(B_gray(:));
    M_A_2 = median(A_gray_2(:));
    M_B_2 = median(B_gray_2(:));
    M_A_4 = median(A_gray_4(:));
    M_B_4 = median(B_gray_4(:));
    M_A_8 = median(A_gray_8(:));
    M_B_8 = median(B_gray_8(:));
    M_A_16 = median(A_gray_16(:));
    M_B_16 = median(B_gray_16(:));
    M_A_32 = median(A_gray_32(:));
    M_B_32 = median(B_gray_32(:));
    MTB_A = A_gray > M_A; 
    MTB_B = B_gray > M_B;
    MTB_A_2 = A_gray_2 > M_A_2;
    MTB_B_2 = B_gray_2 > M_B_2;
    MTB_A_4 = A_gray_4 > M_A_4;
    MTB_B_4 = B_gray_4 > M_B_4;
    MTB_A_8 = A_gray_8 > M_A_8;
    MTB_B_8 = B_gray_8 > M_B_8;
    MTB_A_16 = A_gray_16 > M_A_16;
    MTB_B_16 = B_gray_16 > M_B_16;
    MTB_A_32 = A_gray_32 > M_A_32;
    MTB_B_32 = B_gray_32 > M_B_32;
    
    Et = 1;
    E_A = ~((A_gray <= M_A+Et) & (A_gray >= M_A-Et));
    E_B = ~((B_gray <= M_B+Et) & (B_gray >= M_B-Et));
    E_A_2 = ~((A_gray_2 <= M_A_2+Et) & (A_gray_2 >= M_A_2-Et));
    E_B_2 = ~((B_gray_2 <= M_B_2+Et) & (B_gray_2 >= M_B_2-Et));
    E_A_4 = ~((A_gray_4 <= M_A_4+Et) & (A_gray_4 >= M_A_4-Et));
    E_B_4 = ~((B_gray_4 <= M_B_4+Et) & (B_gray_4 >= M_B_4-Et));
    E_A_8 = ~((A_gray_8 <= M_A_8+Et) & (A_gray_8 >= M_A_8-Et));
    E_B_8 = ~((B_gray_8 <= M_B_8+Et) & (B_gray_8 >= M_B_8-Et));
    E_A_16 = ~((A_gray_16 <= M_A_16+Et) & (A_gray_16 >= M_A_16-Et));
    E_B_16 = ~((B_gray_16 <= M_B_16+Et) & (B_gray_16 >= M_B_16-Et));
    E_A_32 = ~((A_gray_32 <= M_A_32+Et) & (A_gray_32 >= M_A_32-Et));
    E_B_32 = ~((B_gray_32 <= M_B_32+Et) & (B_gray_32 >= M_B_32-Et));

    %{
    
    imwrite(uint8(MTB_A.*255),fullfile(store_path,'A1.jpg'));
    imwrite(uint8(MTB_A_2.*255),fullfile(store_path,'A2.jpg'));
    imwrite(uint8(MTB_A_4.*255),fullfile(store_path,'A4.jpg')); 
    imwrite(uint8(MTB_A_8.*255),fullfile(store_path,'A8.jpg'));
    imwrite(uint8(MTB_A_16.*255),fullfile(store_path,'A16.jpg'));
    imwrite(uint8(MTB_A_32.*255),fullfile(store_path,'A32.jpg'));
    
    
    
    imwrite(uint8(MTB_B.*255),fullfile(store_path,  'B1.jpg'));
    imwrite(uint8(MTB_B_2.*255),fullfile(store_path,'B2.jpg'));
    imwrite(uint8(MTB_B_4.*255),fullfile(store_path,'B4.jpg')); 
    imwrite(uint8(MTB_B_8.*255),fullfile(store_path,'B8.jpg'));
    imwrite(uint8(MTB_B_16.*255),fullfile(store_path,'B16.jpg'));
    imwrite(uint8(MTB_B_32.*255),fullfile(store_path,'B32.jpg'));
    %}
    
%     E_A = ~((A_gray < M_A+Et) & (A_gray > M_A-Et));
%     E_B = ~((B_gray < M_B+Et) & (B_gray > M_B-Et));
%     E_A_2 = ~((A_gray_2 < M_A_2+Et) & (A_gray_2 > M_A_2-Et));
%     E_B_2 = ~((B_gray_2 < M_B_2+Et) & (B_gray_2 > M_B_2-Et));
%     E_A_4 = ~((A_gray_4 < M_A_4+Et) & (A_gray_4 > M_A_4-Et));
%     E_B_4 = ~((B_gray_4 < M_B_4+Et) & (B_gray_4 > M_B_4-Et));
%     E_A_8 = ~((A_gray_8 < M_A_8+Et) & (A_gray_8 > M_A_8-Et));
%     E_B_8 = ~((B_gray_8 < M_B_8+Et) & (B_gray_8 > M_B_8-Et));
%     E_A_16 = ~((A_gray_16 < M_A_16+Et) & (A_gray_16 > M_A_16-Et));
%     E_B_16 = ~((B_gray_16 < M_B_16+Et) & (B_gray_16 > M_B_16-Et));
%     E_A_32 = ~((A_gray_32 < M_A_32+Et) & (A_gray_32 > M_A_32-Et));
%     E_B_32 = ~((B_gray_32 < M_B_32+Et) & (B_gray_32 > M_B_32-Et));

    min_m_1 = 0;
    min_n_1 = 0;
    min_m_2 = 0;
    min_n_2 = 0;
    min_m_4 = 0;
    min_n_4 = 0;
    min_m_8 = 0;
    min_n_8 = 0;
    min_m_16 = 0;
    min_n_16 = 0;
    min_m_32 = 0;
    min_n_32 = 0;
    
    %-------------------------scale 32 --------------------------------
    [w_32, h_32] = size(MTB_A_32);

    MTB_A_32_temp = MTB_A_32(3:w_32-2,3:h_32-2);
    for m = -1:1
        for n = -1:1
           MTB_B_32_temp = MTB_B_32(3+m : w_32-2+m, 3+n : h_32-2+n);
           temp = xor(MTB_A_32_temp, MTB_B_32_temp);
           E = (E_A_32&E_B_32);
           E = E(3+m : w_32-2+m, 3+n : h_32-2+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1 && n == -1
               temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              min_m_32 = m;
              min_n_32 = n;
              temp_min = temp_sum;
           end
        end
    end
  
    %-------------------------scale 32 --------------------------------
    
    %-------------------------scale 16 --------------------------------
    
    [w_16, h_16] = size(MTB_A_16);

    MTB_A_16_temp = MTB_A_16(5:w_16-4,5:h_16-4);
    for m = -1+min_m_32*2 : 1+min_m_32*2
        for n = -1+min_n_32*2 : 1+min_n_32*2
           MTB_B_16_temp = MTB_B_16(5+m : w_16-4+m, 5+n : h_16-4+n);
           temp = xor(MTB_A_16_temp, MTB_B_16_temp);
           E = (E_A_16&E_B_16);
           E = E(5+m : w_16-4+m, 5+n : h_16-4+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1+min_m_32*2 && n == -1+min_n_32*2
               temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              min_m_16 = m;
              min_n_16 = n;
              temp_min = temp_sum;
           end
        end
    end
    %min_m_16 = min_m_16 - (min_m_32);
    %min_n_16 = min_n_16 - (min_n_32);
    %-------------------------scale 16 --------------------------------
    
    %-------------------------scale 8 --------------------------------
    
    [w_8, h_8] = size(MTB_A_8);

    MTB_A_8_temp = MTB_A_8(9:w_8-8,9:h_8-8);
    for m = -1+min_m_16*2 : 1+min_m_16*2
        for n = -1+min_n_16*2 : 1+min_n_16*2
           MTB_B_8_temp = MTB_B_8(9+m : w_8-8+m, 9+n : h_8-8+n);
           temp = xor(MTB_A_8_temp, MTB_B_8_temp);
           E = (E_A_8&E_B_8);
           E = E(9+m : w_8-8+m, 9+n : h_8-8+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1+min_m_16*2 && n == -1+min_n_16*2
                temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              min_m_8 = m;
              min_n_8 = n;
              temp_min = temp_sum;
           end
        end
    end
    %min_m_8 = min_m_8 - (min_m_16+2*min_m_32);
    %min_n_8 = min_n_8 - (min_n_16+2*min_n_32);
    %-------------------------scale 8 --------------------------------
    
    %-------------------------scale 4 --------------------------------
    
    [w_4, h_4] = size(MTB_A_4);
    MTB_A_4_temp = MTB_A_4(17:w_4-16,17:h_4-16);
    for m = -1+min_m_8*2 : 1+min_m_8*2
        for n = -1+min_n_8*2 : 1+min_n_8*2
           MTB_B_4_temp = MTB_B_4(17+m : w_4-16+m, 17+n : h_4-16+n);
           temp = xor(MTB_A_4_temp, MTB_B_4_temp);
           E = (E_A_4&E_B_4);
           E = E(17+m : w_4-16+m, 17+n : h_4-16+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1+min_m_8*2 && n == -1+min_n_8*2
               temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              min_m_4 = m;
              min_n_4 = n;
              temp_min = temp_sum;
           end
        end
    end
    %min_m_4 = min_m_4 - (min_m_8+2*min_m_16+4*min_m_32);
    %min_n_4 = min_n_4 - (min_n_8+2*min_n_16+4*min_n_32);
    %-------------------------scale 4 --------------------------------
    
    %-------------------------scale 2 --------------------------------
    
    [w_2, h_2] = size(MTB_A_2);
    MTB_A_2_temp = MTB_A_2(33:w_2-32,33:h_2-32);
    for m = -1+min_m_4*2 : 1+min_m_4*2
        for n = -1+min_n_4*2 : 1+min_n_4*2
           MTB_B_2_temp = MTB_B_2(33+m : w_2-32+m, 33+n : h_2-32+n);
           temp = xor(MTB_A_2_temp, MTB_B_2_temp);
           E = (E_A_2&E_B_2);
           E = E(33+m : w_2-32+m, 33+n : h_2-32+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1+min_m_4*2 && n == -1+min_n_4*2
               temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              min_m_2 = m;
              min_n_2 = n;
              temp_min = temp_sum;
           end
        end
    end
    %min_m_2 = min_m_2 - (min_m_4+2*min_m_8+4*min_m_16+8*min_m_32);
    %min_n_2 = min_n_2 - (min_n_4+2*min_n_8+4*min_n_16+8*min_n_32);
    %-------------------------scale 2 --------------------------------
    
    %-------------------------scale 1 --------------------------------
    
    [w_1, h_1] = size(MTB_A);

    MTB_A_temp = MTB_A(65:w_1-64,65:h_1-64);
    
    for m = -1+min_m_2*2 : 1+min_m_2*2
        for n = -1+min_n_2*2 : 1+min_n_2*2           
           MTB_B_temp = MTB_B(65+m : w_1-64+m, 65+n : h_1-64+n);
           temp = xor(MTB_A_temp, MTB_B_temp);
           E = (E_A&E_B);
           E = E(65+m : w_1-64+m, 65+n : h_1-64+n);
           temp = E&temp;
           temp_sum = sum(temp(:));
           if m == -1+min_m_2*2 && n == -1+min_n_2*2
               temp_min = temp_sum;
           end
           if temp_sum <= temp_min
              motion_m = m;
              motion_n = n;
              temp_min = temp_sum;
              MTB_B_aligned = MTB_B_temp;
           end
        end
    end
    %min_m_1 = min_m_1 - (min_m_2+2*min_m_4+4*min_m_8+8*min_m_16+16*min_m_32);
    %min_n_1 = min_n_1 - (min_n_2+2*min_n_4+4*min_n_8+8*min_n_16+16*min_n_32);
    %-------------------------scale 1 --------------------------------
    
%     motion_m = min_m_1 + 2*min_m_2 + 4*min_m_4 + 8*min_m_8 + 16*min_m_16 + 32*min_m_32;
%     motion_n = min_n_1 + 2*min_n_2 + 4*min_n_4 + 8*min_n_8 + 16*min_n_16 + 32*min_n_32;    
    %motion_m = 1*min_m_2 + 2*min_m_4 + 4*min_m_8 + 8*min_m_16 + 16*min_m_32;
    %motion_n = 1*min_n_2 + 2*min_n_4 + 4*min_n_8 + 8*min_n_16 + 16*min_n_32;
    
%     MTB_B_aligned = MTB_B(65+motion_m:w_1-64+motion_m, 65+motion_n:h_1-64+motion_n);
    %MTB_B_aligned = MTB_B(33+motion_m:w_1-32+motion_m, 33+motion_n:h_1-32+motion_n);
    
 
    
%     a1 = xor(MTB_A(65:w_1-64, 65:h_1-64), MTB_B(65:w_1-64, 65:h_1-64));
%     a2 = xor(MTB_A(65:w_1-64, 65:h_1-64), MTB_B_aligned);
    %a1 = xor(MTB_A(33:w_1-32, 33:h_1-32), MTB_B(33:w_1-32, 33:h_1-32));
    %a2 = xor(MTB_A(33:w_1-32, 33:h_1-32), MTB_B_aligned);
   
    %total_score_origin = sum(a1(:));
    %total_score_new = sum(a2(:));
    %A_aligned = A(33:w_1-32, 33:h_1-32, :);
    %B_aligned = B(33+motion_m:w_1-32+motion_m, 33+motion_n:h_1-32+motion_n, :);
%     imshow(A_aligned(:,:,:,1));
    

end
