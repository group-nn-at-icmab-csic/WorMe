function app_interf_enable_thickcrosret_buttons(app, enable_cod)

% Determina si els botóns definits estàn o no oberts
% Funció de la app 'app_selection_pannel'.

app.Cross_Button.Visible = enable_cod;
app.Thick_Button.Visible = enable_cod;         
app.ReturnButton.Visible = enable_cod;
app.ReturnButton.Enable = enable_cod;

app.Cross_Button_little.Visible = enable_cod; 
app.Thick_Button_little.Visible = enable_cod;



app.RightButton.Visible = 'off';

% Si hi ha o no objectes, es mostra o no el return.
if numel(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :).nModif) >= 1
    app.ReturnButton.Visible = 'on';
else
    app.ReturnButton.Visible = 'off';
end

end