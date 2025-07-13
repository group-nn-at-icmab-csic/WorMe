function app_interf_button_info_brush(app)

% Information button of brush tutorial, in app_selection_pannel.
%
%
% See also
% app_selection_pannel


% START OF THE FUNCTION   

    % _Show video function_
    video_ruta =  "Images_resources\Tutorial_videos\WorMe_Brush.mp4";

    if isfile(video_ruta)
        %app_interf_video_demostratiu(app, video_ruta)
        winopen(video_ruta);
    else
        print("Ruta vídeo no especificada.")
    end            

    % Update figure for to capacite shortkey
    figure(app.UIFigure)

% FINAL OF THE FUNCTION


end
 