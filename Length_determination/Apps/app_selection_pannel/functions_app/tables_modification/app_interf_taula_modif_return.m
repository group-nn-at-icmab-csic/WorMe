function app_interf_taula_modif_return(app)

% Modificació Return
%
% Borra la ultima anotació en la table_main.
%
% Obté, modifica i integra les dades a la base de dades.

% INICI FUNCIÓ

    % app.table_main_sel
    
    % Modificacions de la imatge actual
    main_table_actual = app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :);
    

    % Treiem la última modif de la taula_main
    app.table_main_sel = app.table_main_sel( ~(app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :);

    % Mirem si hem disminuit la imatge:
    
    if isequal(sum(app.table_main_sel.Image == string(app.img_original_nomLabel.Text)), 0)
        % restem 1 al contador.
        % ___Actualitzacions___
        % _contador imatge_
        n_imatge = str2double(app.img_contLabel.Text);
        app.img_contLabel.Text = string(n_imatge-1);
        %_nom imatge_
        [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge-1);        % Obtenció nom imatge
        app.img_original_nomLabel.Text = nom_img_original;         %Actualització nom imatge
        

        % Nota: Hem de restar 2, si ja no hi ha modificacions en la imatge. Perquè?
        % perque automaticament es crea una modificació si no hi ha objecte (es
        % crea la de BW). Llavors hem de restar ambdós: la de l'objecte actual
        % i la de la imatge anterior.
        % Veure: f'app_interf_table_obtenir_main_table_corresponent'
        
        % Si hem tirat enrrere, tornem a restar 1:
        % Modificacions de la imatge actual
        main_table_actual = app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :);

        % app.table_main_sel
        app.table_main_sel = app.table_main_sel( ~(app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :);
        
        
    end
    
    % app.table_main_sel
    
    
%     % _Comprovació_
%     % Modificació ultima
%     main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);    
%     isequal(main_table_actual_last, app.table_main_sel( (app.table_main_sel.Image == string(app.img_original_nomLabel.Text) & app.table_main_sel.nModif == max(main_table_actual.nModif)), :))
    
    % Mirem si la dada actual és la de la imatge present, o anterior. Si és
    % anterior re-definirem 



% FINAL FUNCIÓ

end