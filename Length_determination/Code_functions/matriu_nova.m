function [matriu_nova_v, matrui_nova_2, matrui_nova_2_show, mat_sortida, punt_centr] = matriu_nova(BW_inicial, cada_val, x_enpoint, y_endpoint)

% Given a binary image, one of its points, and the size of the region taken,
% the matrix of that region is obtained.
%
%
% Variables 
% Input
%
%
% Output
%   matriu_nova_v : selected matrix
%   matriu_nova_2 : selected matrix with only the edges, the last layer
%   matriu_nova_2_show : selected matrix with only the edges, with the central point marked.
%   mat_sortida : values of the image with which the matrix has been determined.
%   punt_centr : central point of the output matrix, where there is the reference point.
%
%

% _Correcting the dimension of the values_

% % Visualization of the values
% proporcio_img_mat = [x_enpoint-cada_val, ...
%     x_enpoint + cada_val, ...
%     y_endpoint-cada_val, ...
%     y_endpoint + cada_val]
% x_enpoint
% y_endpoint
% cada_val

[x_size, y_size, ~] = size(BW_inicial);

cada_val_totnew = Inf; 
iscorrected = false;
if x_enpoint - cada_val <= 0
    cada_val_new = x_enpoint -1;% 1; %x_enpoint -1; %abs(cada_val - x_enpoint)+1
    
    % Change the value
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;
end

if x_enpoint + cada_val > x_size
    cada_val_new = abs(x_size - x_enpoint);%+1;
    
    % Change the value
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if y_endpoint - cada_val <= 0
    cada_val_new = y_endpoint - 1; %y_endpoint - 1; %abs(cada_val - y_endpoint)
    
    % Change the value
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if y_endpoint + cada_val > y_size
    cada_val_new = abs(y_size - y_endpoint); %;+1;
    
    % Change the value
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if iscorrected
    cada_val = cada_val_totnew;
end

% % Visualization of the values
% proporcio_img_mat = [x_enpoint-cada_val, ...
%     x_enpoint + cada_val, ...
%     y_endpoint-cada_val, ...
%     y_endpoint + cada_val]
% x_enpoint
% y_endpoint
% cada_val


% _Operation with the matrices_
mat_sortida = [x_enpoint - cada_val, x_enpoint + cada_val, y_endpoint - cada_val, y_endpoint + cada_val];
matriu_nova_v = BW_inicial(x_enpoint-cada_val:x_enpoint + cada_val, y_endpoint-cada_val:y_endpoint + cada_val);


[x_matnova, y_matnova] = size(matriu_nova_v);
matrui_nova_2 = matriu_nova_v;
matrui_nova_2(2:x_matnova-1,2:x_matnova-1) = 0;

matrui_nova_2_show = matrui_nova_2; matrui_nova_2_show(((x_matnova-1)/2)+1, ((y_matnova-1)/2)+1) = 1;

punt_centr = [((x_matnova-1)/2)+1, ((y_matnova-1)/2)+1];

end