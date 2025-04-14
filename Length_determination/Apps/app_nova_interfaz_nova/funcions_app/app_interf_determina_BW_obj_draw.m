function [BW_final_object, num, isdrawline] = app_interf_determina_BW_obj_draw(taula_dibuix_filted_nonproc, BW_final_object, num)


% Determina si, donat una imatge binària amb un objecte binari, hi hauria
% d'haber la selecció d'un objecte de draw.
%
%
% Variables
%   input:
%       BW_final_object : BW objecte unic
%       num : nombre objects
%   output
%       isdrawline : contador si és o no draw
%       taula_dibuix_filted_nonproc : taula draws no processats
%       BW_final_object : BW objecte unic
% 

% INICI FUNCIÓ


% Si hi ha objectes de draw:
if ~isempty(taula_dibuix_filted_nonproc)

    % Sumem el valor de la variable control 'num'
    num = height(taula_dibuix_filted_nonproc);

    % Si l-'index de la imatge 'es anterior, es fa aquest, sino es fa
    % el del objecte draw:
    if min(find(BW_final_object)) < min(appf_split_strindex(taula_dibuix_filted_nonproc.Indx_skel)) %#ok 
        isdrawline = false;
    else
        isdrawline = true;

        % Agafem la drawline amb el valor menor index:
        [taula_dibuix_minima] = app_interf_min_indx_drawtable(taula_dibuix_filted_nonproc);
    
        % Obtenim la imatge amb l'objecte últim:
        BW_final_object = false(double([appf_split_strindex(taula_dibuix_minima.Resolution)']));
        BW_final_object(appf_split_strindex(taula_dibuix_minima.Indx_skel)) = true;
            
    end
else
    isdrawline = false; % Defineix si s'obté l'objecte o una imatge binaria.
end



% FINAL FUNCIÓ



end