function app_interf_boto_estadist(app)

% Com clicar sobre el botó Done.
% Mostra tot el preàmbul estadístic.

% Ens basem en el filtratge de app.table_main_sel,
% Per a obtenir i guardar les dades en un compendi d'una sola taula
% (S_textscan_table).

% (futur) També guardarem els arxius per a poder retornar en els mateixos.


% INICI FUNCIÓ
    
    app.Image6.Visible = 'on';
    
    % Notes contadors:
    % app.finalitzat_contLabel.Text - contador si no s'ha finalitzat
    %                                   automàticament el conteig. D'inicial és false.
    % app.finalitzat_a_estadistica  -  Quan true: Mostra els botóns i components estadístics 
    %                                           de finalització. De normal és false
    
    
    % ____Write en taula S_textscan anotacions____
    
    % Nota: Variables inicials App:
    % % Guardem la ruta:
    % app.dir_imgs_orig = dir_img_originals;
    % app.appv_dir_output = dir_output;
    % 
    
    
    % Guardarem l'arxiu en un .txt. Serà el S_textscan_table. El farem servir
    % per a analitzar i obtenir les dades com es feia anteriorment.
    
    
    % Hem de filtrar les dades i graficar-les.
    % Podem gaurdar les dades per a una re-incorporació possible.
    %guardar les mateixes.
    % Ens basem en l'arquitectura d'obtenció de dades similar a: app_interf_table_obtenir_main_table_actual
    % disp("app.table_main_sel")
    % app.table_main_sel
    
    nom_imatges = unique(app.table_main_sel.Image);
    
    % Taula S_textscan creació nova, partir de la table_main.
    S_textscan_table = table(); 
    
    for n_img = nom_imatges'
        
        % Per cada imatge, obtenim la taula final?
        main_table_actual = app.table_main_sel(app.table_main_sel.Image == n_img, :);
    
        % Modificació ultima
        main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);
    
        S_textscan_table = [S_textscan_table; main_table_actual_last.ModifTable{1}];
        
    end
    
    % Fins aqui tenim la taula amb les útlimes anotacións.
    % Podem descartar a ara les anotacións que no han sigut manualment
    % seleccionades (les "empty").
    
    S_textscan_table = S_textscan_table( S_textscan_table.IsCeleg ~= "empty", :);
    
        
    % Les dades en v.2.14. eren guardades de la forma:
    % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"] );
    
    %  S_textscan_table.Properties.VariableNames
    
    %    {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    
    % {'Morph_circularity'}  {'Morph_majoraxis'}    {'Morph_area'}
    % Ens sobren : Morph_circularity   Morph_majoraxis    Morph_area
    
    % Treiem les variables "Morph_circularity", "Morph_majoraxis", "Morph_area".
    S_textscan_table = S_textscan_table(:, 1:end-3);
    % S_textscan_table.Properties.VariableNames
    
    % Ara guardariem la taula. A la ruta:
    write_taula(strcat(app.appv_dir_output, "\main_data_analysis.txt"), S_textscan_table, "$");
    
    % typology_formatspec_table_norm(S_textscan_table) % "%s%s%s%s%s%s%s%s%s"
    
    % S_textscan_table.Properties.VariableNames
    % % Comprovació
    % disp("Comprovació")
    % typology_formatspec_table_norm(S_textscan_table)
    % [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), typology_formatspec_table_norm(S_textscan_table), "$", S_textscan_table.Properties.VariableNames)
    
    % Podem exportar les dades a un excel, tal i com indica.
    
    
    
    app.finalitzat_a_estadistica = true; % Quan true: Mostra els botóns i components estadístics de finalització
    
    
    
    
    
                % __Canvi a mostrar estadístics_
                app_interf_graficar_finalitzat_img_on(app)
                
    
    %             % _LECTURA DE DADES_
    %             [S_textscan_table] = app_interf_llegir_main_dades(app.appv_dir_output);
    %             
    
                % Variables: 
                % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues"]
    
                % Filtrem la taula
                S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
                
                % _Definició llargada_
                dades_length = str2double(S_textscan_table_yes.Length);
                
    
    
                % Juntem les dades d'aquelles anotacións escrites manualment:
                taula_dibuix_manual = app.taula_draw;
    
                if ~isempty(taula_dibuix_manual)
                    dades_length = [dades_length; taula_dibuix_manual.length];
                end
    
                app.mean_valLabel.Text = string(round(mean(dades_length),2));
                app.std_valLabel.Text = string(round(std(dades_length),2));
                app.n_valLabel.Text = string(round(length(dades_length),2));
                app.max_valLabel.Text = string(round(max(dades_length),2));
                app.min_valLabel.Text = string(round(min(dades_length), 2));            
                            
                % _Graficació_
                % Activacio o no histfit si hi ha o no suficient dades.
                % Si no hi ha proutes dades (1 o 0):
                if length(dades_length) < 2
    
                    imshow("Apps\app_selection_pannel\Imatges_utilitat\not_enough_data2.png", 'Parent', app.UIAxes); 
                    app.UIAxes.XLabel.String = "";
    
                    title(app.UIAxes, "")
    
                    % Desactivem botóns
                    app.max_valLabel.Visible = 'off';
                    app.maxLabel.Visible = 'off';
                    app.minLabel.Visible = 'off';
                    app.min_valLabel.Visible = 'off';
                    app.std_valLabel.Visible = 'off';
                    app.stdLabel.Visible = 'off';
                    app.meanLabel.Visible = 'off';
                    app.mean_valLabel.Visible = 'off';
                    app.nLabel.Visible = 'off';
                    app.n_valLabel.Visible = 'off';   
                    app.n_yesLabel.Visible = 'on';
                    app.Thick_Button_little.Visible = 'on';
                    app.n_yesLabel2.Visible = 'off';
                    app.n_noLabel.Visible = 'on';
                    app.Cross_Button_little.Visible = 'on';
                    app.n_noLabel2.Visible = 'off';
                    app.acceptedLabel.Visible = 'off';
                    app.refusedLabel.Visible = 'off';
    
    
                % Si sí que hi ha dades:
                else
                    
    
                    % Si s'ha obert anteriorment una imatge (de no enought data)
                    if ~isempty(app.UIAxes.Children)
    
                        % Es torna a posicio original (Quan es fa imshow es fa
                        % variar la posicio)
                          app.UIAxes.YDir = 'normal';
                          app.UIAxes.PlotBoxAspectRatioMode = 'manual';
                          app.UIAxes.DataAspectRatioMode = 'auto';                  
                    end                
    
                    
                    histfit(app.UIAxes, dades_length)
                    
                    dir_img_originals = app.dir_imgs_orig;
    
                    % Nom carpeta:
                    dir_img_originals_split_t = split(dir_img_originals, "\");
                    dir_img_originals_split = dir_img_originals_split_t{end}; % Funciona
                    
                    title(app.UIAxes, regexprep(dir_img_originals_split, '[\\\^\_]','\\$0'))
    
    
                end
                
    
    app.Image6.Visible = 'off';


    % Actualitzem figura per capacitar shortkey
    figure(app.UIFigure)  


% FINAL FUNCIÓ




end