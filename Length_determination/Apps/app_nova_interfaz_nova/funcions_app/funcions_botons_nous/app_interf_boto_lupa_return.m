function app_interf_boto_lupa_return(app)

% Botó lupa

% INICI FUNCIO



        app.LupaReturnButton.Visible = 'off';

        % Actualitzem valor app.imcrop
        app.imcrop_value = [];

        % __Actualització i Graficació__ %
        app_interf_actualitzacio_graficacio(app, true)


        % Actualitzem figura per capacitar shortkey
        figure(app.UIFigure)               


% FINAL FUNCIO

end