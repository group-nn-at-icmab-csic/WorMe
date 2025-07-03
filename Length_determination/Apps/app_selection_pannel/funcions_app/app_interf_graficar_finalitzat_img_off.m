function app_interf_graficar_finalitzat_img_off(app)

% Desactivació i activació dels botóns i figures de la GUI quan aquesta
% arriba a la imatge de finalització: estadística.
%
% Funció de la app 'app_selection_pannel'.
%
% See also
% app_interf_graficar_finalitzat_img

% INICI FUNCIO


% Desactivem botóns
app_interf_enable_thickcrosret_buttons(app, 'on')

app.Hyperlink.Visible = 'off';
app.CitationLabel.Visible = 'off';
    
app.finalitzat_contLabel.Text = "false";

app.OriginalButton.Visible = 'on';

% Coloració Botó Done
% app.DoneButton.BackgroundColor = "green";
app.DoneButton.BackgroundColor = [0.96,0.96,0.96];

app.Image.Visible = 'on';
app.UIAxes.Visible = 'off';
app.ExportButton.Visible = 'off';
app.ExitButton.Visible = 'off';
app.Image5.Visible = 'off';


                    
% Activació/Desactivacio botons
app_interf_onoff_botons_done(app, 'on')
% Desactivem, però, alguns:
% % (a posar en un futur)
% app.NotFinishedImagesLabel.Visible = 'off';

% Estadística
% Estadístics
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
app.n_yesLabel.Visible = 'on';
app.Thick_Button_little.Visible = 'on';
app.n_yesLabel2.Visible = 'off';
app.n_noLabel.Visible = 'on';
app.Cross_Button_little.Visible = 'on';
app.n_noLabel2.Visible = 'off';
app.acceptedLabel.Visible = 'off';
app.refusedLabel.Visible = 'off';

app.LupaReturnButton.Visible = 'off';

% On del Done
app.DoneButton.Visible = 'on';
app.LeftButton.Visible = 'on';


% Mirem si el botó return hi ha de ser:



% FINAL FUNCIÓ

end