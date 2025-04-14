function app_interf_boto_cross(app)

% Botó Cross

% INICI FUNCIÓ

    % __Modificació__
    app_interf_taula_modif_cross(app)
    
    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, true)
    
    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)


% FINAL FUNCIÓ

end