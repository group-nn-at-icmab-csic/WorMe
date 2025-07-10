function app_interf_boto_cross(app)
% Cross Button

% START OF FUNCTION

    % __Modification__
    app_interf_taula_modif_cross(app)
    
    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, true)
    
    % Refreshed figure to enable shortkey
    figure(app.UIFigure)


% END OF FUNCTION


end