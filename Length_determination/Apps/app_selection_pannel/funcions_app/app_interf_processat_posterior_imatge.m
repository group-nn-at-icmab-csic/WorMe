function app_interf_processat_posterior_imatge(app)

% Tot el component intern de Thick, posterior a la selecció de les dades en
% el main.
%
% Una vegada s'ha descrit en S_text_scan els components de la GUI, es
% precedeix a la nova selecció i definició dels components de la imatge
% binaria nova en el GUI, si n'hi ha.


% INICI FUNCIO


% ___ Processat següent objecte/imatge___
% Restem objectes processats. Si hi ha objectes operem la
% imatge, sino esdevé la imatge posterior.

% #1: Mirem si hi ha més objectes binàris, per a seleccionar la
% mateixa imatge, la imatge següent, o sigui la final. 
% #2: Processament de la imatge, i descripció de les dades.
% #3: Graficació de la imatge amb les dades obtingudes.

% ÇÇÇ OPTIMITZABLE, si es guarda un contador de que és l'últim
% objecte binari, no cal fer tot el procés de nou.
% Ex seria de 'bwconncomp' si és igual a 1.

dir_output = app.appv_dir_output;

% __Lectura de les dades__
% ÇÇÇ Aquest comandament ha d'anar a cada vegada que es fa lectura d'una imatge, per tal d'aplicar els index de l'objecte binari, primordialment.

% _Llegim l'arxiu_

% Upgrade_taula: 
% Llegim taula. 
% Si és la primera vegada, es llegeix, sinó no.
 % _Definició variables inicials_
[S_textscan_table] = app_interf_lectura_Stable(app);

%_Filtrem per nom de la imatge_
nom_img_origin = app.img_original_nomLabel.Text;
S_textscan_table_filtred = S_textscan_table(S_textscan_table.NomWorm == nom_img_origin, :);
% Una vegada guardada la dada de l'objecte que hi ha en la GUI,
% en el main, es descriu les dades filtrades del mateix objecte, i dels anteriors.

% ___Definició valors filtratge basats en selecció____
app_interf_definicio_mean_width(app, S_textscan_table);


% Upgrade_taula: UPGRADE: No-lectura de la taula, sino obtenció a partir de la
% variable semi-global de la app.
% S'intervenen dos funcions: app_interf_descriure_dades , app_interf_guardar_main_dades,i app_interf_llegir_main_dades.
% Aquestes el que fan és descriure les dades de la GUI en una
% cell (app_interf_descriure_dades), es guarda la cell en el
% main dades (app_interf_guardar_main_dades), i es torna a
% llegir tot l'arxiu de text (app_interf_llegir_main_dades), de manera que
% s'obté la taula completa.
% Hem de fer: llegir la cell, escriure la cell al arxiu principal, però llegir la
% taula sols al inici, si està vuida, i afegir els valors de la
% cell a la taula ja guardada.



%_Obtenció de la imatge binària prèviament modificada_
% Modifiquem la imatge original i la mostrem:
imatge_original = imread(strcat(app.dir_imgs_orig, "\", app.img_original_nomLabel.Text));
BW_final = imread(strcat(dir_output, "\imgBWtemp.png"));


 % __Esborrem objectes ja executats__

 % _Describim la dada dels index de l'objecte binari_
[indx_BW_filtred] = appf_split_strindex(S_textscan_table_filtred.Indx_BW); % Elapsed time is 0.015221 seconds.

% Apliquem l'esborrat dels índex
BW_final_noproc = BW_final;
% Borrem objectes ja determinats:

BW_final_noproc(indx_BW_filtred) = false;



% ___Aplicació Filtres___
% Obtenció dels index
[indx_filtre_tot, indx_filtre_pos] = app_interf_filtres(app, BW_final_noproc);

% _Aplicació index filtres negatius_
if ~isempty(indx_filtre_tot)
    BW_final_noproc(indx_filtre_tot) = false;
end    

% _Aplicació index filtres positius_
if ~isempty(indx_filtre_pos)
    BW_final_noproc(indx_filtre_pos) = true;
end    



% __Obtenim el nombre d'objectes binaris__
% Objectes de la imatge binària
number_BW = getfield(bwconncomp(BW_final_noproc, 8), 'NumObjects');

% _Obtenim nombre objectes de draws_
% Obtenim les dades dels 'draws' no processats, i les sumem a  
[~, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app); % Elapsed time is 0.001039 seconds.

number_BW = number_BW + height(taula_dibuix_filted_nonproc);



% _Seleccio objectes binaris_
% Es determina l'objecte de la imatge, o es precedeix la
% imatge, o bé si és la final acaba.
%[proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original] = app_interf_select_obj_bin_forward(app, number_BW, BW_final_noproc, dir_output, imatge_original);

% _Modif_draw_ %
[proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original, isdrawline] = app_interf_select_obj_bin_forward_new(app, number_BW, BW_final_noproc, dir_output, imatge_original);


% A partir d'aqui tenim la imatge binària sense els objectes anteriors.
% Ara es processarà aquesta esqueletonitzant-la, graficant-la, i guardant les dades
%  d'aquesta temporalment per a la proxima decisió (thick/cross).



% Si no hi ha objectes en la següent imatge:
if proc_BW && num==0
    % Mostrar la imatge però sols es poden passar els botóns. Que no hi hagi thick o cross.

    app.RightButton.Visible = 'on';
    [nonobj_imageArray_ambtext] = image_without_objects(imatge_original);
    app.Image.ImageSource = nonobj_imageArray_ambtext;

    % No es guarda ni es mostra el contingut del següent objecte, això passarà una vegada la següent imatge.
    % Sols es mostra la imatge. La càrrega del contingut es
    % farà en la imatge posterior, si hi ha objectes, serà
    % llavors quan, si hi ha objectes, es mostrin, i es pugui fer thick/cross pe ra guardar aquests.

% Si no és la imatge final:
elseif proc_BW
    % Variables:
    % BW_final_object : imatge binaria amb l'objecte a analitzar
    % S_textscan_table_filtred : taula amb dades filtrades
    % indx_BW_filtred : index dels objectes anteriorment processats
    % BW_final_noproc : imatge amb objectes no processats,
    % objecte actual inclos
    % num  : numero d'objectes totals
    % RGB_to_color_new : imatge RGB com la original que serà
    % modificada continuament.


    % ___Processat i Descripció de les dades de l'objecte actual per la seva precedència___
    % Es processa l'objecte, i es descriuren les dades en la GUI i txt d'aquesta.
    [BW_skel, BW_skel_crop, imageArray_crop, proporcio_img, indx_BWskel, indx_BWobj] = app_interf_processar_descriure_img_new(app, dir_output, imatge_original, BW_final_object, BW_final, isdrawline);

    % ____Processament de graficació d'imatge____
    % Ara ja tenim la BW i skel, tant reduït com en gran, així com les dades. Anem a graficar-ho.
    RGB_to_color_new = imatge_original;

    % Graficació
    app_interf_graficar_img(app, RGB_to_color_new, imageArray_crop, BW_skel_crop, num, proporcio_img, BW_final, BW_skel, indx_BWskel, new_img, S_textscan_table_filtred, BW_final_noproc, indx_BWobj, isdrawline);
    % Temps processament: Amb app: 0.0173; sense app: 0.0183


    % _Activació/Desactivació Botóns_ 
    if ~str2num(app.finalitzat_contLabel)
        app_interf_enable_thickcrosret_buttons(app, 'on')
    end
end



% FINAL FUNCIO