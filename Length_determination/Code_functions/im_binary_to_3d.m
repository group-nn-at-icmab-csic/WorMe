function [im_3d] = im_binary_to_3d(im_binary)

% Given a binary image, it is converted to 3 dimensions for its
% possible operation.

% % Variables proba MATLAB Live
% im_proba = cell_video_frames{1}
% imshow(im_proba)
% 
% im_proba_3d = im_binary_to_3d(im_proba)
% class(im_proba_3d)


im_3d = cat(3, im_binary .* 255, im_binary .* 255, im_binary .* 255);


end