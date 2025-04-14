function [theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtencio_theFiles_img(userSavedDocuments)

% Selecciona les imatges i obté el theFiles i les rutes de les carpetes.
% Com  obtencio_theFiles_dirperò es seleccionen les imatges.
% Variables
%   input
%       userSavedDocuments - ruta actual de path.
%                       ex:  'C:\Users\jllobet\Desktop\Length determination v2_15'
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
% 
% See also
% obtencio_theFiles_dir



% INICI FUNCIÓ

% Box explicatiu (fins a 7 vegades)
msgbox_sel_images(userSavedDocuments)


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


% Obtenció de les imatges
[filename, pathname] = uigetfile({['*.jpg;*.png;*.jpeg;*.tif;*.tiff;*.jfif;*.bmp']; '*.jpg'; '*.png'; '*.jpeg'; '*.tif'; '*.tiff'; '*.jfif'; '*.bmp'; '*.*'}, "Select the images", predef_folder_carpeta, 'MultiSelect','on');
% pathname :    'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls_poques\C_48\'
% filename :  {'Image_961.jpg'}    {'Image_970.jpg'}    {'Image_973.jpg'}
% Nota: si no hi ha selecció, i falla el box, tant pathname com filename és 0.


% Si hi ha selecció
if ~isequal(filename, 0)


    %_Obtenim nom del directori_
    % Nom de la carpeta d'entrada
    nom_carpeta_input_cru = split(pathname, "\");
    nom_carpeta_input = nom_carpeta_input_cru{end-1};

    if isequal(pathname(end), "\")
        carpeta_input = pathname(1:end-1);
    else
        error("Error in notation of the folder")
    end


    % __Obtenim directoris___
    % Guardem els directoris
    [split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Exemple: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
    array_write_folder = ["Folder", split_arxiu_sortida];
    write_text_josep(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder
    


    % __Obtenció del theFiles__
    arxius_directoris = strcat(pathname, filename);
    % Per cada patró
    for n_filep = 1:length(arxius_directoris)
            
%         disp('arxius_directoris')
%         arxius_directoris
%         class(arxius_directoris)
%         length(arxius_directoris)
%         numel(arxius_directoris)
        
        % Obtenció estructura del patró
        % Si nomès hi ha una imatge seleccionada
        if ischar(arxius_directoris)
            struct_fileP = dir(arxius_directoris);
        % Si hi ha varies imatges seleccionades
        else
            struct_fileP = dir(arxius_directoris{n_filep});
        end
    
        if n_filep == 1
            theFiles = struct_fileP;
        else
                if isempty(theFiles)
                    % Si és vuit l'arxiu theFiles (no s'ha obtingut imatges d'aquest tipus anteriors).
                    theFiles = struct_fileP;
                else
                    % S'uneixen les estructures
                    theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);
                end
            
        end
    
    end

    % Si theFiles és vuit:
    if isempty(theFiles)
        errordlg('There is no images on the selected folder');
        porta_f = false;
    else
        porta_f = true;
    end


else
    % Si hi ha fallos en el uigetfile

    theFiles = [];
    carpeta_input = false; 
    nom_carpeta_input = false; 
    porta_f = false;

end




% FINAL FUNCIÓ

end