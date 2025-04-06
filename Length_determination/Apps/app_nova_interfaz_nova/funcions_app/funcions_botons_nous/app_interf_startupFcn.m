function app_interf_startupFcn(app)


% StartupFcn funcio


% INICI FUNCIO

            % FER
            %
            % 
            % Revisar return: no funciona quan s'apliquen filtres...
            %
            % Objectes que toquen al borde: Fer que es treguin els pixels
            % del voltant: els valors dels index múltiples a les
            % dimensions, treure'ls.
            %
            % Filtrar per rodona. Determinar percentatge.
            %
            % Botó Img original ("s")
            %
            % Marcador Length
            % Contador C. elegans fets.
            % Botó Cross per a "No C. eleg"
            % Que en botó "Done" es pugui posar acabar, sigui en el moment que siguin les imatges.
            %
            % Posar gràfica amb les dades de les seleccionades: No cucs,
            % llargada mitja, histograma de la llargada? Que dongui també
            % la normalitat de les dades? test de normalitat directe? Amb
            % botó de 'show statistics'?
            %
            % ççç posar condicional de si la modificació és o no la mateixa.
            %
            % ççç Al canviar el tipus de modificació (app.ModificacionstemporalsListBox, app.ModificacionsguardadesListBox) , que es reiniciin
            % totes les dades de la imatge present. (= evitar lios).
            % 
            % Exportació de les imatges binaries. 
            % Exportació de les dades en format Pascal VOC


            % FER FUTUR
            % Posar apartat de l'aplicatiu que sigui per a recepcionar
            % comentaris i feedback dels usuaris.
            
            
            % Variables
            %
            % Input
            % -----
            % dir_img_originals : carpeta amb les imatges seleccionades orginidals.
            %
            %
            % Arxius
            % -------
            % dir_output, "/main_data_analysis.txt" - Arxiu de dades principal
            %
            % temporals:
            % dir_output, "\temp_indx_BWobject.txt" - Index dels objectes (temporal)
            % dir_output,"\temp_indx_BWskel.txt"    - Index esqueletonitzacio (temporal)
            %
            %
            %

            % Contadors
            % ---------
            % _Principals:
            % img_contLabel : imatge 'n' original de la carpeta. Es suma quan es passa d'imatge i resta quan return. 
            %                 Aquest es basa la imatge actual que s'opera.
            %
            % _ Secundàris:
            % img_tot_nLabel : Nombre total d'imatges de la carpeta. Es fa per veure finalització.
            % finalitzat_contLabel: Contador de finalització de totes les imatges.
            % n_objecte_Label : nombre d'objectes en la imatge.
            
