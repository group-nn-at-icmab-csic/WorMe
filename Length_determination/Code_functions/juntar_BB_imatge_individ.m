function [im_BB_rel_original_BBcol] = juntar_BB_imatge_individ(imatge_input_original,  nom_imatge_original, carpeta_BB_BW_color)

% Juntar els BB a imatge original, aplicat sols a una imatge.
% Basat amb la f'suma_semiBW_norm_millorat'
%
% Veiem les imatges de la carpeat BB BW color. 
% Del nom de la imatge, sumem a la imatge aquelles BB que contenen el mateix nom d'origen.

% Variables
% imatge_input_original        : imatge a afegir els BB
% nom_imatge_original         : nom de la imatge
% carpeta_BB_BW_color         : carpeta amb les imatges BB en color
%
% Variables internes
% im_BB_rel_original : imatge original pertanyent al nom de la imatge BB
% im_BB_BW_color     : imatge BB color seleccionada pertanyent al nom
% 
% See also
% suma_semiBW_norm_millorat
% juntar_BB_imatge_nou3


% INICI FUNCIÓ 


[theFiles_imresult_BB_BW_color] = lectura_imatges_carpeta_estr(carpeta_BB_BW_color); % Lectura imatges
llargada_theFiles_BB_BW_color = length(theFiles_imresult_BB_BW_color);

% cada loop era: cada_nom_array

% Si suposem que donem la imatge original


% _Agreguem BB_
% Per a cada imatge BB BW color que coincideixi amb el nom, li agreguem
% el BB BW

% Fem copia de la imatge original. v'im_BB_rel_original_BBcol' serà la
% que anirà guardant els BB.
im_BB_rel_original_BBcol = imatge_input_original;

for cada_n_BB = 1:llargada_theFiles_BB_BW_color
    % Obtenim nom original
    nom_ex = theFiles_imresult_BB_BW_color(cada_n_BB).name;
    split_nom = split(nom_ex, "_skel");
    nom_orign_imBB = split_nom(1);

    % Si coincideix el nom del BB que estem veient (nom_orign_imBB) amb el de la
    % imatge BB BW color de lectura (nom_orign_imBB), és la imatge que
    % ens interessa.

    % Normalitzem el nom de les imatges d'entrada, per a agafar i
    % copiar totes aquelles imatges de BB color que coincideixen amb
    % aquestes.
    split_nom = split(nom_imatge_original, "_skel");
    if length(split_nom) == 1
        cada_nom_array_splited = split_nom;
    else
        cada_nom_array_splited = split_nom(1);
    end

    if strcmp(nom_orign_imBB, cada_nom_array_splited)
        baseFileName_BB = theFiles_imresult_BB_BW_color(cada_n_BB).name;
        fullFileName_BB = fullfile(theFiles_imresult_BB_BW_color(cada_n_BB).folder, baseFileName_BB);

        % Obtenim la imatge BW BB en color
        im_BB_BW_color = imread(fullFileName_BB); % Imatge inicial

        % _Sumar BB col a original_
        % Procedim a sumar aquesta a la original
        im_BB_rel_original_BBcol = suma_semiBW_norm_millorat(im_BB_rel_original_BBcol, im_BB_BW_color);


    end



end


% FINAL FUNCIÓ

end