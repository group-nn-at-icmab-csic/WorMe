function app_interf_boto_dreta(app)

% Botó Dreta

% INICI FUNCIÓ
    
    % ___Modif dreta___
    n_imatge = str2num(app.img_contLabel.Text);
    
    % Sumem contadors
    app.img_contLabel.Text = string(n_imatge +1);
    %_nom imatge_
    [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge+1);        % Obtenció nom imatge
    app.img_original_nomLabel.Text = nom_img_original;         %Actualització nom imatge

    
    
    % __Actualització i Graficació__ %
    app.imcrop_value = [];
    app_interf_actualitzacio_graficacio(app, false)
    
    % Imatge anterior
    app_interf_determinar_ultim_object(app, false, "no_res")
    
    % Actualitzem figura per capacitar shortkey
    figure(app.UIFigure)  

    
% FINAL FUNCIÓ

end