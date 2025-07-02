function [array_valors_noms_imatge, valor_nom_arxiu] = lectura_noms_imatges_carpeta(carpeta_output_filter)

% We obtain the array of names that we want to obtain the image with the BBs in color.
% In our case, it will be all the Filtered images.

array_valors_noms_imatge = [];
File_lectura_imatges_filtre = lectura_imatges_carpeta_estr(carpeta_output_filter);
for cada_imatge_filtre = 1:length(File_lectura_imatges_filtre)
    nom_imatge_filtre = File_lectura_imatges_filtre(cada_imatge_filtre).name;
    [valor_nom_imatge, valor_nom_arxiu] = separar_puntfile(nom_imatge_filtre);
    array_valors_noms_imatge = [array_valors_noms_imatge, string(valor_nom_imatge)];
end

end