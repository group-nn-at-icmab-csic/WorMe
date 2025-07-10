function app_interf_boto_thick(app)

% Thick Button

% START OF FUNCTION


    app.ReturnButton.Visible = 'on';
    app.ReturnButton.Enable = 'on';

    
    % % _Activation/Deactivation of Buttons_ 
    % app_interf_enable_thickcrosret_buttons(app, 'on')


    % __Modification__
    app_interf_taula_modif_thick(app)
    
    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, true)
        
    % Figure updated to enable shortkey
    figure(app.UIFigure)

% END OF FUNCTION


end