function app_interf_button_info_draw(app)

% Information button of draw line tool, in app_selection_pannel.
%
%
% See also
% app_selection_pannel


% START OF THE FUNCTION   

     % Info video Draw

    % _Show video function_
    video_ruta =  "Images_resources\Tutorial_videos\WorMe_Draw.mp4";

    if isfile(video_ruta)
        %app_interf_video_demostratiu(app, video_ruta)
        winopen(video_ruta);
    else
        print("Ruta vídeo no especificada.")
    end

    % Update the figure in order to enable the shortkeys
    figure(app.UIFigure)     

% FINAL OF THE FUNCTION


end
 