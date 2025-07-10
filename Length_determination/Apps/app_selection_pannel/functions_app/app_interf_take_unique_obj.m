function [BW_final_object, num] = app_interf_take_unique_obj(BW_final_noproc)


% INICI FUNCIÓ

% Obtenim l'objecte binari
[L_variable, num] = bwlabel(BW_final_noproc);
BW_final_object = L_variable == 1;
% imshow(BW_final_object)



% FINAL FUNCIÓ

end