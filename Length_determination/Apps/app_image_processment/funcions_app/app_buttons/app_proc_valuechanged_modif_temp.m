function app_proc_valuechanged_modif_temp(app)

% In app_image_processing App, the modification of the list box of temporal modifications (ModificacionstemporalsListBoxValueChanged).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % ACTUALITZACIÓ DE LES MODIFICACIÓNS
    % Agafem el text seleccionat del ListBox:
    value_listbox = app.ModificacionstemporalsListBox.Value;
    app.ImatgeLabel.Text = string(value_listbox);
    
    % Agafem el text seleccionat del ListBox:
    [array_processaments, ~] = app_proc_obtenir_array_modificacions(app);

    if ~isempty(array_processaments)
        app.Modificacions_actuals.Value = array_processaments';
    else
        app.Modificacions_actuals.Value = "";
    end
    
    % Desseleccionar modificacions guardades, al seleccionar
    % modificacions guardades.
    app.ModificacionsguardadesListBox.Value = {};
    app.ModificarButton.Visible = 'off';            
    

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

% END OF THE FUNCTION


end