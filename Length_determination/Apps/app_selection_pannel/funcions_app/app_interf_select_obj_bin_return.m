function [proc_BW, new_img, num, BW_final_object, BW_final_noproc] = app_interf_select_obj_bin_return(BW_final_noproc)

% Com app_inerf_select_obj_bin_forward, però sense l'opció de que es pugui
% tornar endavant de la imatge, sinó que sols es dona la imatge amb l'objecte.
% Funció de la app 'app_selection_pannel'.
%
%
%
% Variables
% number_BW : numero d'objectes binaris (de BW objectes no processats 'BW_final_noproc')

% INICI FUNCIÓ

% Si hi ha algún objecte binari

% Obtenim l'objecte binari
[L_variable, num] = bwlabel(BW_final_noproc);
BW_final_object = L_variable == 1;
% imshow(BW_final_object)

proc_BW = true; % Contador que no s'ha arribat al final    

new_img = false; % Contador imatge nova

% FINAL FUNCIÓ


end