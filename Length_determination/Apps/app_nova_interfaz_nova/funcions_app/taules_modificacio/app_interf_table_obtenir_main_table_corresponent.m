function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

% Aplica l'obtenció de la modificació actual, però segueix a la següent
% imatge si en la imatge actual ja no hi ha objectes (

[main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);

% Si no hi ha més objectes, es passa a la imatge posterior i es torna a
% re-definir.
if isempty(no_modified_object)
    %disp("isempty")
    n_imatge = str2double(app.img_contLabel.Text);
    
    % ______Precedencia______
    % NOTA: Veure/basar-se en f'app_interf_precedencia_img'
    % disp("Precedencia img")


    if (n_imatge +1) <= str2double(app.img_tot_nLabel.Text)
        %disp("No final")
        % ___Actualitzacions___
        % _contador imatge_
        app.img_contLabel.Text = string(n_imatge+1);
        %_nom imatge_
        [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge+1);        % Obtenció nom imatge
        app.img_original_nomLabel.Text = nom_img_original;         %Actualització nom imatge
        
        
        % Tornem a obtenir les modificacions:
        % Nota: Posteriorment graficarem, basant-nos en aquestes anotacións
        % i l'estat de la GUI (el qual hem re-definit en +1).
        [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
        
        % Actualitzat botons (imcrop)
        app.imcrop_value = [];

    else
        % FINALITZAT IMATGES
        % app_interf_boto_estadist(app)
        
    end
end


end