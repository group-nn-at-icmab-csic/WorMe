function app_proc_button_skeletonize_change(app)

% In app_image_processing App, the button of skeletonize the image (EsqueletonitzarButtonValueChanged).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    %value = app.EsqueletonitzarButton.Value;
    
    % Esqueletonitzar la imatge, per a veure cóm es amb el filtre.

    if app.EsqueletonitzarButton.Value
        app.EsqueletonitzarButton.BackgroundColor = 'y';
    else
        app.EsqueletonitzarButton.BackgroundColor = [0.96,0.96,0.96];
    end
                    
    app.Image2.Visible = 'on';

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    app.Image2.Visible = 'off';        

% END OF THE FUNCTION


end