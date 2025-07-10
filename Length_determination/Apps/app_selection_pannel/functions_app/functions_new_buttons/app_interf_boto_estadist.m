function app_interf_boto_estadist(app)

% How to click the Done button.
% Shows the entire statistical preamble.

% We base ourselves on filtering app.table_main_sel,
% To obtain and save the data in a single table compendium
% (S_textscan_table).

% (future) We will also save the files to be able to return to them.


% START OF FUNCTION
    
    app.Image6.Visible = 'on';
    
    % Counter notes:
    % app.finalitzat_contLabel.Text - counter if the counting has not ended
    %                                 automatically. Initially it is false.
    % app.finalitzat_a_estadistica  - When true: Shows buttons and statistical
    %                                completion components. Normally false.
    
    
    % ____Write annotations to S_textscan table____
    
    % Note: Initial App variables:
    % % We save the path:
    % app.dir_imgs_orig = dir_img_originals;
    % app.appv_dir_output = dir_output;
    % 
    
    
    % We will save the file as a .txt. It will be the S_textscan_table. We will use it
    % to analyze and obtain the data as done previously.
    
    
    % We have to filter the data and plot it.
    % We can save the data for possible later re-incorporation.
    % Save the same.
    % We base ourselves on the data retrieval architecture similar to: app_interf_table_obtenir_main_table_actual
    % disp("app.table_main_sel")
    % app.table_main_sel
    
    nom_imatges = unique(app.table_main_sel.Image);
    
    % New creation of S_textscan table, starting from table_main.
    S_textscan_table = table(); 
    
    for n_img = nom_imatges'
        
        % For each image, we get the final table?
        main_table_actual = app.table_main_sel(app.table_main_sel.Image == n_img, :);
    
        % Last modification
        main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);
    
        S_textscan_table = [S_textscan_table; main_table_actual_last.ModifTable{1}];
        
    end
    
    % Up to here we have the table with the latest annotations.
    % We can discard now the annotations that have not been manually
    % selected (the "empty" ones).
    
    S_textscan_table = S_textscan_table( S_textscan_table.IsCeleg ~= "empty", :);
    
        
    % Data in v.2.14 was saved in the form:
    % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"] );
    
    %  S_textscan_table.Properties.VariableNames
    
    %    {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    
    % {'Morph_circularity'}  {'Morph_majoraxis'}    {'Morph_area'}
    % We don't need: Morph_circularity   Morph_majoraxis    Morph_area
    
    % We remove variables "Morph_circularity", "Morph_majoraxis", "Morph_area".
    S_textscan_table = S_textscan_table(:, 1:end-3);
    % S_textscan_table.Properties.VariableNames
    
    % Now we would save the table. At path:
    write_taula(strcat(app.appv_dir_output, "\main_data_analysis.txt"), S_textscan_table, "$");
    
    % typology_formatspec_table_norm(S_textscan_table) % "%s%s%s%s%s%s%s%s%s"
    
    % S_textscan_table.Properties.VariableNames
    % % Check
    % disp("Check")
    % typology_formatspec_table_norm(S_textscan_table)
    % [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), typology_formatspec_table_norm(S_textscan_table), "$", S_textscan_table.Properties.VariableNames)
    
    % We can export the data to excel, as indicated.
    
    
    
    app.finalitzat_a_estadistica = true; % When true: Shows buttons and statistical completion components
    
    
    
                % __Switch to show statistics__
                app_interf_graficar_finalitzat_img_on(app)
                
    
    %             % _DATA READING_
    %             [S_textscan_table] = app_interf_llegir_main_dades(app.appv_dir_output);
    %             
    
                % Variables: 
                % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues"]
    
                % We filter the table
                S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
                
                % _Length definition_
                dades_length = str2double(S_textscan_table_yes.Length);
                
    
    
                % We join the data from those manually written annotations:
                taula_dibuix_manual = app.taula_draw;
    
                if ~isempty(taula_dibuix_manual)
                    dades_length = [dades_length; taula_dibuix_manual.length];
                end
    
                app.mean_valLabel.Text = string(round(mean(dades_length),2));
                app.std_valLabel.Text = string(round(std(dades_length),2));
                app.n_valLabel.Text = string(round(length(dades_length),2));
                app.max_valLabel.Text = string(round(max(dades_length),2));
                app.min_valLabel.Text = string(round(min(dades_length), 2));            
                            
                % _Plotting_
                % Activate or not histfit if there is enough data.
                % If there is not enough data (1 or 0):
                if length(dades_length) < 2
    
                    imshow("Apps\app_selection_pannel\images_useful\not_enough_data2.png", 'Parent', app.UIAxes); 
                    app.UIAxes.XLabel.String = "";
    
                    title(app.UIAxes, "")
    
                    % Deactivate buttons
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
    
    
                % If there is data:
                else
                    
    
                    % If a picture was opened previously (from not enough data)
                    if ~isempty(app.UIAxes.Children)
    
                        % It returns to original position (When imshow is done it
                        % changes the position)
                          app.UIAxes.YDir = 'normal';
                          app.UIAxes.PlotBoxAspectRatioMode = 'manual';
                          app.UIAxes.DataAspectRatioMode = 'auto';                  
                    end                
    
                    
                    histfit(app.UIAxes, dades_length)
                    
                    dir_img_originals = app.dir_imgs_orig;
    
                    % Folder name:
                    dir_img_originals_split_t = split(dir_img_originals, "\");
                    dir_img_originals_split = dir_img_originals_split_t{end}; % Works
                    
                    title(app.UIAxes, regexprep(dir_img_originals_split, '[\\\^\_]','\\$0'))
    
    
                end
                
    
    app.Image6.Visible = 'off';


    % Refresh figure to enable shortkey
    figure(app.UIFigure)  


% END OF FUNCTION





end