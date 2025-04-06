function [nom_im_carpeta_coincident] = compara_en_carpeta_nom_BW_coincident(BW_aillar, nom_BW_modif, carpeta_imatges_BW_totes)
% Funció lectura carpetes per nom. En aquest cas, es realitza la comparació
% d'objectes binaris per a veure el nom de l'arxiu coincident.
%
%
% Objectiu: lectura a Conjunt_BW_totes, carpeta que guarda els objectes
% binaris. Llaors, s'obté el nom de la imatge coincident, per a poder, a
% posteriori, obtenir el BB en color de la imatge i fer-li cambiar de
% color.
%
%
% Variables
% input
% BW_aillar : imatge binària de la qual es vol comparar
% nom_BW_modif : nom original de la imatge binària. Aquest serà el filtre
%                per a comaprar aquelles imatges que coincideixin amb el nom.
% carpeta_imatges_BW_totes : carpeta amb les imatges a comparar
% 
% output
% nom_im_carpeta_coincident : nom de l'arxiu coincident. 
%                             nota: Si no hi ha objecte, es retorna un
%                             objecte vuit [].
%
% % Exemples variables
% % Nom original de la imatge a la qual es vol comparar.
% nom_BW_modif = "P1011629";
% % Carpeta lectura imatges binàries sols amb un objecte.
% carpeta_imatges_BW_totes = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_6\Results_out\20220318_1335_Input_images_Amanda_poques\Processades\Conjunt_BW_totes";
% % Imatge a comparar
% BW_aillar = imread("C:\Users\Josep TOSHIBA\Desktop\Length determination v2_6\Results_out\20220318_1335_Input_images_Amanda_poques\Processades\Conjunt_BW_totes\P1011629_skel_00003_02.JPG");
% BW_aillar = imbinarize(BW_aillar);
%
% See also
% lectura_imatges_carpeta_estr
% compara_BW_objecte_coincident


% INICI FUNCIÓ

% cont-control de nombre d'imatges coincidents.
cont_contrl_im_coincid = 0;

% Variables de guardar
nom_im_carpeta_coincident = [];

[theFiles_carpetaBB] = lectura_imatges_carpeta_estr(carpeta_imatges_BW_totes);

% ÑÑÑ S'HA DE FILTRAR PEL NOM DE LA IMATGE, I LLAVORS COMPARAR LES IMATGES IGUALS!!
for cada_imatge = 1:length(theFiles_carpetaBB)
    
    % Obtenim nom de l'arxiu
    nom_carpeta_files = theFiles_carpetaBB(cada_imatge).name;
    nom_carpeta_files_t = strsplit(nom_carpeta_files, "_skel");
    nom_carpeta_files_original = string(nom_carpeta_files_t(1));
    
    
    % Comparem si és com la nostra imatge
    if strcmp(nom_BW_modif, nom_carpeta_files_original)
        % Si el nom és com la original, procedim a comparar la imatge amb
        % la nostra.
        
        % Obtenim la imatge binària
        imatge_a_llegir = imread(strcat(theFiles_carpetaBB(cada_imatge).folder, "\", theFiles_carpetaBB(cada_imatge).name));
        
        % Binaritzem ( o no)
        if length(unique(imatge_a_llegir(:))) > 2
            imatge_a_llegir = imbinarize(imatge_a_llegir);
        else
            imatge_a_llegir = imatge_a_llegir;
        end


        % _Comparació entre imatges binàries_
        [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = compara_BW_objecte_coincident(imatge_a_llegir, BW_aillar);

        % Variables
        % BW_conjuntes_comparar  : imatge a comparar
        % BW_aillar_skel         : imatge amb un únic objecte a comparar amb l'altre.
        

        % Ara mirem si és empty. Si ho és, vol dir que no hi ha imatge,
        % però si no ho és significa que coincideix una imatge.
        if ~isempty(llist_BW_identif)
            % Hi ha imatge
            
            % Guardem el nom de la imatge coincident.
            nom_im_carpeta_coincident = nom_carpeta_files;
            
            % Guardem el control
            cont_contrl_im_coincid = cont_contrl_im_coincid+1;
            
        end
        
    end
    
end


% Control
if isempty(cont_contrl_im_coincid)
    % No hi ha hagut imatge coincident
    f = msgbox("No compared object", 'Error','error');
    
else
    if cont_contrl_im_coincid > 1
        % Si hi ha hagut imatge, però més d'una:
        f = msgbox("More than a compared object", 'Error','error');
        error("f'compara_en_carpeta_nom_BW_coincident': More than a compared object")
    end
end
   

% FINAL FUNCIÓ


end