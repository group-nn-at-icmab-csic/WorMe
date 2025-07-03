function [main_table_actual_last_modiftable_nofilter, indx_filtre_tots] = app_interf_table_filter_index_obtain(app, main_table_actual_last_modiftable)

% obtenció de la taula modificada pels filtrs anotats, i els index
% d'aquesta modificació.

% INICI FUNCIÓ

    % Funcio
    % Donada una taula de modificacions, retorna la taula ( i index)
    % d'aquesta amb l'aplicació dels filtres.
    % main_table_actual_last_modiftable
    
    % _____Obtenció valor dels filtres_____
    
    % Circularitat maxima
    
    % Si està el botó d'estat apretat:
    if app.MaxCircularityButton.Value
        filt_val_max_circ = app.SpinnerRound.Value;
    else
        filt_val_max_circ = Inf;
    end
   
    
    % Llargada estimada minima
	if app.MinLengthStateButton.Value
        filt_val_min_length = app.MinLengthTextArea.Value;
    else
        filt_val_min_length = 0;
    end
    

    % Area minima    

    if app.MinWidthStateButton.Value
        filt_val_min_area = app.MinWidthTextArea.Value;
    else
        filt_val_min_area = 0;
    end

    
    indx_filtre_tots = ~(main_table_actual_last_modiftable.Morph_circularity < filt_val_max_circ) | ~(main_table_actual_last_modiftable.Morph_majoraxis > filt_val_min_length) | ~(main_table_actual_last_modiftable.Morph_area > filt_val_min_area);

%     main_table_actual_last_modiftable.Morph_circularity
%     main_table_actual_last_modiftable.Morph_majoraxis
%     main_table_actual_last_modiftable.Morph_area
%     
%     app.global_control_temps_3
%     app.global_control_temps_4
%     app.global_control_temps_5

    main_table_actual_last_modiftable_nofilter = main_table_actual_last_modiftable(~indx_filtre_tots, :);
    

% FINAL FUNCIÓ

end