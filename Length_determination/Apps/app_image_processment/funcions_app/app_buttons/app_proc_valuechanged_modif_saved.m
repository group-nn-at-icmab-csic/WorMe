function app_proc_valuechanged_modif_saved(app)

% In app_image_processing App, the value changed function of the saved modifications list (ModificacionsguardadesListBoxValueChanged).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % ACTUALITZACIÓ DE LES MODIFICACIONS
    % Agafem el text seleccionat del ListBox:
    value = app.ModificacionsguardadesListBox.Value;
    app.ImatgeLabel.Text = string(value);
    
    % Agafem el text seleccionat del ListBox:
    [array_processaments, ~] = app_proc_obtenir_array_modificacions(app);
    
    if ~isempty(array_processaments)
        app.Modificacions_actuals.Value = array_processaments';
    else
        app.Modificacions_actuals.Value = "";
    end
    

    % Desseleccionar modificacions temporals, al seleccionar
    % modificacions guardades.
    app.ModificacionstemporalsListBox.Value = {};

    app.ModificarButton.Visible = 'on';            


    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    
    % LECTURA TIPOLOGIA MODIFICACIONS IMATGE            
    % Cambiem botóns, desactivem tots
        % rgb
        app.Im2greyButton.Enable = 'off';
        % gray
        app.imadjustButton.Enable = 'off';
        app.BinarizeButton.Enable = 'off';
        
        % binary
        app.AreaOpenButton.Enable = 'off';
        app.imclearborderButton.Enable = 'off';
        app.imfillButton.Enable = 'off';
        app.OpenButton.Enable = 'off';
        app.CloseButton.Enable = 'off';
        app.Spinner.Enable = 'off';
        app.Spinner_2.Enable = 'off';
        app.Spinner_3.Enable = 'off';

        app.returnButton.Enable = 'off';
        app.flipButton.Enable = 'off';     
        app.imadjust_selectButton.Enable = 'off';



% END OF THE FUNCTION


end