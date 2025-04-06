function [BW_compendio_imatges] = suma_normals_cell(cell_imatges_conjuntes)

% Ajunta les imatges semi-binàries (fons de 0, pero imatges de 255) que conté la cell.
%
% Probé de suma_binaries_cell.m

% INICI FUNCIÓ 

BW_compendio_imatges = 0;
for numeric_llargada = 1:length(cell_imatges_conjuntes)
%     figure   %<- si volem que es vegin totes les imatges
%     imshow(llistat_imatges_finalBL{numeric_llargada});
    if isempty(BW_compendio_imatges)
        BW_compendio_imatges = cell_imatges_conjuntes{numeric_llargada};
    else
        BW_compendio_imatges = BW_compendio_imatges + cell_imatges_conjuntes{numeric_llargada};
    end
end


% imshow(BW_compendio)

% FINAL FUNCIÓ


end