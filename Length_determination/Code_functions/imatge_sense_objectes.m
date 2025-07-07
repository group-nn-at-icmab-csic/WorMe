function [nonobj_imageArray_ambtext] = imatge_sense_objectes(imageArray)

% Given an RGB image, its resolution is lowered and the text that there are no objects is added.

% START FUNCTION

% nonobj_imageArray = imageArray -50;
nonobj_imageArray = imageArray - mean(imageArray(:))/2;

% imshow(nonobj_imageArray)

[nonobj_imageArray_ambtext] = ficar_text_imatge(nonobj_imageArray, "Non object detected", "", "auto");

% imshow(nonobj_imageArray_ambtext)

% END FUNCTION


end