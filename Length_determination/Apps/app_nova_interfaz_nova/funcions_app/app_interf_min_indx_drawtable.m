function [taula_dibuix_minima] = app_interf_min_indx_drawtable(taula_dibuix_filted_nonproc)

% Agafem l'element de la taula amb menor nombre:

% INICI FUNCIÓ 
if height(taula_dibuix_filted_nonproc) == 1
    taula_dibuix_minima = taula_dibuix_filted_nonproc;

else
    min_val = Inf;
    for n_rowt = 1:height(taula_dibuix_filted_nonproc)
        taula_dibuix_temp = taula_dibuix_filted_nonproc(n_rowt, :);
        min_val_indx = min(appf_split_strindex(taula_dibuix_temp.Indx_skel));
    
        if min_val_indx < min_val
    
            min_val = min_val_indx;
            taula_dibuix_minima = taula_dibuix_temp;
        end
    end

end

% FINAL FUNCIÓ


end