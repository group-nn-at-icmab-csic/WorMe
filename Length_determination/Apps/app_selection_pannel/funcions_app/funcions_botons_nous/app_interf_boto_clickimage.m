function app_interf_boto_clickimage(app)


% Botó clicar imatge


% INICI FUNCIÓ


            % Si està original com l'inici
            if app.cont_canvi_img_1

                app.Image4.ImageSource = app.Image.ImageSource;
                app.Image.ImageSource = graficar_rgbgraybw_image(app.BW_img_extend);

                app.cont_canvi_img_1 = false;

            % Si està canviat
            else
                app.Image.ImageSource = app.Image4.ImageSource;
                app.Image4.ImageSource = graficar_rgbgraybw_image(app.BW_img_cuted);

                app.cont_canvi_img_1 = true;
            end


            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)                

% FINAL FUNCIÓ

end