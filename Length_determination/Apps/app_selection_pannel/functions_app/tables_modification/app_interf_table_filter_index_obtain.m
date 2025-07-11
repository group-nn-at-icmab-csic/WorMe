function [main_table_actual_last_modiftable_nofilter, indx_filtre_tots] = app_interf_table_filter_index_obtain(app, main_table_actual_last_modiftable)

% Obtaining the modified table based on the annotated filters, and the
% indices of this modification.

% START FUNCTION

    % Function
    % Given a table of modifications, returns the table (and indices)
    % with the application of the filters.
    % main_table_actual_last_modiftable
    
    % _____Obtaining filter values_____
    
    % Maximum circularity
    
    % If the status button is pressed:
    if app.MaxCircularityButton.Value
        filt_val_max_circ = app.SpinnerRound.Value;
    else
        filt_val_max_circ = Inf;
    end
   
    
    % Minimum estimated length
	if app.MinLengthStateButton.Value
        filt_val_min_length = app.MinLengthTextArea.Value;
    else
        filt_val_min_length = 0;
    end
    

    % Minimum area    

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

    main_table_actual_last_modiftable_nofilter = main_table_actual_last_modiftable(~indx_filtre_tots, :);
    

% END FUNCTION


end