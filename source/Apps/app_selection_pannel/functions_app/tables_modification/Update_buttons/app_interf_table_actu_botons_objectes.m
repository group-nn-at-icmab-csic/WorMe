function app_interf_table_actu_botons_objectes(app, tf_porta)


% Update buttons if there are no objects true/false

% START OF THE FUNCTION

if ~tf_porta
    % There are no objects
    app.RightButton.Visible = 'on';
    app.LeftButton.Visible = 'on';
    app.Thick_Button.Visible = 'off';
    app.Cross_Button.Visible = 'off';    
    app.CutButton.Visible = 'off';
    app.PintarButton.Visible = 'off';
    
else
    % There are objects
    app.RightButton.Visible = 'on';
    app.LeftButton.Visible = 'on';
    app.Thick_Button.Visible = 'on';
    app.Cross_Button.Visible = 'on';   
    app.CutButton.Visible = 'on';
    app.PintarButton.Visible = 'on';
    
end

% END OF THE FUNCTION


end