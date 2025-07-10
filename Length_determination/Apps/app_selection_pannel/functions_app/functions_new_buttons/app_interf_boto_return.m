function app_interf_boto_return(app)

% Botó Return

% INICI FUNCIÓ

% Notes variables:
% app.finalitzat_a_estadistica 

    % Si prové d'estadística, s'actualitzen els botóns.
    if app.finalitzat_a_estadistica
        % disp("Return des d'estadística")

        % Contador finalitzat imatge
        app.finalitzat_contLabel = "false";

        % Re-definim contadors
        app_interf_graficar_finalitzat_img_off(app)
        
        app.finalitzat_a_estadistica = false;
    end    

    % __Modificació__
    app_interf_taula_modif_return(app)


    % __Actualització i Graficació__ %
    app_interf_actualitzacio_graficacio(app, false)

    app_interf_determinar_ultim_object(app, false, "no_res")    % Imatge anterior

    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)


% FINAL FUNCIÓ

end