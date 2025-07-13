function [array_BWobj_fets] = appf_split_strindex(array_str_indx)

% Given an array of text strings like:
% "23745;123746;124824;124825;124826;...", returns a numeric array
% with all these values converted to numbers.
%
% Variables:
% array_str_indx : array of strings containing indexes
%                  e.g., S_textscan_table.Indx_BW
%

% START OF THE FUNCTION

array_BWobj_fets = [];

% Read and convert each string element:
for n_obj = 1:length(array_str_indx)
    % Split the string by semicolon and convert to double array
    indx_BW_obj = double(split(array_str_indx(n_obj), ";"));
    
    % Concatenate the new numeric indices to the growing array
    array_BWobj_fets = [array_BWobj_fets; indx_BW_obj];
end

% FINAL OF THE FUNCTION


end
