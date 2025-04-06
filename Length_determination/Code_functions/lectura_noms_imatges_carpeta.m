function [array_valors_noms_imatge, valor_nom_arxiu] = lectura_noms_imatges_carpeta(carpeta_output_filter)
% Obtenim l'array de noms que volem obtenir la imatge amb els BB en color. 
% En el nostre cas, seràn totes les imatges Filtrades.
array_valors_noms_imatge = [];
File_lectura_imatges_filtre = lectura_imatges_carpeta_estr(carpeta_output_filter);
for cada_imatge_filtre = 1:length(File_lectura_imatges_filtre)
    nom_imatge_filtre = File_lectura_imatges_filtre(cada_imatge_filtre).name;
    [valor_nom_imatge, valor_nom_arxiu] = separar_puntfile(nom_imatge_filtre);
    array_valors_noms_imatge = [array_valors_noms_imatge, string(valor_nom_imatge)];
end

end