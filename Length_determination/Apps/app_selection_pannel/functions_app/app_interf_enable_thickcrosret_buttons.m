function app_interf_enable_thickcrosret_buttons(app, enable_cod)

% Determines if the defined buttons are open or not
% Function of the app 'app_selection_pannel'.

% START OF THE FUNCTION

app.Cross_Button.Visible = enable_cod;
app.Thick_Button.Visible = enable_cod;         
app.ReturnButton.Visible = enable_cod;
app.ReturnButton.Enable = enable_cod;

app.Cross_Button_little.Visible = enable_cod; 
app.Thick_Button_little.Visible = enable_cod;

app.RightButton.Visible = 'off';

% If there are objects or not, the return button is shown or not.
if numel(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :).nModif) >= 1
    app.ReturnButton.Visible = 'on';
else
    app.ReturnButton.Visible = 'off';
end

% FINAL OF THE FUNCTION


end