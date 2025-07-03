function app_interf_boto_mincircularity(app)

% Botó circularitat minima

  
% true: apretat
% false: desapretat

% Nota: aquest botó determinarà el valor dels filtres.

% Spinner:
% app.SpinnerRound.Value

% INICI FUNCIÓ

    % value_buttonstate_round = app.MaxCircularityButton.Value;

    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, true)


    % Actualitzem figura per capacitar shortkey
    figure(app.UIFigure)       

% FINAL FUNCIÓ

end