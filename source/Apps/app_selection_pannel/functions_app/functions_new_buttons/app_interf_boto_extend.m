function app_interf_boto_extend(app)

% Extend Button


% START OF FUNCTION

    % __Modification__
    app_interf_table_modif_extend(app)

    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, true)
        
    % Figure updated to enable shortkey
    figure(app.UIFigure)


% END OF FUNCTION



end

