function [BW_compendio_imatges] = suma_normals_cell(cell_imatges_conjuntes)

% Joins the semi-binary images (background of 0, but images of 255) contained in the cell.
%
% Comes from suma_binaries_cell.m

% START FUNCTION 

BW_compendio_imatges = 0;
for numeric_llargada = 1:length(cell_imatges_conjuntes)
%     figure   %<- if we want to see all the images
%     imshow(llistat_imatges_finalBL{numeric_llargada});
    if isempty(BW_compendio_imatges)
        BW_compendio_imatges = cell_imatges_conjuntes{numeric_llargada};
    else
        BW_compendio_imatges = BW_compendio_imatges + cell_imatges_conjuntes{numeric_llargada};
    end
end


% imshow(BW_compendio)

% END FUNCTION


end