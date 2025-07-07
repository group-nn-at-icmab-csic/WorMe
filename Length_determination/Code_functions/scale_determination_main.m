function [escala_imatge] = scale_determination_main(userSavedDocuments, theFiles, carpeta_output)

% Scale determination

% START FUNCTION

    
    % Obtain the image
    baseFileName = theFiles(1).name; % If gives error if there is no images
    %disp(baseFileName)
    fullFileName = fullfile(theFiles(1).folder, baseFileName);
    imageArray_escala = imread_ifgrey(fullFileName); % Imatge inicial
    
    
    % __Obtain of the scale__
    
    % _Obtaining (or not) predefined scale value_
    % Obtained from the text file "predefined_escale.txt" described in the folder
    % (hidden) Internal_code_files. Reading is done
    text_escala_internal_code_files = strcat(userSavedDocuments, "\", "Results_out\Internal_code_files\predefined_escale.txt");
    
    if isfile(text_escala_internal_code_files)
        % If a text file exists that contains the scale
        escala_llegida = llegir_text_delimitadors(text_escala_internal_code_files, ";");
        escaL = escala_llegida{1,2}; % es defineix la escala predefinida
    else
        % If there is no defined scale, it is saved without a value.
        escaL = '';
    end
    
    % __Scale obtention__
    escala_imatge = escala_determinar(imageArray_escala, escaL);
    % escala_imatge = 1.14  %pixels/unit
    
    % _Write predefined scale_
    array_write_imatge = ["Escala", string(escala_imatge)];
    write_text_array(text_escala_internal_code_files, array_write_imatge, ";")
    
    save(strcat(carpeta_output, "\escala_imatge"), "escala_imatge")
    
    % % Scale obtention
    % getfield( load(strcat(carpeta_output, "\escala_imatge")), "escala_imatge")


% FINAL OF THE FUNCTION

end