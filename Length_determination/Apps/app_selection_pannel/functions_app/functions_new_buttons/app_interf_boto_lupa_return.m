function app_interf_boto_lupa_return(app)

% Loupe return button

% START OF FUNCTION



        app.LupaReturnButton.Visible = 'off';

        % Update app.imcrop value
        app.imcrop_value = [];

        % __Update and Plotting__ %
        app_interf_actualitzacio_graficacio(app, true)


        % Refresh figure to enable shortkey
        figure(app.UIFigure)               


% END OF FUNCTION

end