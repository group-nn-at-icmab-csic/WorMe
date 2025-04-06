function app_interf_boto_original(app)

% Botó Original
%
% Mostra la imatge orginial.

% INICI FUNCIÓ


            % Actualitzat botons (imcrop)
            app.imcrop_value = [];

            if ~app.OriginalButton.Value
                app.OriginalButton.Value = false;

                % Actualització
                app_interf_actualitzacio_graficacio(app, false)

            else

                imatge_original = imread(strcat(app.dir_imgs_orig, "\", app.img_original_nomLabel.Text));
                app.Image.ImageSource = imatge_original;
                app.OriginalButton.Value = true;

            end
            

            
            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)      

% FINAL FUNCIÓ

end