%             % Contador temps _contTemps_
%             % Temps inicial
%             app.global_temps_total_inici = datetime("now");
% 
%             app.global_control_temps_1


            % _Contadors noms i directoris_
            % img_original_nomLabel : nom imatge original (ex: img_290.jpg)

            
            % Variables inicials
            dir_img_originals = app.dir_imgs_orig;            
            dir_output = app.appv_dir_output;





            % Requeriments inicials
            % ---------------------
            % Comprovar requeriments inicials:
            % Imatges no continguin '$'
            
            
            % ___Descripció inicial contadors___
            app.finalitzat_contLabel.Text = "false";
            app.n_objecteLabel.Text = "1"; % ÇÇÇ Mirar si hi ha o no objectes en la imatge. si no hi ha cambiar-ho.
            app.ReturnButton.Visible = 'off';
            app.RightButton.Visible = 'off';
            app.LeftButton.Visible = 'off';
            
            % Statistics buttons labels
            app.UIAxes.Visible = 'off';            
            app.ExitButton.Visible = 'off';
            app.ExportButton.Visible = 'off';
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
            app.ExportIAdataButton.Visible = 'off';
            app.InfoIcon_3.Visible = 'off';
            app.InfoIcon_2.Visible = 'off';
            app.ExportnoncorrectedmanualerrordataCheckBox.Visible = 'off';
            
            app.UIAxes2.Visible = 'off';

            app.n_yesLabel.Visible = 'on';
            app.n_yesLabel2.Visible = 'off';
            app.n_noLabel.Visible = 'on';
            app.n_noLabel2.Visible = 'off';
            app.acceptedLabel.Visible = 'off';
            app.refusedLabel.Visible = 'off';

            
            
            
            

            

            % LECTURA IMATGES .jpg i .png de la carpeta:
            % [theFiles] = lectura_imatges_carpeta_estr(dir_img_originals);
            % Nota: les imatges no són ordeandes d'igual manera que ho fa Windows, els patróns d'ordenament són lleugerament diferents.

            theFiles = app.theFiles_arxiu;

            % Obtencio 1a imatge
            baseFileName = theFiles(1).name;
            %disp(baseFileName)
            fullFileName = fullfile(theFiles(1).folder, baseFileName);
            %imageArray_escala = imread(fullFileName); % Imatge inicial
            imatge_original = imread(fullFileName);
            app.Image.ImageSource = imatge_original;
            
            % _Describim el nom de la imatge original primera_
            app.img_original_nomLabel.Text = baseFileName;            
            

            % _Guardem contador imatge actual_
            app.img_contLabel.Text = "1";
            % Llargada total imatges
            app.img_tot_nLabel.Text = string(length(theFiles)); % Contador imatges totals
            
            
            % Guardem nom carpeta
            dir_img_originals_sing_t = split(dir_img_originals, "\");
            dir_img_originals_sing = dir_img_originals_sing_t{end}; % Funciona
            app.dir_img_orig_sLabel.Text = dir_img_originals_sing;
            
            % ____Mirem les modificacions____
            % Definim la Box de Modificacions temporals, a partir dels
            % documents que es creen:
            
            % Automatització Drop Roll Modificacions temporals
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
            patro_tipus_image = ".txt";

            [llistat_string_im_temp] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);          
                        
            app.ModificacionstemporalsListBox.Items = llistat_string_im_temp;
            
            % Llegir arxius Modificacions guardades
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
            patro_tipus_image = ".txt";
            [llistat_string_im_guard] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
            app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
            
            % Si les modificacions gaurdades són vuides
            if isempty(app.ModificacionsguardadesListBox.Items)
                
                % Si també ho és vuida les modificacions temporals
                if isempty(app.ModificacionstemporalsListBox.Items)
                    % Fem que es faci una nova modificació
                    app.NovamodificaciButtonPushed;
                else
                    % Sinó, que es seleccioni les modificacions
                    app.ModificacionstemporalsListBox.Value = llistat_string_im_temp(end);
                end

            else
                app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
                app.ModificacionsguardadesListBox.Value = llistat_string_im_guard(end);

                if ~isempty(app.ModificacionstemporalsListBox.Items)
                    app.ModificacionstemporalsListBox.Value = {};
                end
            end
            
            
            % _Llegim la modificació guardada_
            filestxt = lectura_txt_carpeta_estr(strcat(dir_output, "\Processment_parameters"));
            text_config_parameters = filestxt.name;
            dir_text_config_parameters = strcat(dir_output, "\Processment_parameters\", text_config_parameters);
            [array_sortida_modifs, ~] = llegir_text_delimitadors(dir_text_config_parameters, ";"); % obtneim l'array de la lectura del document de text i el printem
            cell_cont = array_sortida_modifs(2:end, 2); % Operem
            array_processaments = cell2array_josep(cell_cont);

            
            if ismember(text_config_parameters, app.ModificacionsguardadesListBox.Items)
                % Seleccionem en ListBox de ModificacionsGuardades:
                app.ModificacionsguardadesListBox.Value = text_config_parameters;
                app.ModificacionstemporalsListBox.Value = {};
                
            elseif ismember(text_config_parameters, app.ModificacionstemporalsListBox.Items)
                % Seleccionem en ListBox de ModificacionsGuardades:
                app.ModificacionstemporalsListBox.Value = text_config_parameters;
                app.ModificacionsguardadesListBox.Value = {};                
            end
            
            % __Actualització i Graficació__ %
            app_interf_actualitzacio_graficacio(app, false) %

            
            
            
            
            % Upgrade interf WM 2.15
            app_interf_table_act_dretaesquerra(app)            


            
            % Centrem la GUI
            % ..............
            UIFigure_position = app.UIFigure.Position; %100   100   602   389
                                                      % inici final amplada  llargada
            screensize_position = get(0, 'ScreenSize'); %         1           1        1920        1080
            [UIFigure_position_new] = centered_GUI_screen(UIFigure_position, screensize_position);
            app.UIFigure.Position = UIFigure_position_new;
            
                        
            % Per a fer la cell a escriure amb les dades, podriem fer una
            % cell vuida de 7 i anar afegint els continguts en funció a
            % aquests es vagin definint.
            % cell(1,7)
            
            % _Creació arxiu de dades principal_
            fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'w');
            fclose(fid);
            
            

            
            % ____Descripció de les posicions dels objectes de la App____

            % % Obtenir la tipologia dels objectes de la GUI
            % obj_h = findobj(app.UIFigure);
            % get(obj_h,'Type')

            % _Obtenció posicions inicials_
            pos_fig = app.UIFigure.Position;
            pos_img =  app.Image.Position;         
            
            % _Describim les dades de posicio de la imatge_
            app.posFigTextArea.Value = strjoin(string(pos_fig), ";");
            app.posImgTextArea.Value = strjoin(string(pos_img), ";");
            
            % _Obtenció posicio botons_
            h_determin_button = findobj(app.UIFigure,'Type','uibutton');
            [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
            % _Describim les dades de posicio dels botons_
            app.posButtonsTextArea.Value = str_button_tot;
            
            
            % _Obtenció posicio listbox_
            h_determin_listbox = findobj(app.UIFigure,'Type','uilistbox');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_listbox);
            app.posListboxTextArea.Value = str_button_tot_list;
            
            
            % _Obtenció posicio listbox_
            h_determin_label = findobj(app.UIFigure,'Type','uilabel');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_label);
            app.posLabelTextArea.Value = str_button_tot_list;
            
            
             % _Obtenció posicio image_ 
            h_determin_imgs = findobj(app.UIFigure,'Type','uiimage');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_imgs);
            app.posImatgesTextArea.Value = str_button_tot_list;

            
