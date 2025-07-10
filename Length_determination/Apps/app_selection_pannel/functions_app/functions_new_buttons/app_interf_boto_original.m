function app_interf_boto_original(app)

% Original Button
%
% Displays the original image.

% START OF FUNCTION


            % Update buttons (imcrop)
            app.imcrop_value = [];

            if ~app.OriginalButton.Value
                app.OriginalButton.Value = false;

                % Update
                app_interf_actualitzacio_graficacio(app, false)

            else

                imatge_original = imread(strcat(app.dir_imgs_orig, "\", app.img_original_nomLabel.Text));
                app.Image.ImageSource = imatge_original;
                app.OriginalButton.Value = true;

            end
            
            
            % Refresh figure to enable shortkey
            figure(app.UIFigure)      

% END OF FUNCTION


end