function export_IA_data(S_textscan_table, myFolder, dir_main_save_folder, array_portes)

% Exports the data recorded in S_textscan to a folder.
%
% The result is a compressed folder with the indicated name (ex:
% "C_48_Josla.zip"), which will have inside the folder with the IA data (ex:
% "\IA_data_C_48_josla").
% Note: If the .zip file already exists, there is a warning, and it is overwritten.
% 
%
% Variables
%   myFolder - Original images path.
%               ex: 'C:\Users\jllobet\Pictures\Controls\C_24'
%
%   dir_main_save_folder - Path for compressed folder (.zip)
%                ex: 'C:\Users\jllobet\Pictures\C_24_controls.zip'
%
% Logistical note:
% Creating a folder and deleting it does not put it into the recycling bin.

% START FUNCTION


    % Modify initial path
    dir_split = strsplit(dir_main_save_folder, "\");
    carpeta_to_save = strjoin(dir_split(1:end-1), "\");

    str_folder = divide_pointfile_large(dir_split{end}); % Name defined in .zip. Will save the internal .zip file.

%     % Separate name of image folder (if we want to by default save with the image name)
%     dir_img_split = strsplit(myFolder, "\");
%     str_folder = dir_img_split{end};

    
    % Door breakdown (array_portes)
    c_elegans_IAdata = array_portes(1);
    c_elegans_and_non_c_elegans_IAdata = array_portes(2);
    generar_PascalVOC = array_portes(3);
    generar_BW_obj = array_portes(4);
    generar_BW_obj_junts = array_portes(5);
    generar_BW_obj_label = array_portes(6);
    generar_BW_obj_label_unit = array_portes(7);
    
    
    
    %  Input variables (examples)
    % carpeta_to_save = "E:\Josep_Llobet\Length determination v2_14\2023_01_04_Generar_dades_extra";
    % folder where the folders with the annotations and images are saved.
    % S_textscan_table
    %   MATLAB table with the data.
    
    
    
    % ___Filter S_textscan_table___
    % _drawline_
    % Get rid of the values with drawline:
    % Their indices are the drawn line.
    S_textscan_table = S_textscan_table(S_textscan_table.Modifs ~= "DrawLine", :);
    
    % IA_data
    %       -- Celegans
    %       -- Celegans_and_NoCelegans
    
    % % Data extraction doors
    % c_elegans_IAdata = true; % C elegans
    % c_elegans_and_non_c_elegans_IAdata = true; % C elegans i no- C elegans
    
    
    
    % Create file
    dir_main_IAdata = strcat(carpeta_to_save, "\", "IA_data_", str_folder);
    
    if isfolder(dir_main_IAdata)
        ms_g = imread("icon_48.png");
        waitfor(msgbox("A folder with the same name already exists and interrupts the exportation execution.", "Advise", 'custom', ms_g));
    else
        % If there is no folder with the same name:
        if (c_elegans_IAdata | c_elegans_and_non_c_elegans_IAdata) & ~isfolder(dir_main_IAdata)
            mkdir(dir_main_IAdata)
        end
        
        
        
        % % Type doors export data
        % generar_PascalVOC = true; % Door generate Pascal VOC
        % generar_BW_obj = true;
        % generar_BW_obj_junts = true;
        % generar_BW_obj_label = true;
        % generar_BW_obj_label_unit = true; % img label on 1: C. elegans, 2: no-C. elegans
            
            
        
        
        % Two options: Only C. elegans, or C. elegans and no C elegans.
        
        
        % ____Only C. elegans____ 
        % The properties of only objects annotated as C. elegans are saved.
        if c_elegans_IAdata
            S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
            
        
            % __Folder__
            % Selected folder
            dir_mainly_output_yes = strcat(dir_main_IAdata, "\Celegans"); 
            % dir_mainly_output_yes = "2023_01_04_Generar_dades_extra"; 
            
            
            % Create folder Celegans_IAdata
            if (generar_PascalVOC | generar_BW_obj | generar_BW_obj_junts | generar_BW_obj_label | generar_BW_obj_label_unit) & ~isfolder(dir_mainly_output_yes)
                mkdir(dir_mainly_output_yes)
            end
            
            % New directory
            
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
            
            % For every image
            for img_every = unique(S_textscan_table_yes.NomWorm)'
        
                % Position
                [~, loc_B] = ismember(img_every, unique(S_textscan_table_yes.NomWorm)');
                percen_bar = loc_B/numel(unique(S_textscan_table_yes.NomWorm)');
        
                % Obtain steps
                if c_elegans_IAdata & c_elegans_and_non_c_elegans_IAdata
                    steps_tot = 2;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                else
                    steps_tot = 1;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                end
        
        
                S_textscan_table_yes_img = S_textscan_table_yes(S_textscan_table_yes.NomWorm == img_every, :);
            
                % If not empty
                if ~isempty(S_textscan_table_yes_img)
            
                    % Image name
                    nom_img = divide_pointfile(S_textscan_table_yes_img(1,:).NomWorm);
                    ruta_img_name = strcat(myFolder, "\", S_textscan_table_yes_img(1,:).NomWorm);
                    
                    resolution_img = appf_split_strindex(S_textscan_table_yes_img(1,:).Resolution)';             
            
                    % ___Generate Pascal VOC___ 
                    if generar_PascalVOC
                        % Obtain Bounding Box cell:
                        cell_BB = {};
                        for row_table = 1:height(S_textscan_table_yes_img)
                            [cell_BB] = cell_insert_values(cell_BB, appf_split_strindex_BB(S_textscan_table_yes_img(row_table, :).Bounding));
                        end
                
                        % Create the Pascal VOC file
                        create_Pascal_VOC(ruta_img_name, cell_BB, strcat(dir_mainly_output_yes, "\", dir_save_PascalVOC, "\", nom_img, ".xml" ))
                    end
            
            
            
                    % ___Create binary objects___ 
                    if generar_BW_obj
            
                        % Loop every object:
                        n_obj_yes = 1; % Counter of object number
            
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            imwrite(BW_image, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_1, "\", nom_img, "_", return_zeros_one(n_obj_yes), ".png"))
                
                            n_obj_yes = n_obj_yes +1;            
                        end
            
                    end
            
            
            
                    % ___Create binary objects together___ 
                    if generar_BW_obj_junts
            
                        BW_obj_junts = false(resolution_img);
                        
                        for n_worm = 1:height(S_textscan_table_yes_img)    
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts = BW_obj_junts | BW_image;
                        
                        end
            
                        imwrite(BW_obj_junts, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_2, "\", nom_img, ".png"))
             
                    end
                    
            
            
                    % ___Create label binary objects___ 
                    if generar_BW_obj_label
            
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = n_worm;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Check visually
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_3, "\", nom_img, ".png"))
                        
            
                    end
            
            
            
                    % ___Create label unit binary objects___ 
                    if generar_BW_obj_label_unit
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = 1;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Check visually
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes, "\", dir_save_BW_imgs_4, "\", nom_img, ".png"))
    
                    end        
            
                    % __Save .txt with the images names__
                    % img_every : "Image_828.jpg"
                    write_str_txt(strcat(dir_mainly_output_yes, "\file_names.txt"), img_every) % File names
                    write_str_txt(strcat(dir_mainly_output_yes, "\file_rutes.txt"), strcat(myFolder, "\", img_every) ) % File paths
                    
                end
    
    
    
    
            end % end of for every img
        
                close(f)
        
        end % end of only C. elegans data (IA_data\Celegans)
        
        
        
        
        
        % ____C. elegans and no C. elegans data____
        % The properties of objects annotated as C. elegans and those annotated as non-C. elegans are saved.
        if c_elegans_and_non_c_elegans_IAdata
        
            S_textscan_table_yes_and_no = S_textscan_table;
            
            
            % __Folder__
            % Selected folder
            dir_mainly_output_yes_and_no = strcat(dir_main_IAdata, "\Celegans_and_NoCelegans"); 
            % dir_mainly_output_yes_and_no = "2023_01_04_Generar_dades_extra"; 
            
            
            % Create folder Celegans_IAdata
            if (generar_PascalVOC | generar_BW_obj | generar_BW_obj_junts | generar_BW_obj_label | generar_BW_obj_label_unit) & ~isfolder(dir_mainly_output_yes_and_no)
                mkdir(dir_mainly_output_yes_and_no)
            end
            
            % New directory
            
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
        
            % For every image
            for img_every = unique(S_textscan_table_yes_and_no.NomWorm)'
        
                % Position
                [~, loc_B] = ismember(img_every, unique(S_textscan_table_yes_and_no.NomWorm)');
                percen_bar = loc_B/numel(unique(S_textscan_table_yes_and_no.NomWorm)');
        
                % Obtain steps
                if c_elegans_IAdata & c_elegans_and_non_c_elegans_IAdata
                    steps_tot = 2;
                    waitbar(percen_bar,f, strcat('Exporting data (step 2/', string(steps_tot), ')') );
                else
                    steps_tot = 1;
                    waitbar(percen_bar,f, strcat('Exporting data (step 1/', string(steps_tot), ')') );
                end
        
        
                S_textscan_table_yes_and_no_img = S_textscan_table_yes_and_no(S_textscan_table_yes_and_no.NomWorm == img_every, :);
            
        
                % If not empty
                if ~isempty(S_textscan_table_yes_and_no_img)
            
            
            
                    % Image name
                    nom_img = divide_pointfile(S_textscan_table_yes_and_no_img(1,:).NomWorm);
                    ruta_img_name = strcat(myFolder, "\", S_textscan_table_yes_and_no_img(1,:).NomWorm);
                    
                    resolution_img = appf_split_strindex(S_textscan_table_yes_and_no_img(1,:).Resolution)';             
            
                    % ___Generate Pascal VOC___ 
                    if generar_PascalVOC
                        % Obtain Bounding Box cell:
                        cell_BB = {};
                        for row_table = 1:height(S_textscan_table_yes_and_no_img)
                            [cell_BB] = cell_insert_values(cell_BB, appf_split_strindex_BB(S_textscan_table_yes_and_no_img(row_table, :).Bounding));
                        end
                
                        % Obtain cell with the annotations
                        cell_label_props = {};
                        for row_table = 1:height(S_textscan_table_yes_and_no_img)
                            if isequal(S_textscan_table_yes_and_no_img(row_table, :).IsCeleg, "yes")
                                cell_label_props = cell_insert_values(cell_label_props, "Celegans");
                            elseif isequal(S_textscan_table_yes_and_no_img(row_table, :).IsCeleg, "no")
                                cell_label_props = cell_insert_values(cell_label_props, "NonCelegans");        
                            else
                                error("Error in data processment of previous create_Pascal_VOC_label function")
                            end
                        end
        
                        % Create the Pascal VOC file
                        create_Pascal_VOC_label(ruta_img_name, cell_BB, cell_label_props, strcat(dir_mainly_output_yes_and_no, "\", dir_save_PascalVOC, "\", nom_img, ".xml" ));
                    end
            
            
            
                    % ___Create binary objects___ 
                    if generar_BW_obj
            
                        % Loop every object:
                        n_obj_yes = 1; % Counter of object number
                        n_obj_no = 1;
            
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)
                
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
        
                            % Save in "\Celeg" & "\NonCeleg"
                            if isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "yes")
        
                                imwrite(BW_image, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\Celeg", "\", nom_img, "_", return_zeros_one(n_obj_yes), ".png"))
                                n_obj_yes = n_obj_yes +1;            
        
                            elseif isequal(S_textscan_table_yes_and_no_img(n_worm,:).IsCeleg, "no")
        
                                imwrite(BW_image, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_1, "\NonCeleg", "\", nom_img, "_", return_zeros_one(n_obj_no), ".png"))                        
                                n_obj_no = n_obj_no +1;            
                            else
                                error("Error in generate data of BW singular: non 'yes' or 'not' anotation")
                            end
        
                        end
            
                    end
            
            
            
                    % ___Create binary objects together___ 
                    if generar_BW_obj_junts
            
                        BW_obj_junts = false(resolution_img);
                        
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)    
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
                            BW_obj_junts = BW_obj_junts | BW_image;
                        
                        end
            
                        imwrite(BW_obj_junts, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_2, "\", nom_img, ".png"))
             
                    end
                    
            
            
                    % ___Create label binary objects___ 
                    if generar_BW_obj_label
            
            
                        Colormap_josep = obtenir_colormap_Josep();
            
                        BW_obj_junts_lab = double(false(resolution_img));
            
                        for n_worm = 1:height(S_textscan_table_yes_and_no_img)
                
                    
                            [BW_image] = create_BW_indx(appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Indx_BW), appf_split_strindex(S_textscan_table_yes_and_no_img(n_worm,:).Resolution)');
                
                            BW_obj_junts_lab(BW_image) = n_worm;
                        
                        end
            
                        % BW_obj_junts_lab(1,1) = 255; % Check visually
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_3, "\", nom_img, ".png"))
                        
            
                    end
            
            
            
                    % ___Create label unit binary objects___ 
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
            
                        % BW_obj_junts_lab(1,1) = 255;  % Check visually
            
                        %  "BW_label"
                        imwrite(uint8(BW_obj_junts_lab), Colormap_josep, strcat(dir_mainly_output_yes_and_no, "\", dir_save_BW_imgs_4, "\", nom_img, ".png"))
             
                    end        
                            
                    % __Save .txt with the images names__
                    % img_every : "Image_828.jpg"
                    write_str_txt(strcat(dir_mainly_output_yes_and_no, "\file_names.txt"), img_every) % File names
                    write_str_txt(strcat(dir_mainly_output_yes_and_no, "\file_rutes.txt"), strcat(myFolder, "\", img_every) ) % File paths
    
            
                end
            end % end of for every img
        
        
            close(f)
        
        end % end of C. elegans and no C. elegans data (IA_data\Celegans_and_NoCelegans)
        

        % __Compress in .zip__

        % Save in a  .zip file
        % dir_main_save_folder % Path .zip to save
        % dir_main_IAdata : folder to compress
        zippedfiles = zip(dir_main_save_folder, dir_main_IAdata);

        % Erase created directory
        rmdir(dir_main_IAdata,'s')
        
    
    end % end isfolder()

% END FUNCTION



end


% Sub-functions

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