%              % _Obtenció posicio checkbox_ 
%             h_determin_checkbox = findobj(app.UIFigure,'Type','uicheckbox');
%             [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
%             app.posCheckboxTextArea.Value = str_button_tot_list;
            
            
             % _Obtenció posicio hyperlink_ 
            h_determin_hyperlink = findobj(app.UIFigure,'Type','uihyperlink');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_hyperlink);
            app.posHyperlinkTextArea.Value = str_button_tot_list;

            % _Obtenció factor FontSize_
            fact_fontsize = h_determin_hyperlink.FontSize / sqrt(pos_fig(3) * pos_fig(4));
            app.sizeFontTextArea.Value = string(fact_fontsize);

            
            % _Obtenció posicio botostate_
            h_determin_button = findobj(app.UIFigure,'Type','uistatebutton');
            [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
            % _Describim les dades de posicio dels botons_
            app.posStateButtonsTextArea.Value = str_button_tot;
            

            % _Obtenció posicio Spinner_ 
            h_determin_checkbox = findobj(app.UIFigure,'Type','uispinner');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posSpinner.Value = str_button_tot_list;
            
            
            % _Obtenció posicio Grafica_ 
            h_determin_checkbox = findobj(app.UIFigure, 'Type','axes');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posUIAxes.Value = str_button_tot_list;

 
            % _Obtenció posicio Àrea de text_ 
            h_determin_checkbox = findobj(app.UIFigure, 'Type','uitextarea');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.postextareaTextArea.Value = str_button_tot_list;            
            
            % NOTES:
%                 % Els objectes són descrits de la mateixa manera:
%                 objasdf =  findobj(app.UIFigure,'Type','uilabel')
%                 objasdf(1)
%                 % que:
%                 app.LlistamodifLabel


% FINAL FUNCIÓ

end