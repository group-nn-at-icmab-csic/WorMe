function app_interf_startupFcn(app)


% StartupFcn funcio


% START FUNCTION

            % TO DO
            %
            % 
            % Check return: does not work when filters are applied...
            %
            % Objects touching the border: Make surrounding pixels removed:
            % the values of multiple index in the
            % dimensions, remove them.
            %
            % Filter by roundness. Determine percentage.
            %
            % Original Img button ("s")
            %
            % Length marker
            % Counter of C. elegans done.
            % Cross button for "No C. eleg"
            % So that the "Done" button can end, at whatever time the images are.
            %
            % Show graph with the data of the selected: No worms,
            % average length, length histogram? Also give
            % data normality? Direct normality test? With
            % a 'show statistics' button?
            %
            % ççç add condition if the modification is or is not the same.
            %
            % ççç When changing the modification type (app.ModificacionstemporalsListBox, app.ModificacionsguardadesListBox), reset
            % all data of the current image. (= avoid mess).
            % 
            % Export binary images.
            % Export data in Pascal VOC format


            % FUTURE TO DO
            % Add a section in the application to receive
            % user comments and feedback.
            
            
            % Variables
            %
            % Input
            % -----
            % dir_img_originals : folder with the selected original images.
            %
            %
            % Files
            % -------
            % dir_output, "/main_data_analysis.txt" - Main data file
            %
            % temporals:
            % dir_output, "\temp_indx_BWobject.txt" - Index of objects (temporary)
            % dir_output,"\temp_indx_BWskel.txt"    - Skeletonization index (temporary)
            %
            %
            %

            % Counters
            % ---------
            % _Main:
            % img_contLabel : original 'n' image from the folder. Increments when moving to next image and decrements on return.
            %                 This is based on the current image being operated.
            %
            % _ Secondary:
            % img_tot_nLabel : Total number of images in the folder. Used to see completion.
            % finalitzat_contLabel: Completion counter of all images.
            % n_objecte_Label : number of objects in the image.
            



            % _Counters names and directories_
            % img_original_nomLabel : original image name (ex: img_290.jpg)

            
            % Initial variables
            dir_img_originals = app.dir_imgs_orig;            
            dir_output = app.appv_dir_output;




            % Initial requirements
            % ---------------------
            % Check initial requirements:
            % Images do not contain '$'
            
            
            % ___Initial description counters___
            app.finalitzat_contLabel = "false";
            app.n_objecteLabel.Text = "1"; % ÇÇÇ Check if there are objects or not in the image. If none, change it.
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
            app.Thick_Button_little.Visible = 'on';            
            app.n_yesLabel2.Visible = 'off';
            app.n_noLabel.Visible = 'on';
            app.Cross_Button_little.Visible = 'on';            
            app.n_noLabel2.Visible = 'off';
            app.acceptedLabel.Visible = 'off';
            app.refusedLabel.Visible = 'off';

            
            
            



            % READING IMAGES .jpg and .png from the folder:
            % [theFiles] = read_imgs_folder_structure(dir_img_originals);
            % Note: images are not ordered the same way Windows does, ordering patterns are slightly different.

            theFiles = app.theFiles_arxiu;

            % Get 1st image
            baseFileName = theFiles(1).name;
            %disp(baseFileName)
            fullFileName = fullfile(theFiles(1).folder, baseFileName);
            imatge_original = imread_ifgrey(fullFileName);
            app.Image.ImageSource = imatge_original;
            
            % _Describe the original first image name_
            app.img_original_nomLabel.Text = baseFileName;            
            

            % _Save current image counter_
            app.img_contLabel.Text = "1";
            % Total images length
            app.img_tot_nLabel.Text = string(length(theFiles)); % Total images counter
            
            
            % Save folder name
            dir_img_originals_sing_t = split(dir_img_originals, "\");
            dir_img_originals_sing = dir_img_originals_sing_t{end}; % Works
            app.dir_img_orig_sLabel.Text = dir_img_originals_sing;
            
            % ____Check modifications____
            % Define the Temporary Modifications Box, from
            % the documents created:
            
            % Automation Drop Roll Temporary Modifications
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
            patro_tipus_image = ".txt";

            [llistat_string_im_temp] = read_files_typology(myFolder_input, patro_tipus_image);          
                        
            app.ModificacionstemporalsListBox.Items = llistat_string_im_temp;
            
            % Read Saved Modifications files
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
            patro_tipus_image = ".txt";
            [llistat_string_im_guard] = read_files_typology(myFolder_input, patro_tipus_image);
            app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
            
            % If saved modifications are empty
            if isempty(app.ModificacionsguardadesListBox.Items)
                
                % If temporary modifications are also empty
                if isempty(app.ModificacionstemporalsListBox.Items)
                    % Make a new modification
                    app.NovamodificaciButtonPushed;
                else
                    % Otherwise, select the modifications
                    app.ModificacionstemporalsListBox.Value = llistat_string_im_temp(end);
                end

            else
                app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
                app.ModificacionsguardadesListBox.Value = llistat_string_im_guard(end);

                if ~isempty(app.ModificacionstemporalsListBox.Items)
                    app.ModificacionstemporalsListBox.Value = {};
                end
            end
            
            
            % _Read the saved modification_
            filestxt = read_txt_folder_structure(strcat(dir_output, "\Processment_parameters"));
            text_config_parameters = filestxt.name;
            dir_text_config_parameters = strcat(dir_output, "\Processment_parameters\", text_config_parameters);
            [array_sortida_modifs, ~] = read_text_delimiters(dir_text_config_parameters, ";"); % obtain the array from reading the text document and print it
            cell_cont = array_sortida_modifs(2:end, 2); % Operate
            array_processaments = cell2array_own(cell_cont);

            
            if ismember(text_config_parameters, app.ModificacionsguardadesListBox.Items)
                % Select in Saved Modifications ListBox:
                app.ModificacionsguardadesListBox.Value = text_config_parameters;
                app.ModificacionstemporalsListBox.Value = {};
                
            elseif ismember(text_config_parameters, app.ModificacionstemporalsListBox.Items)
                % Select in Saved Modifications ListBox:
                app.ModificacionstemporalsListBox.Value = text_config_parameters;
                app.ModificacionsguardadesListBox.Value = {};                
            end
            
            % __Update and Plot__ %
            app_interf_actualitzacio_graficacio(app, false) %





            % Upgrade interface WM 2.15
            app_interf_table_act_dretaesquerra(app)            


            
            % Center the GUI
            % ..............
            UIFigure_position = app.UIFigure.Position; %100   100   602   389
                                                      % start end width length
            screensize_position = get(0, 'ScreenSize'); %         1           1        1920        1080
            [UIFigure_position_new] = centered_GUI_screen(UIFigure_position, screensize_position);
            app.UIFigure.Position = UIFigure_position_new;
            
                        
            % To create the cell to write with data, we could
            % make an empty cell of 7 and add contents depending on
            % what is defined.
            % cell(1,7)
            
            % _Create main data file_
            fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'w');
            fclose(fid);
            
            


            % ____Description of the positions of the App objects____

            % % Obtain the typology of the GUI objects
            % obj_h = findobj(app.UIFigure);
            % get(obj_h,'Type')

            % _Get initial positions_
            pos_fig = app.UIFigure.Position;
            pos_img =  app.Image.Position;         
            
            % _Describe the position data of the image_
            app.posFigTextArea = strjoin(string(pos_fig), ";");
            app.posImgTextArea = strjoin(string(pos_img), ";");
            
            % _Get position of buttons_
            h_determin_button = findobj(app.UIFigure,'Type','uibutton');
            [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
            % _Describe the position data of the buttons_
            app.posButtonsTextArea = str_button_tot;

            
            % _Get position of listbox_
            h_determin_listbox = findobj(app.UIFigure,'Type','uilistbox');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_listbox);
            app.posListboxTextArea = str_button_tot_list;
            
            
            % _Get position of listbox_
            h_determin_label = findobj(app.UIFigure,'Type','uilabel');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_label);
            app.posLabelTextArea = str_button_tot_list;
            
            
             % _Get position of image_ 
            h_determin_imgs = findobj(app.UIFigure,'Type','uiimage');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_imgs);
            app.posImatgesTextArea = str_button_tot_list;

            
            
             % _Get position of hyperlink_ 
            h_determin_hyperlink = findobj(app.UIFigure,'Type','uihyperlink');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_hyperlink);
            app.posHyperlinkTextArea = str_button_tot_list;

            % _Get FontSize factor_
            fact_fontsize = h_determin_hyperlink.FontSize / sqrt(pos_fig(3) * pos_fig(4));
            app.sizeFontTextArea = string(fact_fontsize);

            
            % _Get position of state button_
            h_determin_button = findobj(app.UIFigure,'Type','uistatebutton');
            [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
            % _Describe the position data of the buttons_
            app.posStateButtonsTextArea = str_button_tot;
            

            % _Get position of Spinner_ 
            h_determin_checkbox = findobj(app.UIFigure,'Type','uispinner');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posSpinner = str_button_tot_list;
            
            
            % _Get position of Graph_ 
            h_determin_checkbox = findobj(app.UIFigure, 'Type','axes');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posUIAxes = str_button_tot_list;

 
            % _Get position of Numeric field (text area)_ 
            h_determin_checkbox = findobj(app.UIFigure, 'Type','uinumericeditfield');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posEditfield = str_button_tot_list;


            % _Get position of Check box_ 
            h_determin_checkbox = findobj(app.UIFigure, 'Type','uicheckbox');
            [~, str_button_tot_list] = app_resize_obtenir_positions(h_determin_checkbox);
            app.posCheckBox = str_button_tot_list;
            

            
            % NOTES:
%                 % Objects are described in the same way:
%                 objasdf =  findobj(app.UIFigure,'Type','uilabel')
%                 objasdf(1)
%                 % than:
%                 app.LlistamodifLabel


% END FUNCTION


end