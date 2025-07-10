function app_interf_boto_lupa(app)

% Botó lupa

% INICI FUNCIO



            imatge_principal = app.Image.ImageSource;
            

            % Retallem la imatge en fer zoom
            [~, xy_punts_a_retall] = imcrop(imatge_principal);


            %Si s'ha realitzat una selecció
            if ~isempty(xy_punts_a_retall)
                close
                xy_punts_a_retall = floor(xy_punts_a_retall);
                
                [imatge_primera_retallada] = cut_imgs_points(imatge_principal, xy_punts_a_retall);
                %imshow(imatge_primera_retallada)
                
                app.Image.ImageSource = imatge_primera_retallada;
                                
                
                % _Mostrar la imatge en un UIAxes_
                % ÇÇÇ AUGMENTA MOLT LA QUALITAT, ÉS LO SEU.
                % imshow("PNG_BW.png", 'Parent', app.UIAxes); 
                
                % Fem visible el botó de return de la imatge:
                %app.LupaButton_return.Visible = 'on';

                % Guardem la variable
                app.imcrop_value = xy_punts_a_retall;
                
            end            
            
            
            app.LupaReturnButton.Visible = 'on';



            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)                


% FINAL FUNCIO

end