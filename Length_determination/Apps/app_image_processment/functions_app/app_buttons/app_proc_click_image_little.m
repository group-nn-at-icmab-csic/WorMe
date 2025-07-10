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


    % Positions of the image 1 for image 3 is changed, and vice versa. 

    pos_img3 = app.Image3.Position;
    pos_img = app.Image.Position;

    app.Image3.Position = pos_img;
    app.Image.Position = pos_img3;


% END OF THE FUNCTION


end