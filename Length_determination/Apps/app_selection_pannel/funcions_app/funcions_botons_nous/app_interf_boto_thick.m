function app_interf_boto_thick(app)

% Botó Thick

% INICI FUNCIÓ


    app.ReturnButton.Visible = 'on';
    app.ReturnButton.Enable = 'on';

    
    % % _Activació/Desactivació Botóns_ 
    % app_interf_enable_thickcrosret_buttons(app, 'on')


    % __Modificació__
    app_interf_taula_modif_thick(app)
    
    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, true)
        
    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)

% FINAL FUNCIÓ

end