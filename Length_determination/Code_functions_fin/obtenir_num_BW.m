function  num_objects_BW = obtenir_num_BW(imatge_entrada)

    % Function to obtain the number of binary objects in an image.
    %
    % See also
    % tipus_rgbgraybw_image


    % INICI FUNCIO
    
        % OBTENIR NOMBRE OBJECTES BINARIS
        % Funció d'obtenir el nombre d'objectes binaris en la imatge
        % Lectura tipologia imatge ("rgb", "grey" o "binary")
        [tipus_imatge] = tipus_rgbgraybw_image(imatge_entrada);
        % Mirem si es binaria:
        % Si es binària
        if strcmp(tipus_imatge, "binary")
            % Obtenim numero d'elements
            [~, nombre_elements] = bwlabel(imatge_entrada);
        % Si no es binaria
        else
            nombre_elements = "Not determined";
        end
        num_objects_BW = string(nombre_elements);


    % FINAL FUNCIÓ
    
end