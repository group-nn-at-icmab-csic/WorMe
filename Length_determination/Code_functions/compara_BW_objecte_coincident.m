function [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = compara_BW_objecte_coincident(BW_conjuntes_comparar, BW_aillar)

% Function on comparing a binary image with a folder of images, to
% obtain the binary matching image. Then the name of this
% image is obtained. (this is the final goal).
% The f'identifica_pump_anterior_nou' is used.
%
% Conditions: both images must be binarized.
%
% Variables
% BW_aillar              :  Binary image of a singular object, which you want to isolate.
% BW_conjuntes_comparar  :  Binary image with several binary objects. To be compared with the BW_aillar.
%
% See also
% identifica_pump_anterior_nou


% START OF THE FUNCTION

% We skeletonize our input image (save trouble)
BW_aillar_skel = bwskel(BW_aillar);
%imshow(BW_aillar_skel)


% Preliminary checks
% If either of the two images is not binary
if length(unique(BW_aillar(:)))>2 || length(unique(BW_conjuntes_comparar(:)))>2
    f = msgbox('Non binary image', 'Error','error');
end

% Check the number of elements in the BW of multiple objects.
[~, nombre_elements] = bwlabel(BW_conjuntes_comparar);

% Check that there are elements
if nombre_elements == 0
    f = msgbox("No hi ha elements binaris", 'Error','error');
end


% Identify previous pump
[llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identifica_pump_anterior_nou(BW_conjuntes_comparar, BW_aillar_skel, "", false, "");


% Notes: if there is no matching image, the variable 'llist_BW_identif' is empty.
% This will be useful for using this option to filter the images.
% % Example if the image is all zeros
% BW_zero = zeros(size(BW_aillar));
% [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identifica_pump_anterior_nou(BW_conjuntes_comparar, BW_zero, "", false, "");


% Check for more than one detected image.
if length(llist_BW_identif) > 1
    f = msgbox("More than a image", 'Error','error');
end


% END OF FUNCTION

end