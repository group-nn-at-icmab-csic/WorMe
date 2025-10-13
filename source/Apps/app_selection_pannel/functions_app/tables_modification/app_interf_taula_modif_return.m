function app_interf_taula_modif_return(app)

% Return Modification
%
% Deletes the last annotation in table_main.
%
% Obtains, modifies, and integrates the data into the database.

% START OF THE FUNCTION

    % app.table_main_sel
    
    % Modifications of the current image
    main_table_actual = app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :);
    

    % Remove the last modification from table_main
    app.table_main_sel = app.table_main_sel( ~(app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :);

    % Check if we have stepped back an image:
    
    if isequal(sum(app.table_main_sel.Image == string(app.img_original_nomLabel.Text)), 0)
        % subtract 1 from the counter.
        % ___Updates___
        % _image counter_
        n_imatge = str2double(app.img_contLabel.Text);
        app.img_contLabel.Text = string(n_imatge-1);
        %_image name_
        [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge-1);        % Obtaining image name
        app.img_original_nomLabel.Text = nom_img_original;         % Updating image name
        

        % Note: We need to subtract 2 if there are no modifications left in the image. Why?
        % because a modification is automatically created if there is no object (the
        % BW modification is created). Therefore, we must subtract both: the current object's
        % and the one from the previous image.
        % See: f'app_interf_table_obtenir_main_table_corresponent'
        
        % If we stepped back, subtract 1 again:
        % Modifications of the current image
        main_table_actual = app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :);

        % app.table_main_sel
        app.table_main_sel = app.table_main_sel( ~(app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :);
        
        
    end
    
    % app.table_main_sel
    
    
%     % _Check_
%     % Last modification
%     main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);    
%     isequal(main_table_actual_last, app.table_main_sel( (app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :))
    
    % Check if the current data belongs to the present image, or the previous one. If it's
    % previous, we will re-define

% END OF THE FUNCTION


end