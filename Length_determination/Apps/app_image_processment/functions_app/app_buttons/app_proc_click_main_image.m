function app_proc_click_main_image(app)

% In app_image_processing App, when the main image is clicked (ImageClicked).
% The binary and original images are changed each other.
%
% See also
% app_image_processment


% START OF THE FUNCTION

   % Positions of the image 1 for image 3 is changed, and vice versa. 

    pos_img3 = app.Image3.Position;
    pos_img = app.Image.Position;

    app.Image3.Position = pos_img;
    app.Image.Position = pos_img3;


%             figure
%             imshow(app.Image.ImageSource);
%             s = get(0, 'ScreenSize');
%             set(gcf,'Units', 'pixels', 'Position',[0 0 s(3) s(4)])
    

% END OF THE FUNCTION


end