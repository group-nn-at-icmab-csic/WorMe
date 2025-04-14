function export_IA_data(S_textscan_table, myFolder, dir_main_save_folder, array_portes)

% Exporta les dades anotades en S_textscan en una carpeta.
% 
% El resultat és una carpeta comprimida amb el nom indicat (ex:
% "C_48_Josla.zip"), que tindrà dins la carpeta amb les dades de IA (ex:
% "\IA_data_C_48_josla").
% Nota : Si l'arxiu .zip ja existeix, s'adverteix, i es sobre-escriu.
% 
%
% Variables
%   myFolder - Ruta imatges originals.
%               ex: 'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls\C_24'
%
%   dir_main_save_folder - Ruta carpeta seleccionada en .zip
%                       ex: 'C:\Users\jllobet\Pictures\nomfile.zip'
%
% Nota logistica: 
%   El fet de crear una carpeta i borrar-la no fa que aquesta sigui dins de
%   la papelera de reciclaje.
%
% Afegir:
% - Arxiu ruta carpeta imatges
% - Arxiu noms imatges
% - Arxiu noms rutes imatges
% Comprimirho tot.

% INICI FUNCIÓ


    % Modificacio ruta inicials
    dir_split = strsplit(dir_main_save_folder, "\");
    carpeta_to_save = strjoin(dir_split(1:end-1), "\");

    str_folder = separar_puntfile_nou(dir_split{end}); % Nom definit en .zip. Es guardarà l'arxiu intern de .zip.

%     % Separem nom carpeta imatges (si volem guardar amb el nom de la imatge predefinit)
%     dir_img_split = strsplit(myFolder, "\");
%     str_folder = dir_img_split{end};

    
    % Desgloçament de les portes (array_portes)
    c_elegans_IAdata = array_portes(1);
    c_elegans_and_non_c_elegans_IAdata = array_portes(2);
    generar_PascalVOC = array_portes(3);
    generar_BW_obj = array_portes(4);
    generar_BW_obj_junts = array_portes(5);
    generar_BW_obj_label = array_portes(6);
    generar_BW_obj_label_unit = array_portes(7);
    
    
    
    % Variables entrada (exemples)
    % carpeta_to_save = "E:\Josep_Llobet\Length determination v2_14\2023_01_04_Generar_dades_extra";
    % carpeta on es guardaràn les carpetes amb les anotacións i imatges.
    % S_textscan_table
    %   taula (en MATLAB) amb les dades.
    
    
    
    % ___Filtratge S_textscan_table___
    % _drawline_
    % De moment treiem els valors que tinguin drawline:
    % Motiu: Els index dels objectes són el dibuixat.
    % ÇÇÇ Millora: Aplicació de selecció de la mitja de l'amplada de cada punt de percentatge en la
    % esqueletonització, en funció a la llargada del C. elegans. D'aquesta
    % manera es podria defeinir la imatge binaria del C. elegans que s'ha dibuixada.
    S_textscan_table = S_textscan_table(S_textscan_table.Modifs ~= "DrawLine", :);
    
    % IA_data
    %       -- Celegans
    %       -- Celegans_and_NoCelegans
    
    % % Portes extracció dades
    % c_elegans_IAdata = true; % C elegans
    % c_elegans_and_non_c_elegans_IAdata = true; % C elegans i no- C elegans
    
    
    
    % creació carpeta
    dir_main_IAdata = strcat(carpeta_to_save, "\", "IA_data_", str_folder);
    
    if isfolder(dir_main_IAdata)
        ms_g = imread("icon_48.png");
        waitfor(msgbox("A folder with the same name already exists and interrupts the exportation execution.", "Advise", 'custom', ms_g));

        % ÇÇ Borrarr carpeta??
    else

        % Si no hi ha una carpeta que es digui igual:
        if (c_elegans_IAdata | c_elegans_and_non_c_elegans_IAdata) & ~isfolder(dir_main_IAdata)
            mkdir(dir_main_IAdata)
        end
        
        
        
        % % Portes tipologia exportació dades
        % generar_PascalVOC = true; % Porta generar Pascal VOC
        % generar_BW_obj = true;
        % generar_BW_obj_junts = true;
        % generar_BW_obj_label = true;
        % generar_BW_obj_label_unit = true; % img label on 1: C. elegans, 2: no-C. elegans
            
            
        
        
        % Dos opcions: Nomès C. elegans, o C. elegans i no C elegans.
        
        
        % ____Nomès C. elegans____ 
        % Es guarden les propietats de sols els objectes anotats com C. elegans.
        if c_elegans_IAdata
            S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
            
        
            % __Directoris__
            % Directori seleccionat
            dir_mainly_output_yes = strcat(dir_main_IAdata, "\Celegans"); % Directori seleccionat o pre-seleccionat
            % dir_mainly_output_yes = "2023_01_04_Generar_dades_extra"; % Directori seleccionat o pre-seleccionat
            
            
            % Es crea carpeta Celegans_IAdata
            if (generar_PascalVOC | generar_BW_obj | generar_BW_obj_junts | generar_BW_obj_label | generar_BW_obj_label_unit) & ~isfolder(dir_mainly_output_yes)
                mkdir(dir_mainly_output_yes)
            end
            
            % Directoris nous
            
            if generar_PascalVOC
                dir_save_PascalVOC = "PascalVOC_files";
                
                if ~isfolder(strcat(dir_mainly_output_yes, "\", dir_save_PascalVOC))
                    mkdir(strcat(dir_mainly_output_yes, "\", dir_save_PascalVOC))
                end
            end
            
            if generar_BW_obj
                dir_save_BW_imgs_1 = "BW_singular";
                if ~isfolder(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_1))
                    mkdir(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_1))
                end
            end
            
            
            
            if generar_BW_obj_junts
                dir_save_BW_imgs_2 = "BW_joined";
                if ~isfolder(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_2))
                    mkdir(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_2))
                end
            end
            
            if generar_BW_obj_label
                dir_save_BW_imgs_3 = "BW_label";
                if ~isfolder(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_3))
                    mkdir(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_3))
                end
            end
            
            
            if generar_BW_obj_label_unit
                dir_save_BW_imgs_4 = "BW_label_unit";
                if ~isfolder(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_4))
                    mkdir(strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_4))
                end
            end
            
        
            % Waitbar
            f = waitbar(0,'Exporting data (step 1)');    
            
            % Per cada imatge
            for img_every = unique(S_textscan_table_yes.NomWorm)'
        
                % Posicio
                [~, loc_B] = ismember(img_every, unique(S_textscan_table_yes.NomWorm)');
                percen_bar = loc_B/numel(unique(S_textscan_table_yes.NomWorm)');
        
                % Obtenim steps
                if c_elegans_IAdata & c_elegans_and_non_c_elegans_IAdata
                    steps_tot = 2;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                else
                    steps_tot = 1;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                end
        
        
                S_textscan_table_yes_img = S_textscan_table_yes(S_textscan_table_yes.NomWorm == img_every, :);
            
                % Si no es vuit:
                if ~isempty(S_textscan_table_yes_img)
            
            
            
                    % Nom de la imatge
                    nom_img = separar_puntfile(S_textscan_table_yes_img(1,:).NomWorm);
                    ruta_img_name = strcat(myFolder, "\", S_textscan_table_yes_img(1,:).NomWorm);
                    
                    resolution_img = appf_split_strindex(S_textscan_table_yes_img(1,:).Resolution)';             
            
                    % ___Generació Pascal VOC___ 
                    if generar_PascalVOC
                        % Obtenim cell dels Bounding Box:
                        cell_BB = {};
                        for row_table = 1:height(S_textscan_table_yes_img)
                            [cell_BB] = cell_insert_valors(cell_BB, appf_split_strindex_BB(S_textscan_table_yes_img(row_table, :).Bounding));
                        end
                
                        % Ara podem fer el arxiu Pascal VOC?
                        create_Pascal_VOC(ruta_img_name, cell_BB, strcat(dir_mainly_output_yes, "\", dir_save_PascalVOC, "\", nom_img, ".xml" ))
                    end
            
            
            
                    % ___Generació objectes binàris___ 
                    if generar_BW_obj
            
                        % Loop cada objecte:
                        n_obj_yes = 1; % Contador suma numero d'objectes
            
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            imwrite(BW_image, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_1, "\", nom_img, "_", retorna_zeros_un(n_obj_yes), ".png"))
                
                            n_obj_yes = n_obj_yes +1;            
                        end
            
                    end
            
            
            
                    % ___Generació objectes binàris junts___ 
                    if generar_BW_obj_junts
            
                        BW_obj_junts = false(resolution_img);
                        
                        for n_worm = 1:height(S_textscan_table_yes_img)    
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts = BW_obj_junts | BW_image;
                        
                        end
            
                        imwrite(BW_obj_junts, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_2, "\", nom_img, ".png"))
             
                    end
                    
            
            
                    % ___Generació objectes binàris label___ 
                    if generar_BW_obj_label
            
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = n_worm;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Proba comprovacio visualització
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_3, "\", nom_img, ".png"))
                        
            
                    end
            
            
            
                    % ___Generació objectes binàris label unit___ 
                    if generar_BW_obj_label_unit
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = 1;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Proba comprovacio visualització
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_4, "\", nom_img, ".png"))
    
                    end        
            
                    % __Guardem .txt amb els noms de les imatges__
                    % img_every : "Image_828.jpg"
                    write_str_txt(strcat(dir_mainly_output_yes, "\file_names.txt"), img_every) % File names
                    write_str_txt(strcat(dir_mainly_output_yes, "\file_rutes.txt"), strcat(myFolder, "\", img_every) ) % File rutes
                    
                end
    
    
    
    
            end % end del for de cada img
        
                close(f)
        
        end % fi nomès C. elegans data (IA_data\Celegans)
        
        
        
        
        
        % ____C. elegans i no C. elegans data____
        % Es guarden les propietats dels objectes anotats com C. elegans i dels anotats com no-C. elegans.
        if c_elegans_and_non_c_elegans_IAdata
        
            S_textscan_table_yes_and_no = S_textscan_table;
            
            
            % __Directoris__
            % Directori seleccionat
            dir_mainly_output_yes_and_no = strcat(dir_main_IAdata, "\Celegans_and_NoCelegans"); % Directori seleccionat o pre-seleccionat
            % dir_mainly_output_yes_and_no = "2023_01_04_Generar_dades_extra"; % Directori seleccionat o pre-seleccionat
            
            
            % Es crea carpeta Celegans_IAdata
            if (generar_PascalVOC | generar_BW_obj | generar_BW_obj_junts | generar_BW_obj_label | generar_BW_obj_label_unit) & ~isfolder(dir_mainly_output_yes_and_no)
                mkdir(dir_mainly_output_yes_and_no)
            end
            
            % Directoris nous
            
            if generar_PascalVOC
                dir_save_PascalVOC = "PascalVOC_files";
                
                if ~isfolder(strcat(dir_mainly_output_yes_and_no, "\", dir_save_PascalVOC))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_PascalVOC))
                end
            end
            
            if generar_BW_obj
                dir_save_BW_imgs_1 = "BW_singular";
                if ~isfolder(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\Celeg"))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\NonCeleg"))            
                end
            end
            
            
            
            if generar_BW_obj_junts
                dir_save_BW_imgs_2 = "BW_joined";
                if ~isfolder(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_2))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_2))
                end
            end
            
            if generar_BW_obj_label
                dir_save_BW_imgs_3 = "BW_label";
                if ~isfolder(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_3))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_3))
                end
            end
            
            
            if generar_BW_obj_label_unit
                dir_save_BW_imgs_4 = "BW_label_unit";
                if ~isfolder(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_4))
                    mkdir(strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_4))
                end
            end
            
            
            % Waitbar
            f = waitbar(0,'Exporting data (step 2)');
        
            % Per cada imatge
            for img_every = unique(S_textscan_table_yes_and_no.NomWorm)'
        
                % Posicio
                [~, loc_B] = ismember(img_every, unique(S_textscan_table_yes_and_no.NomWorm)');
                percen_bar = loc_B/numel(unique(S_textscan_table_yes_and_no.NomWorm)');
        
                % Obtenim steps
                if c_elegans_IAdata & c_elegans_and_non_c_elegans_IAdata
                    steps_tot = 2;
                    waitbar(percen_bar,f, strcat('Exporting data (step 2/', string(steps_tot), ')') );
                else
                    steps_tot = 1;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                end
        
        
                S_textscan_table_yes_and_no_img = S_textscan_table_yes_and_no(S_textscan_table_yes_and_no.NomWorm == img_every, :);
            
        
                % Si no es vuit:
                if ~isempty(S_textscan_table_yes_and_no_img)
            
            
            
                    % Nom de la imatge
                    nom_img = separar_puntfile(S_textscan_table_yes_and_no_img(1,:).NomWorm);
                    ruta_img_name = strcat(myFolder, "\", S_textscan_table_yes_and_no_img(1,:).NomWorm);
                    
                    resolution_img = appf_split_strindex(S_textscan_table_yes_and_no_img(1,:).Resolution)';             
            
                    % ___Generació Pascal VOC___ 
                    if generar_PascalVOC
                        % Obtenim cell dels Bounding Box:
                        cell_BB = {};
                        for row_table = 1:height(S_textscan_table_yes_and_no_img)
                            [cell_BB] = cell_insert_valors(cell_BB, appf_split_strindex_BB(S_textscan_table_yes_and_no_img(row_table, :).Bounding));
                        end
                
                        % Obtneim cell amb les anotacions
                        cell_label_props = {};
                        for row_table = 1:height(S_textscan_table_yes_and_no_img)
                            if isequal(S_textscan_table_yes_and_no_img(row_table, :).IsCeleg, "yes")
                                cell_label_props = cell_insert_valors(cell_label_props, "Celegans");
                            elseif isequal(S_textscan_table_yes_and_no_img(row_table, :).IsCeleg, "no")
                                cell_label_props = cell_insert_valors(cell_label_props, "NonCelegans");        
                            else
                                error("Error in data processment of previous create_Pascal_VOC_label function")
                            end
                        end
        
                        % Ara podem fer el arxiu Pascal VOC?
                        create_Pascal_VOC_label(ruta_img_name, cell_BB, cell_label_props, strcat(dir_mainly_output_yes_and_no, "\", dir_save_PascalVOC, "\", nom_img, ".xml" ));
                    end
            
            
            
                    % ___Generació objectes binàris___ 
                    if generar_BW_obj
            
                        % Loop cada objecte:
                        n_obj_yes = 1; % Contador suma numero d'objectes
                        n_obj_no = 1;
            
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)
                
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
        
                            % es guarda en "\Celeg" & "\NonCeleg"
                            if isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "yes")
        
                                imwrite(BW_image, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\Celeg", "\", nom_img, "_", retorna_zeros_un(n_obj_yes), ".png"))
                                n_obj_yes = n_obj_yes +1;            
        
                            elseif isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "no")
        
                                imwrite(BW_image, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\NonCeleg", "\", nom_img, "_", retorna_zeros_un(n_obj_no), ".png"))                        
                                n_obj_no = n_obj_no +1;            
                            else
                                error("Error in generate data of BW singular: non 'yes' or 'not' anotation")
                            end
        
                        end
            
                    end
            
            
            
                    % ___Generació objectes binàris junts___ 
                    if generar_BW_obj_junts
            
                        BW_obj_junts = false(resolution_img);
                        
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)    
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
                            BW_obj_junts = BW_obj_junts | BW_image;
                        
                        end
            
                        imwrite(BW_obj_junts, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_2, "\", nom_img, ".png"))
             
                    end
                    
            
            
                    % ___Generació objectes binàris label___ 
                    if generar_BW_obj_label
            
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = n_worm;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Proba comprovacio visualització
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_3, "\", nom_img, ".png"))
                        
            
                    end
            
            
            
                    % ___Generació objectes binàris label unit___ 
                    if generar_BW_obj_label_unit
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
                            if isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "yes")
                                BW_obj_junts_lab(BW_image) = 1;
                            elseif isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "no")
                                BW_obj_junts_lab(BW_image) = 2;
                            else
                                error("Error in data preparation of BW_label_unit: non correct anotation")
                            end
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Proba comprovacio visualització
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_4, "\", nom_img, ".png"))
             
                    end        
                            
                    % __Guardem .txt amb els noms de les imatges__
                    % img_every : "Image_828.jpg"
                    write_str_txt(strcat(dir_mainly_output_yes_and_no, "\file_names.txt"), img_every) % File names
                    write_str_txt(strcat(dir_mainly_output_yes_and_no, "\file_rutes.txt"), strcat(myFolder, "\", img_every) ) % File rutes
    
            
                end
            end % end del for de cada img
        
        
            close(f)
        
        end % fi C. elegans i no C. elegans data (IA_data\Celegans_and_NoCelegans)
        

        % __Comprimir en .zip__

        % Guardar en un .Zip!
        % dir_main_save_folder % Ruta .zip on guardar
        % dir_main_IAdata : directori a comprimir
        zippedfiles = zip(dir_main_save_folder, dir_main_IAdata);

        % Borrar directori creat
        rmdir(dir_main_IAdata,'s')
        
    
    end % end isfolder()

% FINAL FUNCIÓ



end


% Sub-funcións





function [Colormap_josep] = obtenir_colormap_Josep()
    
    Colormap_josep = [      0         0         0
        0.5020         0         0
             0    0.5020         0
        0.5020    0.5020         0
             0         0    0.5020
        0.5020         0    0.5020
             0    0.5020    0.5020
        0.5020    0.5020    0.5020
        0.2510         0         0
        0.7529         0         0
        0.2510    0.5020         0
        0.7529    0.5020         0
        0.2510         0    0.5020
        0.7529         0    0.5020
        0.2510    0.5020    0.5020
        0.7529    0.5020    0.5020
             0    0.2510         0
        0.5020    0.2510         0
             0    0.7529         0
        0.5020    0.7529         0
             0    0.2510    0.5020
        0.5020    0.2510    0.5020
             0    0.7529    0.5020
        0.5020    0.7529    0.5020
        0.2510    0.2510         0
        0.7529    0.2510         0
        0.2510    0.7529         0
        0.7529    0.7529         0
        0.2510    0.2510    0.5020
        0.7529    0.2510    0.5020
        0.2510    0.7529    0.5020
        0.7529    0.7529    0.5020
             0         0    0.2510
        0.5020         0    0.2510
             0    0.5020    0.2510
        0.5020    0.5020    0.2510
             0         0    0.7529
        0.5020         0    0.7529
             0    0.5020    0.7529
        0.5020    0.5020    0.7529
        0.2510         0    0.2510
        0.7529         0    0.2510
        0.2510    0.5020    0.2510
        0.7529    0.5020    0.2510
        0.2510         0    0.7529
        0.7529         0    0.7529
        0.2510    0.5020    0.7529
        0.7529    0.5020    0.7529
             0    0.2510    0.2510
        0.5020    0.2510    0.2510
             0    0.7529    0.2510
        0.5020    0.7529    0.2510
             0    0.2510    0.7529
        0.5020    0.2510    0.7529
             0    0.7529    0.7529
        0.5020    0.7529    0.7529
        0.2510    0.2510    0.2510
        0.7529    0.2510    0.2510
        0.2510    0.7529    0.2510
        0.7529    0.7529    0.2510
        0.2510    0.2510    0.7529
        0.7529    0.2510    0.7529
        0.2510    0.7529    0.7529
        0.7529    0.7529    0.7529
        0.1255         0         0
        0.6275         0         0
        0.1255    0.5020         0
        0.6275    0.5020         0
        0.1255         0    0.5020
        0.6275         0    0.5020
        0.1255    0.5020    0.5020
        0.6275    0.5020    0.5020
        0.3765         0         0
        0.8784         0         0
        0.3765    0.5020         0
        0.8784    0.5020         0
        0.3765         0    0.5020
        0.8784         0    0.5020
        0.3765    0.5020    0.5020
        0.8784    0.5020    0.5020
        0.1255    0.2510         0
        0.6275    0.2510         0
        0.1255    0.7529         0
        0.6275    0.7529         0
        0.1255    0.2510    0.5020
        0.6275    0.2510    0.5020
        0.1255    0.7529    0.5020
        0.6275    0.7529    0.5020
        0.3765    0.2510         0
        0.8784    0.2510         0
        0.3765    0.7529         0
        0.8784    0.7529         0
        0.3765    0.2510    0.5020
        0.8784    0.2510    0.5020
        0.3765    0.7529    0.5020
        0.8784    0.7529    0.5020
        0.1255         0    0.2510
        0.6275         0    0.2510
        0.1255    0.5020    0.2510
        0.6275    0.5020    0.2510
        0.1255         0    0.7529
        0.6275         0    0.7529
        0.1255    0.5020    0.7529
        0.6275    0.5020    0.7529
        0.3765         0    0.2510
        0.8784         0    0.2510
        0.3765    0.5020    0.2510
        0.8784    0.5020    0.2510
        0.3765         0    0.7529
        0.8784         0    0.7529
        0.3765    0.5020    0.7529
        0.8784    0.5020    0.7529
        0.1255    0.2510    0.2510
        0.6275    0.2510    0.2510
        0.1255    0.7529    0.2510
        0.6275    0.7529    0.2510
        0.1255    0.2510    0.7529
        0.6275    0.2510    0.7529
        0.1255    0.7529    0.7529
        0.6275    0.7529    0.7529
        0.3765    0.2510    0.2510
        0.8784    0.2510    0.2510
        0.3765    0.7529    0.2510
        0.8784    0.7529    0.2510
        0.3765    0.2510    0.7529
        0.8784    0.2510    0.7529
        0.3765    0.7529    0.7529
        0.8784    0.7529    0.7529
             0    0.1255         0
        0.5020    0.1255         0
             0    0.6275         0
        0.5020    0.6275         0
             0    0.1255    0.5020
        0.5020    0.1255    0.5020
             0    0.6275    0.5020
        0.5020    0.6275    0.5020
        0.2510    0.1255         0
        0.7529    0.1255         0
        0.2510    0.6275         0
        0.7529    0.6275         0
        0.2510    0.1255    0.5020
        0.7529    0.1255    0.5020
        0.2510    0.6275    0.5020
        0.7529    0.6275    0.5020
             0    0.3765         0
        0.5020    0.3765         0
             0    0.8784         0
        0.5020    0.8784         0
             0    0.3765    0.5020
        0.5020    0.3765    0.5020
             0    0.8784    0.5020
        0.5020    0.8784    0.5020
        0.2510    0.3765         0
        0.7529    0.3765         0
        0.2510    0.8784         0
        0.7529    0.8784         0
        0.2510    0.3765    0.5020
        0.7529    0.3765    0.5020
        0.2510    0.8784    0.5020
        0.7529    0.8784    0.5020
             0    0.1255    0.2510
        0.5020    0.1255    0.2510
             0    0.6275    0.2510
        0.5020    0.6275    0.2510
             0    0.1255    0.7529
        0.5020    0.1255    0.7529
             0    0.6275    0.7529
        0.5020    0.6275    0.7529
        0.2510    0.1255    0.2510
        0.7529    0.1255    0.2510
        0.2510    0.6275    0.2510
        0.7529    0.6275    0.2510
        0.2510    0.1255    0.7529
        0.7529    0.1255    0.7529
        0.2510    0.6275    0.7529
        0.7529    0.6275    0.7529
             0    0.3765    0.2510
        0.5020    0.3765    0.2510
             0    0.8784    0.2510
        0.5020    0.8784    0.2510
             0    0.3765    0.7529
        0.5020    0.3765    0.7529
             0    0.8784    0.7529
        0.5020    0.8784    0.7529
        0.2510    0.3765    0.2510
        0.7529    0.3765    0.2510
        0.2510    0.8784    0.2510
        0.7529    0.8784    0.2510
        0.2510    0.3765    0.7529
        0.7529    0.3765    0.7529
        0.2510    0.8784    0.7529
        0.7529    0.8784    0.7529
        0.1255    0.1255         0
        0.6275    0.1255         0
        0.1255    0.6275         0
        0.6275    0.6275         0
        0.1255    0.1255    0.5020
        0.6275    0.1255    0.5020
        0.1255    0.6275    0.5020
        0.6275    0.6275    0.5020
        0.3765    0.1255         0
        0.8784    0.1255         0
        0.3765    0.6275         0
        0.8784    0.6275         0
        0.3765    0.1255    0.5020
        0.8784    0.1255    0.5020
        0.3765    0.6275    0.5020
        0.8784    0.6275    0.5020
        0.1255    0.3765         0
        0.6275    0.3765         0
        0.1255    0.8784         0
        0.6275    0.8784         0
        0.1255    0.3765    0.5020
        0.6275    0.3765    0.5020
        0.1255    0.8784    0.5020
        0.6275    0.8784    0.5020
        0.3765    0.3765         0
        0.8784    0.3765         0
        0.3765    0.8784         0
        0.8784    0.8784         0
        0.3765    0.3765    0.5020
        0.8784    0.3765    0.5020
        0.3765    0.8784    0.5020
        0.8784    0.8784    0.5020
        0.1255    0.1255    0.2510
        0.6275    0.1255    0.2510
        0.1255    0.6275    0.2510
        0.6275    0.6275    0.2510
        0.1255    0.1255    0.7529
        0.6275    0.1255    0.7529
        0.1255    0.6275    0.7529
        0.6275    0.6275    0.7529
        0.3765    0.1255    0.2510
        0.8784    0.1255    0.2510
        0.3765    0.6275    0.2510
        0.8784    0.6275    0.2510
        0.3765    0.1255    0.7529
        0.8784    0.1255    0.7529
        0.3765    0.6275    0.7529
        0.8784    0.6275    0.7529
        0.1255    0.3765    0.2510
        0.6275    0.3765    0.2510
        0.1255    0.8784    0.2510
        0.6275    0.8784    0.2510
        0.1255    0.3765    0.7529
        0.6275    0.3765    0.7529
        0.1255    0.8784    0.7529
        0.6275    0.8784    0.7529
        0.3765    0.3765    0.2510
        0.8784    0.3765    0.2510
        0.3765    0.8784    0.2510
        0.8784    0.8784    0.2510
        0.3765    0.3765    0.7529
        0.8784    0.3765    0.7529
        0.3765    0.8784    0.7529
        0.8784    0.8784    0.7529];


end
