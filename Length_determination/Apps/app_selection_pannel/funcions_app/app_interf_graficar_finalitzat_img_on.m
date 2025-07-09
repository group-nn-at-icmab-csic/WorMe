function app_interf_graficar_finalitzat_img_on(app)


% Activa botóns estadística


% INICI FUNCIÓ

            % Contador per retorn a imatge finalitzat.
            app.finalitzat_a_estadistica = true;
            
            % Cambi visualització figures
            app.Image.Visible = 'off';
            app.Image4.Visible = 'off';
            app.UIAxes.Visible = 'on';
            app.DoneButton.Visible = 'off';
            app.Thick_Button.Visible = 'off';
            app.Cross_Button.Visible = 'off';
            % app.ReturnButton.Visible = 'off';
            app.SpinnerRound.Visible = 'off';
            app.OriginalButton.Visible = 'off';
            app.n_objecteLabel.Visible = 'off';
            app.img_original_nomLabel.Visible = 'off';
            app.img_contLabel.Visible = 'off';
            app.img_tot_nLabel.Visible = 'off';
            app.Image2.Visible = 'off';
            app.Image3.Visible = 'off';
            app.LastmodifLabel.Visible = 'off';
            app.ModificacinsguardadesListBoxLabel.Visible = 'off';
            app.ModificacionsguardadesListBox.Visible = 'off';
            app.ModificacionstemporalsListBox.Visible = 'off';
            app.ModificacionstemporalsListBoxLabel.Visible = 'off';
            app.RightButton.Visible = 'off';
            app.LeftButton.Visible = 'off';
            app.SelectionLabel.Visible = 'off';
            app.ImageLabel.Visible = 'off';
            app.ofLabel.Visible = 'off';
            app.ObjectnLabel.Visible = 'off';
            app.ReturnButton.Visible = 'on';       
            app.ReturnButton.Enable = 'on';
            app.ImageLabel_2.Visible = 'off';
            app.dir_img_orig_sLabel.Visible = 'off';
            app.FolderLabel.Visible = 'off';            

            % filtres
            app.FiltersLabel.Visible = 'off';
            app.MaxCircularityButton.Visible = 'off';
            app.SpinnerRound.Visible = 'off';
            app.MinWidthStateButton.Visible = 'off';
            app.MinLengthStateButton.Visible = 'off';
            app.MinLengthTextArea.Visible = 'off';
            app.MinWidthTextArea.Visible = 'off';
            
            % tools
            app.ToolsLabel.Visible = 'off';
            app.CutButton.Visible = 'off';
            app.DrawLineButton.Visible = 'off';
            app.LupaButton.Visible = 'off';
            app.LupaReturnButton.Visible = 'off';
            app.PintarButton.Visible = 'off';
            app.TutorialButton.Visible = 'off';
            

            
            
            % Statistics buttons labels
            app.UIAxes.Visible = 'on'; 
            app.ExitButton.Visible = 'on';
            app.ExportButton.Visible = 'on';
            app.max_valLabel.Visible = 'on';
            app.maxLabel.Visible = 'on';
            app.minLabel.Visible = 'on';
            app.min_valLabel.Visible = 'on';
            app.std_valLabel.Visible = 'on';
            app.stdLabel.Visible = 'on';
            app.meanLabel.Visible = 'on';
            app.mean_valLabel.Visible = 'on';
            app.nLabel.Visible = 'on';
            app.n_valLabel.Visible = 'on';
            app.ExportIAdataButton.Visible = 'on';
            app.InfoIcon_3.Visible =  'on';
            app.InfoIcon_2.Visible =  'on';
            app.ExportnoncorrectedmanualerrordataCheckBox.Visible =  'on';
            
            app.Image5.Visible = 'on';
            
            app.n_yesLabel.Visible = 'off';
            app.Thick_Button_little.Visible = 'off';
            app.n_yesLabel2.Visible = 'on';
            app.n_noLabel.Visible = 'off';
            app.Cross_Button_little.Visible = 'off'; 
            app.n_noLabel2.Visible = 'on';
            app.acceptedLabel.Visible = 'on';
            app.refusedLabel.Visible = 'on';


            




% FINAL FUNCIÓ


end