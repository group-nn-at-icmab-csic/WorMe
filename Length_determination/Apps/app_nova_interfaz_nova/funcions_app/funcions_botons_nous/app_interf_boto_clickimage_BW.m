function app_interf_boto_clickimage_BW(app)


% Botó clicar imatge inferior BW

% INICI FUNCIO

            % Imatge sota binària:


            % Si està original com l'inici
            if app.cont_canvi_img_1
                app.BW_img_temp = app.Image4.ImageSource;
                app.Image4.ImageSource = app.Image.ImageSource;
                app.Image.ImageSource = graficar_rgbgraybw_image(app.BW_img_extend);

                app.cont_canvi_img_1 = false;

            % Si està canviat
            else
                app.BW_img_temp = app.Image4.ImageSource;
                app.Image4.ImageSource = graficar_rgbgraybw_image(app.BW_img_cuted);
                app.Image.ImageSource = app.BW_img_temp;

                app.cont_canvi_img_1 = true;
            end




            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)         

% FINAL FUNCIÓ

end