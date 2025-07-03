function app_interf_taula_actu_return(app)

% Actualitza el botó return si es troba en posicio primera,
% segons condicionants.

% INICI FUNCIO


if isequal(str2num(app.img_contLabel.Text), 1)
    if isempty(app.global_temps_total_inici)
        app.ReturnButton.Visible = 'off';
    elseif isequal(height(app.global_temps_total_inici(app.global_temps_total_inici.Image == string(app.img_original_nomLabel.Text), :)), 1) 
        app.ReturnButton.Visible = 'off';
    elseif isequal(height(app.global_temps_total_inici(app.global_temps_total_inici.Image == string(app.img_original_nomLabel.Text), :)), 0)
        app.ReturnButton.Visible = 'off';        
    else
        app.ReturnButton.Visible = 'on';
    end
end

% FINAL FUNCIO

end