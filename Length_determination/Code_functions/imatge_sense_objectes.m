function [nonobj_imageArray_ambtext] = imatge_sense_objectes(imageArray)

% Donada una imatge RGB, es baixa la resolució d'aquesta i se li posa el text de que no hi ha objectes.

% INICI FUNCIÓ 

% nonobj_imageArray = imageArray -50;
nonobj_imageArray = imageArray - mean(imageArray(:))/2;

% imshow(nonobj_imageArray)

[nonobj_imageArray_ambtext] = ficar_text_imatge(nonobj_imageArray, "Non object detected", "", "auto");

% imshow(nonobj_imageArray_ambtext)

% FINAL FUNCIÓ


end