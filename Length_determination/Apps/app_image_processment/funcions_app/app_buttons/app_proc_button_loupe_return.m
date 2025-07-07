function app_proc_button_loupe_return(app)

% In app_image_processing App, the button of return the loupe (magnification) of the image (ReturnLupaPushed).
% 
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';
    app.ReturnLupa.Visible = 'off';


% END OF THE FUNCTION


end