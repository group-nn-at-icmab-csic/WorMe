function juntar_BB_imatge_nou(carpeta_input, carpeta_BB_BW_color, carpeta_BB_merge_original, array_noms_im)
% Juntar els BB a imatge original
% Basat amb la f'suma_semiBW_norm_millorat'
%
% Veiem les carpetes de les imatge BB BW color, i les originals. 
% De l'array de noms originals que tenim, mirem si ccoincideixen les
% imatges. Obtenim er una banda la imatge original i per altra totes les BB
% BW en color que coincideixen amb el nom, i juntem les unes amb les
% altres.
%
% carpetes:
% carpeta_input             : carpeta imatges originals
% carpeta_BB_BW_color       : carpeta BB BW color
% carpeta_BB_merge_original : carpeta imatges orginals i BB en color combinades.

% Variables
% carpeta_input             : carpeta entrada imatges originals
%                               ex:  'C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\_Extern\Imatges exemple\Input_images_Amanda_poques'
% carpeta_BB_BW_color       : carpeta entrada imatges Bounding Box en color.
%                               ex  ' "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\Results_out\20220318_0958_Input_images_Amanda_poques\Processades\Conjunt_BB_BW_color"'
%
% carpeta_BB_merge_original : carpeta on es guarden les imatges processades
%                               ex: "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\Results_out\20220318_0958_Input_images_Amanda_poques\Processades\Conjunt_BB_aplicat"
%
% array_noms_im             : array amb els noms de les imatges que es volen obtenir.
%                               ex:   "P1011624"    "P1011625"    "P1011629"    "P1011630"    "P1011655"
%
% Variables internes
% im_BB_rel_original : imatge original pertanyent al nom de la imatge BB
% im_BB_BW_color     : imatge BB color seleccionada pertanyent al nom

% INICI FUNCIÓ 

[theFiles_imresult_original] = lectura_imatges_carpeta_estr(carpeta_input); % Lectura imatges
llargada_theFiles_original = length(theFiles_imresult_original);

[theFiles_imresult_BB_BW_color] = lectura_imatges_carpeta_estr(carpeta_BB_BW_color); % Lectura imatges
llargada_theFiles_BB_BW_color = length(theFiles_imresult_BB_BW_color);


% Per imatge original de les BB BW en color
for cada_nom_array = array_noms_im
    
    % Mostrem percentatge procés
    [~ , posicio_nomarray] = ismember(cada_nom_array, array_noms_im', 'rows');
    disp(strcat("Processing: ", string(posicio_nomarray), "/", string(length(array_noms_im)), " images"))
    
    % Obtenim imatge original
    for cada_n_original = 1:llargada_theFiles_original
        nom_ex = theFiles_imresult_original(cada_n_original).name;
        strsplit(nom_ex, "_skel")
        
        [nom_im_orig_unic, file_im_original] = separar_puntfile(nom_ex);
        if strcmp(cada_nom_array, nom_im_orig_unic)
            baseFileName_origin = theFiles_imresult_original(cada_n_original).name;
            split_nom = split(baseFileName_origin, "_skel");
            if length(split_nom) == 1
                baseFileName_origin = split_nom;
            else
                baseFileName_origin = split_nom(1);
            end
        
            fullFileName_origin = fullfile(theFiles_imresult_original(cada_n_original).folder, baseFileName_origin);

            % Obtenim la imatge original
            im_BB_rel_original = imread(fullFileName_origin); % Imatge inicial
            
            % Obtenim el nom de la imatge original
            nom_im_orig_unic_bo = nom_im_orig_unic;
            file_im_original_bo = file_im_original;
        end
    end
    
    % _Agreguem BB_
    % Per a cada imatge BB BW color que coincideixi amb el nom, li agreguem
    % el BB BW
    
    % Fem copia de la imatge original. v'im_BB_rel_original_BBcol' serà la
    % que anirà guardant els BB.
    im_BB_rel_original_BBcol = im_BB_rel_original; 
    
    for cada_n_BB = 1:llargada_theFiles_BB_BW_color
        % Obtenim nom original
        nom_ex_temp = theFiles_imresult_BB_BW_color(cada_n_BB).name;
        split_nom = split(nom_ex_temp, "_skel");
        if length(split_nom) == 1
            nom_ex = split_nom;
        else
            nom_ex = split_nom(1);
        end

        % Si coincideix el nom del BB que estem veient (nom_orign_imBB) amb el de la
        % imatge BB BW color de lectura (nom_orign_imBB), és la imatge que
        % ens interessa.
        if strcmp(nom_orign_imBB, cada_nom_array)
            baseFileName_BB = theFiles_imresult_BB_BW_color(cada_n_BB).name;
            fullFileName_BB = fullfile(theFiles_imresult_BB_BW_color(cada_n_BB).folder, baseFileName_BB);

            % Obtenim la imatge BW BB en color
            im_BB_BW_color = imread(fullFileName_BB); % Imatge inicial
            
            % _Sumar BB col a original_
            % Procedim a sumar aquesta a la original
            im_BB_rel_original_BBcol = suma_semiBW_norm_millorat(im_BB_rel_original_BBcol, im_BB_BW_color);
            

            
        end
        
        % GUARDEM LA IMATGE
        % Definim el nom
        nom_BB_merge_original = strcat(nom_im_orig_unic_bo, file_im_original_bo);         
        write_josep(im_BB_rel_original_BBcol, carpeta_BB_merge_original, 1, nom_BB_merge_original);
        %imshow(im_BB_rel_original_BBcol)


    end

end

% FINAL FUNCIÓ

end