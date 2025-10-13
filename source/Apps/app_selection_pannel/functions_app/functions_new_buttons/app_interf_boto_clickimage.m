function app_interf_boto_clickimage(app)

% Click main image button.
% 
% Shows the binary image.
%
% See also
% app_selection_pannel

% START OF THE FUNCTION

    % If there is the orginal as the start
    if app.cont_canvi_img_1

        app.Image4.ImageSource = app.Image.ImageSource;
        app.Image.ImageSource = graph_rgbgraybw_image(app.BW_img_extend);

        app.cont_canvi_img_1 = false;

    % If it is changed
    else
        app.Image.ImageSource = app.Image4.ImageSource;
        app.Image4.ImageSource = graph_rgbgraybw_image(app.BW_img_cuted);

        app.cont_canvi_img_1 = true;
    end


    % Update of the figure to enable shortkeys
    figure(app.UIFigure)                

% FINAL OF THE FUNCTION

end