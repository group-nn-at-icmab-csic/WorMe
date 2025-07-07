function app_interf_boto_drawline(app)

% Botó draw line

% % INICI FUNCIÓ (PROBES)
% 
% app.table_main_sel
% 
% [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
% 
% % FINAL FUNCIÓ (PROBES)


% INICI FUNCIÓ

    % Nota: la diferenciació en les dades dels objectes dibuixats es farà pels
    % valors d'amplada ("WidthValues"), descrits com "Drawedline"

    % __Modificació__
    app_interf_table_modif_drawline(app)

    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, false)

    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)


% FINAL FUNCIÓ


end