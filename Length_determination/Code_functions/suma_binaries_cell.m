function [BW_compendio_imatges] = suma_binaries_cell(cell_imatges_conjuntes)

% Joins the binary images contained in the cell

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


BW_compendio_imatges = logical(BW_compendio_imatges);

% imshow(BW_compendio)

% END FUNCTION

end