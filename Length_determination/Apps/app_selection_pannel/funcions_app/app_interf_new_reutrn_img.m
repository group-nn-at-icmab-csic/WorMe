function [img_return_nova] = app_interf_new_reutrn_img(nom_img_origin, nom_img_origin_GUI)

% Dona un contador true/false si la imatge és nova


% INICI FUNCIÓ


if nom_img_origin ~= nom_img_origin_GUI
    img_return_nova = true;
    % Modifiquem el contador de la imatge

else
    img_return_nova = false;
end  

% FINAL FUNCIÓ


end