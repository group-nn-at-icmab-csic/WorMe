function app_proc_click_image_little(app)

% In app_image_processing App, to click in the little image.
%
% Visualization of the image is changed: the original goes in the main
% image.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    % Es canvien les posicións de la imatge 1 per la imatge 3, i
    % viceversa.

    pos_img3 = app.Image3.Position;
    pos_img = app.Image.Position;

    app.Image3.Position = pos_img;
    app.Image.Position = pos_img3;


% END OF THE FUNCTION


end