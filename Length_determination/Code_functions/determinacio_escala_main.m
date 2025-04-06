function [escala_imatge] = determinacio_escala_main(userSavedDocuments, theFiles, carpeta_output)

% Determinació de l'escala

% INICI FUNCIÓ

    
    % Obtencio 1a imatge
    baseFileName = theFiles(1).name; % ÇÇÇÇ SI NO HI HA IMATGES PETA
    %disp(baseFileName)
    fullFileName = fullfile(theFiles(1).folder, baseFileName);
    imageArray_escala = imread(fullFileName); % Imatge inicial
    
    
    % __Obtenció Escala__
    
    % _Obtenció (o no) valor d'escala predefinida_
    % S'obté del arxiu de text "predefined_escale.txt" descrit en la carpeta
    % (oculta) Internal_code_files. Es fa lectura
    text_escala_internal_code_files = strcat(userSavedDocuments, "\", "Results_out\Internal_code_files\predefined_escale.txt");
    
    if isfile(text_escala_internal_code_files)
        % Si existeix un arxiu de text que contingui l'escala
        escala_llegida = llegir_text_delimitadors(text_escala_internal_code_files, ";");
        escaL = escala_llegida{1,2}; % es defineix la escala predefinida
    else
        % Si no existeix una escala definida, es guarda sense valor.
        escaL = '';
    end
    
    % __Obtenció d'escala__
    escala_imatge = escala_determinar(imageArray_escala, escaL);
    % escala_imatge = 1.14  %pixels/unit
    % çç Determinació de 
    % s'empra: app'app_escala_linia(imageArray)'
    
    % _Write escala predefinida_
    array_write_imatge = ["Escala", string(escala_imatge)];
    write_text_josep(text_escala_internal_code_files, array_write_imatge, ";")
    
    save(strcat(carpeta_output, "\escala_imatge"), "escala_imatge")
    
    % % Obtenció escala
    % getfield( load(strcat(carpeta_output, "\escala_imatge")), "escala_imatge")


% FINAL FUNCIÓ

end