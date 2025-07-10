function app_proc_button_tutorial_imadjust(app)

% In app_image_processing App, the button shows the tutorial image of imadjust.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Change the image for the tutorial image: 
    imatge_ex_tutorial = imread("Apps\app_image_processment\Internal code files\Images_tutorial\imadjust.png");
    app.Image.ImageSource = imatge_ex_tutorial;

    pause(3)

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


% END OF THE FUNCTION


end