function app_interf_video_demostratiu(app, video_ruta)


% Mostrar el vídeo en la App
%
% Variables
%   video_ruta: ruta del video que es vol mostrar.
%       ex: "Imatges_logos_musica\Videos\WorMe_1_Scissors_final.mp4";
%
%

% INICI FUNCIO

app.stop_video = false;

app.Image.Visible = 'off';
app.UIAxes2.Visible = 'on';
app.CloseVideoButton.Visible = 'on';


input_video_file = video_ruta; 
vidObj = VideoReader(input_video_file);
while(hasFrame(vidObj))
    frame = readFrame(vidObj);
    imshow(frame, 'Parent', app.UIAxes2);   % <--- use the Parent property
    pause(1/vidObj.FrameRate);
    % Si es vol el temps a la mitat: pause(2/vidObj.FrameRate);

    if app.stop_video
        break
    end
end

% Tornem a activar les imatges:
app.Image.Visible = 'on';
app.UIAxes2.Visible = 'off';
app.CloseVideoButton.Visible = 'off';

% Correccio que no surti ultim frame
imshow("Apps\app_selection_pannel\Imatges_utilitat\imatge_background_fosc.png", 'Parent', app.UIAxes2);            

% FINAL FUNCIÓ


end