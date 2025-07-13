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

% _Data reading_:
for n_obj = 1:length(array_str_indx)

    % Read every one, and convert it in double:
    indx_BW_obj = double(split(array_str_indx(n_obj), ";"));% Elapsed time is 0.009027 seconds.
    
    % Prelocació
    array_BWobj_fets_z = zeros((length(array_BWobj_fets) + length(indx_BW_obj)), 1);
    array_BWobj_fets_z(1:end,:) = [array_BWobj_fets; indx_BW_obj];
    
    array_BWobj_fets = zeros(length(array_BWobj_fets_z),1);
    array_BWobj_fets(1:end,:) = array_BWobj_fets_z;

    
end

% FINAL OF THE FUNCTION


end
