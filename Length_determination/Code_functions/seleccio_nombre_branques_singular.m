function [numero_puntsfinals, imatge_imoverlay_amb_text] = seleccio_nombre_branques_singular(imatge_BW_branques)

% Es retorna el numero de punts finals que presenta la imatge
% esqueletonitzada, per tal que aquest valor serveixi per a filtre.
%
% Variables:
% 
% numero_puntsfinals
% imatge_imoverlay_amb_text : imatge amb text dels punts
%
%
% Prové de f'seleccio_nombre_branques_llista'. 
%
% See also
% ficar_text_imatge

    
% INICI FUNCIÓ


%Selecciona si esqueleton té menys de X punts finals i si la llargada de
%les branques es molt petita.

% Passem a imatge esqueletonitzada:
BW_skel_cell = bwskel(imatge_BW_branques);  %, (__, 'MinBranchLength', 105)

% Determinem els endpoints
[endpoint_i, ~] = find(bwmorph(BW_skel_cell,'endpoints')); %punts finals de la imatge esqueletonitzada

numero_puntsfinals = numel(endpoint_i);

%Graficacio
imatge_imoverlay = imoverlay(imatge_BW_branques, BW_skel_cell , 'r');
imatge_imoverlay_amb_text = ficar_text_imatge(imatge_imoverlay, "Numero branques: ", numero_puntsfinals, "auto");
%imshow(imatge_imoverlay_amb_text)


% FINAL FUNCIÓ


end