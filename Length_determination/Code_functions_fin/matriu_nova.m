function [matriu_nova_v, matrui_nova_2, matrui_nova_2_show, mat_sortida, punt_centr] = matriu_nova(BW_inicial, cada_val, x_enpoint, y_endpoint)

% % Given a binary image, a point from it, and a value with which you want 
% it to be the dimension of the region that is taken, the matrix 
% of that region is obtained.
%
%
% (CAT)
% Donada una imatge binària, un punt d'aquesta, i un valor amb el qual es
% vol que sigui la dimensió de la regió que s'agafa, s'obté la matriu
% d'aquesta regió.
%
%
% Variables 
% Input
%
%
% Output
%   matriu_nova_v : matriu seleccionada
%   matriu_nova_2 : matriu seleciconada amb sols les vores, la última capa.
%   matriu_nova_2_show : matriu seleccionada amb sols les vores, amb el  punt central marcat.
%   mat_sortida : valors de la imatge amb els quals s'han determinat la matriu.
%   punt_centr : punt central de la matriu de sortida, on hi ha el punt de referència.
%
%

% _Correcció dimensió valors_

% % % Visualització valors
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
    
    % Cambiem valor
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;
end

if x_enpoint + cada_val > x_size
    cada_val_new = abs(x_size - x_enpoint);%+1;
    
    % Cambiem valor
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if y_endpoint - cada_val <= 0
    cada_val_new = y_endpoint - 1; %y_endpoint - 1; %abs(cada_val - y_endpoint)
    
    % Cambiem valor
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if y_endpoint + cada_val > y_size
    cada_val_new = abs(y_size - y_endpoint); %;+1;
    
    % Cambiem valor
    if cada_val_totnew > cada_val_new
        cada_val_totnew = cada_val_new;
    end
    iscorrected = true;    
end

if iscorrected
    cada_val = cada_val_totnew;
end

% % % Visualització valors
% proporcio_img_mat = [x_enpoint-cada_val, ...
%     x_enpoint + cada_val, ...
%     y_endpoint-cada_val, ...
%     y_endpoint + cada_val]
% x_enpoint
% y_endpoint
% cada_val


% _Operació matrius_
mat_sortida = [x_enpoint - cada_val, x_enpoint + cada_val, y_endpoint - cada_val, y_endpoint + cada_val];
matriu_nova_v = BW_inicial(x_enpoint-cada_val:x_enpoint + cada_val, y_endpoint-cada_val:y_endpoint + cada_val);


[x_matnova, y_matnova] = size(matriu_nova_v);
matrui_nova_2 = matriu_nova_v;
matrui_nova_2(2:x_matnova-1,2:x_matnova-1) = 0;

matrui_nova_2_show = matrui_nova_2; matrui_nova_2_show(((x_matnova-1)/2)+1, ((y_matnova-1)/2)+1) = 1;

punt_centr = [((x_matnova-1)/2)+1, ((y_matnova-1)/2)+1];

end