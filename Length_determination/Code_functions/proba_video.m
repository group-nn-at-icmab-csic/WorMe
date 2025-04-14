function proba_video(cell_video)

%% INICI CODI

% images    = cell(30,1);
% for i=1:30
%  images{i} = imread(sprintf('%d.jpg',i));
%  images{i} = imread(sprintf('%d.jpg',i));
% end

% Nota: des de MATLAB no es pot executar automàticament el vídeo.

images = cell_video;
len_images = length(images);
% create the video writer with 30 fps
writerObj = VideoWriter('Internal code files\Videos\Rotation_width.avi');
writerObj.FrameRate = 30;
% open the video writer
open(writerObj);
% write the frames to the video

for u=1:len_images

    % convert the image to a frame
    frame = im2frame(images{u});
    writeVideo(writerObj, frame);

end
% close the writer object
close(writerObj);

% Executar el vídeo
% implay('Internal code files\Videos\Rotation_width.avi');


% S'hauria de traslladar el video i borrar-lo a posteriori.


%Reference: https://es.mathworks.com/matlabcentral/answers/271490-create-a-movie-from-images

%% FINAL CODI


end