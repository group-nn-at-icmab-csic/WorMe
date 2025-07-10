function app_interf_boto_return(app)

% Return Button

% START OF FUNCTION

% Variable notes:
% app.finalitzat_a_estadistica 

    % If coming from statistics, update buttons.
    if app.finalitzat_a_estadistica
        % disp("Return from statistics")

        % Image finished counter
        app.finalitzat_contLabel = "false";

        % Redefine counters
        app_interf_graficar_finalitzat_img_off(app)
        
        app.finalitzat_a_estadistica = false;
    end    

    % __Modification__
    app_interf_taula_modif_return(app)


    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, false)

    app_interf_determinar_ultim_object(app, false, "no_res")    % Previous image

    % Update figure to enable shortkey
    figure(app.UIFigure)


% END OF FUNCTION


end