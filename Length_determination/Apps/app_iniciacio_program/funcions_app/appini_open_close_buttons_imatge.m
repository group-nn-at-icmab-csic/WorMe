function appini_open_close_buttons_imatge(app, VisEn, button_val)

% Aqui va la descripció
%
%
% Variables
%   input
%       app - app
%       button_val - 'on' o 'off' dels botóns
%       VisEn : Determina si es determina sobre visible o enable els
%       botóns:
%
%
% See also
%


% INICI FUNCIÓ


if VisEn == "Visible"

    app.NofimagesLabel.Visible = button_val;
    app.n_value_imagesLabel.Visible = button_val;
    app.current_folderLabel.Visible = button_val;
    app.FolderLabel.Visible = button_val;
    app.UIAxes.Visible = button_val;
    app.n_img_acutLabel.Visible = button_val;
    
    app.img_nameLabel.Visible = button_val;
    
    % Obtenim propietats de la imatge
    app.ImageresolutionLabel.Visible = button_val;
    app.valure_resolutionLabel.Visible = button_val;
    app.ImagefiletypeLabel.Visible = button_val;
    app.image_type_fileLabel.Visible = button_val;

elseif VisEn == "Enable"


    app.NofimagesLabel.Enable = button_val;
    app.n_value_imagesLabel.Enable = button_val;
    app.current_folderLabel.Enable = button_val;
    app.FolderLabel.Enable = button_val;
    % app.UIAxes.Enable = button_val;
    app.n_img_acutLabel.Enable = button_val;
    
    app.img_nameLabel.Enable = button_val;
    
    % Obtenim propietats de la imatge
    app.ImageresolutionLabel.Enable = button_val;
    app.valure_resolutionLabel.Enable = button_val;
    app.ImagefiletypeLabel.Enable = button_val;
    app.image_type_fileLabel.Enable = button_val;
    
else
    msgbox("appini_open_close_buttons_imatge not well defined")
end





% FINAL FUNCIÓ


end