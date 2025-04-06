function [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identifica_pump_anterior_nou(im_compare_ini, im_pharx_ant, im_croped_graf, test_ext_si_no, test_directori_sortida)

% Donada una imatge binaria, es mira quins objectes encaixen a una imatge binaria superposada a aquesta.
%
% Diferencies respecte la versió 1:
% Principalment, s'ha fet una versió 2 perque l'execució del programa era
% molt lenta, principalment a causa de la execució de la funció bwsel per a
% cada pixel.
% variable 'im_compare_ini' és amb l'objecte
% valor 1, i no valor 0 com es feia, es a dir, la imatge binaritzada és
% inversa.
% 
%
% Variables
% Input
% -----
% im_compare_ini - del frame actual, la imatge binaritzada. L'objecte és en valor 1.
% im_pharx_ant - objecte binari, singular, a comparar amb el frame que, teoricament, va posteriorment (im_compare_ini). L'objecte també té valor 1.
% im_croped_graf - del frame actual, la imatge amb color.
%
% Funcionament funció (explicació):
% --
% S'obté x_find_pharx i y_find_pharx, que són els punts en que coincideixen
% la imatge binaria del objecte singular (im_pharx_ant), amb la imatge
% binària del frame actual (im_compare_ini). D'aquesta manera, es tenen
% quins punts són coincidents.
% --
%
%  [x_find_pharx, y_find_pharx]- punts x i y de la imatge binaria anterior.
%                               Aquests serveixen per a veure quina imatge
%                               coincideix a la posterior, i si aquesta té
%                               més d'un objecte binari.
%
% BW_pharx_post - Per a cada punt de la imatge binaria anterior, es fa un
%                   bwselect on es selecciona l'objecte binari del punt. A
%                   partir d'aqui es veu si aquest és el mateix al llarg
%                   dels diferents punts de la imatge binaria primera, o
%                   si, en els diferents punts apareixen diferents objectes
%                   binaris (BW_pharynx_post)
%
% BW_pharx_post_noc - Imatge binaria amb l'objecte detectat en el punt
%                    coincident entre la imatge binarai del frame 1 (sols pharynx), 
%                       amb la imatge binaria sense filtrar del frame 2.
%
% test_ext_si_no - (1 = si, 0 = no) (opcional) si es fa extensió de test gràfic. Si es així, s'ha
%               d'especificar la carpeta.
%
% test_directori_sortida - directori principal de l'arxiu. 
%
% Seguiment varis objectes iguals
% BW_bwselect_igual - es guarda la imatge binaria coincident, així com les imatges dels diferents objectes coincidents.
% BW_bwselect_igual_punts - igual però amb punts
%
%
% % PROBATURA MATLAB Live
% % Exemples variables proba emprades en el programa
% 
% % _Imatges frame inicial_
% im_croped_graf = I1;
% im_compare_ini = ~I1greyAdj_nouBW;
% 
% % combinació en imoverlay
% im_combi_overlay_primer = imoverlay(im_croped_graf, im_compare_ini, "y");
% imshow(im_combi_overlay_primer)
% 
% % _Imatges frame anterior_
% im_pharx_ant = BW_pharx_anterior;
% im_combi_overlay_posterior_preanalisis = imoverlay(im_combi_overlay_primer, im_pharx_ant, "r");
% imshow(im_combi_overlay_posterior_preanalisis)
% 
% imshowpair(im_combi_overlay_primer, im_combi_overlay_posterior_preanalisis, "montage")



% INICI FUNCIO

% Si no es defineix si es fa o no l'extensió gràfica del test, s'entén que no es fa.
if test_ext_si_no == 1 % ~exist('test_ext_si_no','var')
    test_ext_si_no = true;
else
    test_ext_si_no = false;
end



im_compare_ini_inv = ~im_compare_ini;

% A comparar:
% imshow(im_pharx_ant)
% imshow(im_compare_ini_inv)

% Graficacio coincidencies
suma_coincid = im_pharx_ant + ~im_compare_ini_inv;
% imshow(suma_coincid, [])
coincidencia_BW = suma_coincid==2;
% imshow(coincidencia_BW)


% Punts de la pharynx pump BW inicial
[x_find_pharx, y_find_pharx] = find(coincidencia_BW);
% El mateix valor però en coordenades:
try
    coordena_pharx = sub2ind(size(im_pharx_ant), y_find_pharx, x_find_pharx);
catch ME
    %disp("Catchete bueno")
    coordena_pharx = sub2ind(size(im_pharx_ant), x_find_pharx, y_find_pharx);
end



% __Selecció imatge binària__
% Emprem simplement bwselect amb les coordenades on coincideixen, i dividim
% els objectes binaris amb f'separacio_imatges_binaries', funció que es
% basa simplement amb la funció base 'bwlabel'.

% bwselect amb no sols un punt sino molts
[BW_pharx_post_noc, punts_noc] = bwselect(~im_compare_ini_inv, y_find_pharx, x_find_pharx);

% Ara hem separat la imatge i hi ha sol les coincidents. Anem a
% aplicar la funció 'separacio_imatges_binaries' per a obtenir
% una llista dels objectes binaris.
llist_BW_identif = separacio_imatges_binaries(BW_pharx_post_noc);

% Obtenim llista dels punts
BW_bwselect_igual_punts = cell(1, length(llist_BW_identif));
for cada_obj_BW = 1:length(llist_BW_identif)
    BW_bwselect_igual_punts{cada_obj_BW} = find(llist_BW_identif{cada_obj_BW});
end

% __ ↓↓ Opcional ↓↓ __ %

if test_ext_si_no
    % Agafem els objectes que detecten cada punt.
    
    
    % Creem carpetes:
    if ~isfolder(strcat(test_directori_sortida, "\output_images\tests")) 
    mkdir(strcat(test_directori_sortida, "\output_images\tests")); end 
    
    if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior")) 
    mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior")); 
    
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1")); end 

        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2")); end 

        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3")); end 
    
    end 

    
    for punt_BW_phar = 1:length(x_find_pharx)
            
    
        % Grafiquem
        zeros_graficar = zeros(size(im_compare_ini_inv));
        zeros_graficar(x_find_pharx(punt_BW_phar), y_find_pharx(punt_BW_phar)) = 1;
        imshow_write = imshowpair(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            imoverlay(im_compare_ini_inv, zeros_graficar, "r"), "montage");
    
        imwrite(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1\", retorna_zeros(punt_BW_phar), "_pixels_imatge_1.jpg"))
    
        imwrite(imoverlay(im_compare_ini_inv, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2\", retorna_zeros(punt_BW_phar), "_pixels_imatge_1.jpg"))
    
        imwrite(imshow_write.CData, ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3\", retorna_zeros(punt_BW_phar), "_montage1.jpg"))
    
    
        
    
        
        % FER UN IF DE SI COINCIDEIXEN ELS PUNTS, SI COINCIDEIXEN FER BWSELECT
        % I COMPARAR EL RESULTAT ENTRE UNA IMATGE BINARIA I ALTRE
    
        % _ Si el valor de cada punt en ambdós imatges és igual , es a dir,
        % si comparteixen imatge binaria ambdos frames en el mateix punt, llavors operem.
        % Aquest filtre el fem perque pot ser, segurament, en els punts de la imatge binaria 
        % del primer frame no coincideixin amb el segon, de manear que al fer bwselect 
        % es dongui una imatge de zeros. Al coincidir, definim quins objectes son aquests i ssi 
        % son diferents entre sí._
            
    
        % Creem carpetes
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4")); end 
    
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_5")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_5")); end 
    
        % Grafiquem
        zeros_graficar = zeros(size(im_pharx_ant));
        punt_x_noc = x_find_pharx(punt_BW_phar);
        punt_y_noc = y_find_pharx(punt_BW_phar);
        zeros_graficar(punt_x_noc, punt_y_noc) = 1;
        imshow_write_2 = imshowpair(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
        imoverlay(im_compare_ini_inv, zeros_graficar, "r"), "montage");
        
        % Write
        imwrite(imshow_write_2.CData, ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4\", retorna_zeros(punt_BW_phar), "_montage2.jpg"))
        imwrite(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4\", retorna_zeros(punt_BW_phar), "_pixels_imatge", ".jpg"))
      
      
    end

end

% 
% % Grafiquem per veure si hi ha o no més d'un objecte:
% if length(BW_bwselect_igual) > 1
% %     ~isempty(cell_diferents_objectes_BW_punts)
% 
%     % Fem matriu de zeros i hi afegim els valors diferencials dels
%     % diferents objectes que trobem     
%     zeros_matriu_inicial = zeros(size(im_compare_ini_inv));
% 
%     for cada_objecte_detectat = 1:length(BW_bwselect_igual)
%         % Ara tenim els index dels objectes detectats. Sols hem de graficar
%         % aquests.
%         cada_objecte_coord = BW_bwselect_igual_punts{cada_objecte_detectat};
% 
%         % Agafem un valor de l'index de l'objecte:
%         coord_obj = cada_objecte_coord(1);
%         % Convertim a coordeandes d'aquest
%         [x_r, y_c] = ind2sub(size(im_compare_ini_inv), coord_obj);
%         
%         %Seleccionem l'objecte
%         BW_objecte_dif= bwselect(im_compare_ini_inv, x_r, y_c);
%         
%         %Distingim entre objectes pel valor de la matriu
%         BW_objecte_dif = BW_objecte_dif .* cada_objecte_detectat;
%         
%         % Ho sumem a la matriu de zeros final
%         zeros_matriu_inicial = zeros_matriu_inicial + BW_objecte_dif;
%         
%     end
%     
%     % Finalment mostrem totes les imatges diferenciades per color
%     % Exenmple: zeros_matriu_inicial = [1 2 0; 0 1 0; 3 0 0];
%     imshow(zeros_matriu_inicial, [])
% 
%     
%     % multipliquem a obtenir un valor de 255 en tots els valors
%     
%     [num_r, num_c, ~]= size(zeros_matriu_inicial);
%     zeros_matriu_final = zeros(num_r, num_c, 3);
%     
%     for cada_color = unique(zeros_matriu_inicial)
%         if cada_color ~= 0
%             zeros_matriu_temporal = zeros_matriu_inicial == cada_color;
%             zeros_matriu_temporal = cat(3, ...
%                 zeros_matriu_temporal .* rand(1), ...
%                 zeros_matriu_temporal .* rand(1) ,  ...
%                 zeros_matriu_temporal.* rand(1));
%             zeros_matriu_final = zeros_matriu_final + zeros_matriu_temporal;
%         end
%     end
%     
%     valor_color = 255/length(BW_bwselect_igual_punts);
%     zeros_matriu_final = zeros_matriu_final .* valor_color;
%     
%     imshow(zeros_matriu_final)
% 
%     im_croped_graf_temp = im_croped_graf;
%     im_croped_graf_temp(zeros_matriu_final ~= 0) = zeros_matriu_final;
%     
%     imatge_montatge_sortida = im_croped_graf_temp;
%     imshow(imatge_montatge_sortida)


if isempty(punts_noc)
    %msgbox("ERROR: NO DETECTAT OBJECTE BINARI!", 'Error','error');
    imatge_montatge_sortida = false;
else
    imatge_montatge_sortida = BW_pharx_post_noc; % ççç modificat josep
    %imatge_montatge_sortida = imoverlay(im_croped_graf, BW_pharx_post_noc, "g");
%     imshow(imatge_montatge_sortida)
end    



% FINAL FUNCIÓ

end