function app_interf_graficar_finalitzat_img_off(app)

% Deactivation and activation of buttons and GUI figures when the app
% reaches the completion image: statistics.
%
% Function of the app 'app_selection_pannel'.
%
% See also
% app_interf_graficar_finalitzat_img

% FUNCTION START


% Disable buttons
app_interf_enable_thickcrosret_buttons(app, 'on')

app.Hyperlink.Visible = 'off';
app.CitationLabel.Visible = 'off';
    
app.finalitzat_contLabel = "false";

app.OriginalButton.Visible = 'on';

% Done Button Coloring
% app.DoneButton.BackgroundColor = "green";
app.DoneButton.BackgroundColor = [0.96,0.96,0.96];

app.Image.Visible = 'on';
app.UIAxes.Visible = 'off';
app.ExportButton.Visible = 'off';
app.ExitButton.Visible = 'off';
app.Image5.Visible = 'off';


                    
% Enable/Disable buttons
app_interf_onoff_botons_done(app, 'on')
% Disable some, however:
% % (to be added in the future)
% app.NotFinishedImagesLabel.Visible = 'off';

% Statistics
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

% Done button ON
app.DoneButton.Visible = 'on';
app.LeftButton.Visible = 'on';


% Check if the return button should be visible:


% FUNCTION END


end