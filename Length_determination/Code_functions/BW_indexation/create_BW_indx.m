function [BW_image] = create_BW_indx(indx_BW, size_BW)


% Create a binary image from the indexes and the desired image size
%



% FUNCTION START

try
    BW_image = false(size_BW);
    BW_image(indx_BW) = true;
    
catch e %e is an MException struct
    fprintf(1,'Error in create_BW_indx. The identifier was:\n%s',e.identifier);
end

% FINAL FUNCTION


end