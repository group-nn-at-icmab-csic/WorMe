function app_interf_boto_extend(app)

% Botó extend


% INICI FUNCIO

    % __Modificació__
    app_interf_table_modif_extend(app)

    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, true)
        
    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)


% FINAL FUNCIO


end

