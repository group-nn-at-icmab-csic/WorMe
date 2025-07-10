function app_proc_valuechanged_modif_temp(app)

% In app_image_processing App, the modification of the list box of temporal modifications (ModificacionstemporalsListBoxValueChanged).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION
    % UPDATE OF THE MODIFICATIONS
    % Get the selected text from the ListBox:
    value_listbox = app.ModificacionstemporalsListBox.Value;
    app.ImatgeLabel.Text = string(value_listbox);
    
    % Get the selected text from the ListBox:
    [array_processaments, ~] = app_proc_obtenir_array_modificacions(app);

    if ~isempty(array_processaments)
        app.Modificacions_actuals.Value = array_processaments';
    else
        app.Modificacions_actuals.Value = "";
    end
    
    % Deselect saved modifications when selecting
    % saved modifications.
    app.ModificacionsguardadesListBox.Value = {};
    app.ModificarButton.Visible = 'off';            
    

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


% END OF THE FUNCTION


end