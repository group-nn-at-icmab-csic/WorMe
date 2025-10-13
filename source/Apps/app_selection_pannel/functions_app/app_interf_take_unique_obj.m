function [BW_final_object, num] = app_interf_take_unique_obj(BW_final_noproc)


% START OF THE FUNCTION

% Obtain the binary object
[L_variable, num] = bwlabel(BW_final_noproc);
BW_final_object = L_variable == 1;
% imshow(BW_final_object)


% FINAL OF THE FUNCTION

end