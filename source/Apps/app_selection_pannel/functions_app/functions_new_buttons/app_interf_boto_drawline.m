function app_interf_boto_drawline(app)

% Draw line button


% START OF FUNCTION

    % Note: the differentiation in the data of the drawn objects will be done by
    % the width values ("WidthValues"), described as "Drawedline"

    % __Modification__
    app_interf_table_modif_drawline(app)

    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, false)

    % Refreshed figure to enable shortkey
    figure(app.UIFigure)


% END OF FUNCTION


end