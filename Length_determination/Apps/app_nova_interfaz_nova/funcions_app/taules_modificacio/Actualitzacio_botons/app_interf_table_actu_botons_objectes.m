function app_interf_table_actu_botons_objectes(app, tf_porta)


% Actu botons si no hi ha objectes true/false

% INICI FUNCIÓ

if ~tf_porta
    % No hi ha objectes
    app.RightButton.Visible = 'on';
    app.LeftButton.Visible = 'on';
    app.Thick_Button.Visible = 'off';
    app.Cross_Button.Visible = 'off';    
    app.CutButton.Visible = 'off';
    app.PintarButton.Visible = 'off';
    
else
    % Hi ha objectes
    app.RightButton.Visible = 'on';
    app.LeftButton.Visible = 'on';
    app.Thick_Button.Visible = 'on';
    app.Cross_Button.Visible = 'on';   
    app.CutButton.Visible = 'on';
    app.PintarButton.Visible = 'on';
    
end

% FINAL FUNCIÓ

end