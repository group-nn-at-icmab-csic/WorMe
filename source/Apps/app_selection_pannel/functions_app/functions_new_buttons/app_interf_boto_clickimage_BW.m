function app_interf_boto_clickimage_BW(app)


% Button click lower BW image

% START OF FUNCTION

        % Binary image underneath:


        % If it’s original as at the beginning
        if app.cont_canvi_img_1
            app.BW_img_temp = app.Image4.ImageSource;
            app.Image4.ImageSource = app.Image.ImageSource;
            app.Image.ImageSource = graph_rgbgraybw_image(app.BW_img_extend);

            app.cont_canvi_img_1 = false;

        % If it’s switched
        else
            app.BW_img_temp = app.Image4.ImageSource;
            app.Image4.ImageSource = graph_rgbgraybw_image(app.BW_img_cuted);
            app.Image.ImageSource = app.BW_img_temp;

            app.cont_canvi_img_1 = true;
        end




        % We refresh figure to enable shortkey
        figure(app.UIFigure)         

% END OF FUNCTION


end