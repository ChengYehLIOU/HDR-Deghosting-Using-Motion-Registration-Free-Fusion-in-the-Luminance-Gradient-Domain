function [g,lE]=mygsolve(Z,B,l,w)
    % rename the file to prevent ambiguity
    for channel = 1:size(Z,3)
        n = 256;
        A = zeros(size(Z,1)*size(Z,2)+n-1,n+size(Z,1));
        b = zeros(size(A,1),1);
        k = 1; %% Include the data-fitting equations
        
        for i=1:size(Z,1)
            for j=1:size(Z,2)
                wij = w(Z(i,j,channel)+1);
                A(k,Z(i,j,channel)+1) = wij; A(k,n+i) = -wij; 
                b(k,1) = wij * B(j);
                k=k+1;
            end
        end
        
        A(k,129) = 1; %% Fix the curve by setting its middle value to 0
        k=k+1;
        
        for i=1:n-2 %% Include the smoothness equations
            A(k,i)=l*w(i+1); A(k,i+1)=-2*l*w(i+1); A(k,i+2)=l*w(i+1);
            k=k+1;
        end
        x = A\b; %% Solve the system using SVD
        g(:,channel) = x(1:n);
        lE(:,channel) = x(n+1:size(x,1));
    end
end