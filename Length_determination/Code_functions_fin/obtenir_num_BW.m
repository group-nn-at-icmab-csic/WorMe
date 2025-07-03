function  num_objects_BW = obtenir_num_BW(imatge_entrada)

    % Function to obtain the number of binary objects in an image.
    %
    % See also
    % tipus_rgbgraybw_image


    % START FUNCTION
    
        % Read image typology ("rgb", "grey" o "binary")
        [tipus_imatge] = tipus_rgbgraybw_image(imatge_entrada);
        % If it is binary
        if strcmp(tipus_imatge, "binary")
            % Obtain number of elements
            [~, nombre_elements] = bwlabel(imatge_entrada);
        % If it is not binary
        else
            nombre_elements = "Not determined";
        end
        num_objects_BW = string(nombre_elements);

    % END FUNCTION
    
end