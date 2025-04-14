function [imatge_primera_retallada] = retallar_imatges_punts(imatge_primera_a_retall, xy_punts_a_retall)

% An image is cropped based on the given points.
% Points are from, for example, an imcrop().
% These points are automatically rounded up, with the ceil() function.
%
% Important to floor if you want to see the imcrop points used.
%
% (CAT)
% Es retalla una imatge en funció als punts determinats. 
% Els punts són provinents, per exemple, d'un imcrop().
% Aquests punts són automaticament arrodonits a l'alça, amb la funció ceil().
%
% Important fer floor si es volen ver servir els punts del imcrop.
%
% Example:
% [BW_final_crop, xy_punts_a_retall] = imcrop(BW_final); close
% xy_punts_a_retall = floor(xy_punts_a_retall);
% 
% [BW_final_crop2] = retallar_imatges_punts(BW_final, xy_punts_a_retall);
% imshow(BW_final_crop2)


xy_punts_a_retall = ceil(xy_punts_a_retall);

imatge_primera_retallada = imatge_primera_a_retall( xy_punts_a_retall(2):xy_punts_a_retall(2) + xy_punts_a_retall(4), ...
xy_punts_a_retall(1):xy_punts_a_retall(1) + xy_punts_a_retall(3), : );
% imshow(imatge_primera_retallada)

end