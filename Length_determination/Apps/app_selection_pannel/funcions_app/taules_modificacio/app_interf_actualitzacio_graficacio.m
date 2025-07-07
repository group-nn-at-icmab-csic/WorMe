function app_interf_actualitzacio_graficacio(app, enrrere_porta)

% Genera l'actualització de les dades (determinacio del objecte actual), i
% la graficació d'aquestes.


% INICI FUNCIÓ

% __Tipologia avançament dades__ % 
% Si les dades s'avancen per modificacions, es fa una lectura dels objectes
% i una automàtica posicio vers les imatges.
% Si no hi ha una lectura dels objectes, com pot ser en els botons dreta o
% esquerra, la precedencia no ha de ser automatica.

% Si no és opció a estadistica?

% Si la lectura es normal (true)
if enrrere_porta
    % _Obtenció dada objecte
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % Si no hi ha una lectura normal, sino que es fa cap enrrere.    
else
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
end

% main_table_actual_last %ççç
% main_table_actual_last_modiftable
% no_modified_object


[n_yes, n_no] = app_interf_table_contar_pos(app);
% Elapsed time aprox: Elapsed time is 0.057395 seconds. (en ~100 mostres)
app.n_yesLabel.Text = string(n_yes);  % Mostrem valors als botóns
app.n_yesLabel2.Text = string(n_yes);
app.n_noLabel.Text = string(n_no);
app.n_noLabel2.Text = string(n_no);



% Si executada la funció, les variables indx_object_operate i
% no_modified_object són vuides, significa que no hi ha objectes, o pels filtres s'han desseleccionat tots.

% Si no hi ha objectes
if isempty(indx_object_operate)
    % disp("No objects")
    
%     % INHABILITAT FUNCIÓ DE: PASSA AUTOMATICAMENT AL ESTADISTIC
%     % Si aquesta és la ultima imatge, es precedeix a l'estadística:
%     if isequal(str2num(app.img_contLabel.Text), str2num(app.img_tot_nLabel.Text))
%         % disp("IMAGE SELECTION FINALIZATION")
%         
% %         La porta de que s'ha arribat al final en la v.14. és en f'app_interf_taula_modif_thick(app)', on:
% %         app.finalitzat_contLabel.Text = "true";
% %         % Mostrem la part de la GUI d'estadística
% %         app_interf_boto_estadist(app)
%     
%         % Describim que s'ha seleccionat els objectes linealment, sense
%         % saltar-se objectes. (NOTA: ANULAT DE MOMENT, VEURE BOTÓ DRETA).
%         % Si sols hi ha una imatge, pero, s'activa si s'ha acavat.
%         if isequal(str2num(app.img_tot_nLabel.Text), 1)
%            app.finalitzat_contLabel.Text = "true";
%         end
% 
%         % Execució botó estadística (Botó Done)
%         app_interf_boto_estadist(app)
%         
%     % Sinó, es computa la imatge precedent (sense objectes, o tots seleccionats)
%     else
    
    % Si és la ultima imatge, es grafica el botó de Done:
    if isequal(str2num(app.img_contLabel.Text), str2num(app.img_tot_nLabel.Text))
        app.DoneButton.BackgroundColor = [0.39,0.83,0.07]; % Color groc
    else
        app.DoneButton.BackgroundColor = [0.90,0.90,0.90];
    end

        if isempty(main_table_actual_last_modiftable)
            % Imatge sense objectes
            app_interf_table_actu_imatge_no_objectes(app)    

            % Imatge sense objectes, sense selecció: botóns thick cross no
            % operables. 
            app.ReturnButton.Visible = 'off';
        else
            % Imatge amb objectes, pero sense selecció dels mateixos.

            % Ara podem graficar la ultima modificacio
            appf_interf_table_graficacio(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)        

            % Seleccio botons?
            app_interf_table_actu_botons_objectes(app, false)

            app.ReturnButton.Visible = 'on';
        end
%     end

    
else
    % Si sí que hi ha objectes:
    
    app_interf_table_actu_botons_objectes(app, true)
    app.ReturnButton.Visible = 'on'; % Return es fora perque depen de si hi ha o no obj.
            
    % ___Re-describim les dades morfològiques de l'objecte actual___
    % Definim els valors de skel de l'objecte actual (no ho habiem fet
    % abans per no fer-ho de cada objecte) i l'adherim a la taula de
    % moficiacions actual.
    
    if isequal(no_modified_object(1,:).Length, "No_data_yet")
        [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = appf_interf_table_incorporar_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object);
    end
    
    % Ara podem graficar la ultima modificacio
    appf_interf_table_graficacio(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)
    
    app.DoneButton.BackgroundColor = [0.90, 0.90, 0.90];

end


if ~app.finalitzat_a_estadistica % Si no s'ha passat a estadística.
    app_interf_table_act_dretaesquerra(app)
    app_interf_taula_actu_return(app)
end

% % graficacio
% [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)


% FINAL FUNCIÓ

end