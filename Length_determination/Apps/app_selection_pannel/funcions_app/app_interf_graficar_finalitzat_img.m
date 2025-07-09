function app_interf_graficar_finalitzat_img(app)

% Mostra els botóns de la GUI quan no s'ha arribat al final.
%
% Funció de la app 'app_selection_pannel'.
%
% See also
% app_interf_graficar_finalitzat_img_off

% INICI FUNCIO

% Es sobrepassa la imatge: cartell de Finished
app.Image.ImageSource = imread("Apps\app_selection_pannel\Imatges_utilitat\Finished_WM.png");
% app.Image2.ImageSource = imread("Apps\app_selection_pannel\Imatges_utilitat\Logo_WorMe_blanc.png");


app.Image.Visible = 'on';
app.DoneButton.Visible = 'on';


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


% Continuem graficant la última imatge:
app_interf_graficar_BB_imatge_ultima(app);

% Desactivem botóns
app.Thick_Button.Visible = 'off';
app.Cross_Button.Visible = 'off';


app.Hyperlink.Visible = 'on';
app.CitationLabel.Visible = 'on';

app.finalitzat_contLabel = "true";

app.OriginalButton.Visible = 'off';


% Copiat del botó 'Done'
app_interf_onoff_botons_done(app, 'off')




% Coloració Botó Done
app.DoneButton.BackgroundColor = "green";
% app.DoneButton.BackgroundColor = [0.96,0.96,0.96];

% FINAL FUNCIÓ

end