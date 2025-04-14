function [array_BWobj_fets] = appf_split_strindex_BB(array_str_indx)

% Donat un array amb arxius de text tipu:
% "23745;123746;124824;124825;124826;...", es retorna el array amb el valor
% numèric d'aquests.
% 
% Variables
% array_str_indx : array amb els strings dels indexs.
%                 exemple: S_textscan_table.Indx_BW
% 
% 

array_BWobj_fets = [];

% _Lectura dades_
for n_obj = 1:length(array_str_indx)
    % Llegim cada un, i el convertim a dobule
    indx_BW_obj = double(split(array_str_indx(n_obj), ";"))';% Elapsed time is 0.009027 seconds.
    
    
     % (sense prelocació) Passem a un sol array
     array_BWobj_fets = [array_BWobj_fets; indx_BW_obj];

end

end
