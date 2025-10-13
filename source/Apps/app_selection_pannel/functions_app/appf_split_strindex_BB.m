function [array_BWobj_fets] = appf_split_strindex_BB(array_str_indx)

% Given an array with text files like:
% "23745;123746;124824;124825;124826;...", it returns the array with the numeric value
% of these.
% 
% Variables
% array_str_indx : array with the index strings.
%                 example: S_textscan_table.Indx_BW
% 
% 

% START OF THE FUNCTION

array_BWobj_fets = [];

% _Data reading_
for n_obj = 1:length(array_str_indx)
    % We read each one, and convert it to double
    indx_BW_obj = double(split(array_str_indx(n_obj), ";"))';% Elapsed time is 0.009027 seconds.
    
    
     % (without preallocation) We move to a single array
     array_BWobj_fets = [array_BWobj_fets; indx_BW_obj];

end

% FINAL OF THE FUNCTION


end
