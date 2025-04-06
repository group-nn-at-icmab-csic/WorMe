function [BW_image] = create_BW_indx(indx_BW, size_BW)

% Crea una imatge binaria a paritr dels index i del tamany desitjat de la
% imatge



% INICI FUNCIÓ

try
    BW_image = false(size_BW);
    BW_image(indx_BW) = true;
    
catch e %e is an MException struct
    fprintf(1,'Error in create_BW_indx. The identifier was:\n%s',e.identifier);
end

% FINAL FUNCIÓ


end