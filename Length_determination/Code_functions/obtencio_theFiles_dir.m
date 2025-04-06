function [theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtencio_theFiles_dir(userSavedDocuments)

% Obté l'arxiu theFiles de les imatges, així com la ruta de la carpeta
% seleccionada, a partir de la descripció de la carpeta.
%
% Variables
%   input
%       userSavedDocuments - ruta actual de path.
%                       ex:  'C:\Users\jllobet\Desktop\Length determination v2_15'
%
%   output
%       theFiles - Estructura descripció imatges. arxiu dir() de les imatges
%
%       carpeta_input - ruta carpeta imatges
%                       ex: 'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls\C_48'
%
%       nom_carpeta_input - nom carpeta imatges
%                       ex: 'C_48'
%
%       porta_f - porta si és correcte el processament (true/false)
%
% See also
% obtencio_theFiles_img



% INICI FUNCIÓ



% ___OBTENCIÓ CARPETA IMATGES ORIGINALS___
% v'predef_folder_carpeta'  : carpeta predefinida d'inici de cerca.
% v'carpeta_input'          : directori de les imatges originals.
% v'nom_carpeta_input'      : nom del directori de les imatges originals
%
% _Obtenció (o no) valor de la carpeat predefinit
% S'obté de "Results_out\Internal_code_files\predefined_folder.txt"
predefined_folder_input = strcat(userSavedDocuments, "\Results_out\Internal_code_files", "\predefined_folder.txt");

if isfile(predefined_folder_input)
    % Si existeix un arxiu de text que contingui l'escala
    predef_folder_llegida = llegir_text_delimitadors(predefined_folder_input, ";");
    predef_folder_carpeta = predef_folder_llegida{2}; clear predef_folder_llegida  % es defineix la carpeat predefinida
else
    % Si no existeix una escala definida, es guarda sense valor.
    predef_folder_carpeta = '';
end

% __Obtenció carpeta__
% Carpeta entrada
carpeta_input = uigetdir(predef_folder_carpeta, "Select the folder with images");


if ~isequal(carpeta_input, 0)
    % _Write carpeta predefinida_
    % Obtenim la mateixa string de la carpeta, definit una carpeta anterior a la última definida.
    [split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Exemple: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
    array_write_folder = ["Folder", split_arxiu_sortida];
    write_text_josep(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder
    
    %_Obtenim nom del directori_
    % Nom de la carpeta d'entrada
    nom_carpeta_input_cru = split(carpeta_input, "\");
    nom_carpeta_input = nom_carpeta_input_cru{end}; clear nom_carpeta_input_cru

    
    myFolder = carpeta_input;
    
    % LECTURA IMATGES .jpg i .png de la carpeta:
    [theFiles] = lectura_imatges_carpeta_estr(myFolder);  %Elapsed time is 0.005087 seconds
    
    if isempty(theFiles)
        errordlg('There is no images on the selected folder');
        % error("No images on the selected folder")

        porta_f = false;
    else
        porta_f = true;
    end

else
    % Si hi ha fallos en el uigetdir

    theFiles = [];
    carpeta_input = false; 
    nom_carpeta_input = false; 
    porta_f = false;

end



end