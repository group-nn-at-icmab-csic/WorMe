function [bwlabel_BW_obj_sumatlinia, imatge_BW_colors, porta_window_drawline, zeros_imatge_cotxe_punts_units] = sum_BWobj_manual_multiple(BWobj_image, im_original, val_exampl)

% Donada una imatge binària singular, es defineix de manera manuall una línia amb la qual es talla la imatge binària.
% Es retorna la imatge binaria retallada (bwlabel_BW_obj_sumatlinia), així
% com la imatge en color retallada (imatge_BW_colors).
% Aquest últim procediment empra la funció f'BW_objects_to_color'.
% Si es defineix una segona imatge en color (3D), es superposa
% (f'imoverlay) a la imatge a l'hora de seleccionar la línia.
%
% La imatge pot tenir més d'un objecte binari, però ha de ser binària.
% Aquesta es retallarà.
%
% Variables
% ---------
% input:
% BWobj_image : Imatge binària amb un sol objecte binàri
% im_original : (opcional) Imatge original a superposar a la binària
%
% output:
% bwlabel_BW_obj_sumatlinia : imatge BW amb la línia restada.
% porta_window_drawline : Porta sobre si s'ha executat o no correctament la funció.
% imatge_BW_colors : Imatge BW colorejada
% zeros_imatge_cotxe_punts_units : Línia definida.
%
%
% See also
% BW_objects_to_color


% %Variable exemple
% bwlabel_BW_obj_sumatlinia2 = BW_llistat_imatges;
% imshow(bwlabel_BW_obj_sumatlinia2)
% BWobj_image = bwlabel_BW_obj_sumatlinia2;


% INICI FUNCIÓ

% Dibuixem línia
try

    if exist('im_original','var')
        %imoverlay_Bnorm = imoverlay(im_original, BWobj_image, "r");
        %imoverlay_Bnorm = imoverlay(im_original, BWobj_image, [0 0 0]);
        [imoverlay_Bnorm] = print_RGB_indx_brush(im_original, find(BWobj_image), [1 1 1]*-90);
        s_var = get(0, 'ScreenSize');
        imshow(imoverlay_Bnorm)
        set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])

    else
        s_var = get(0, 'ScreenSize');
        imshow(BWobj_image)
        set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])
    
    end


    try
        h1 = drawpolyline('SelectedColor','yellow');
        % h2 = drawline('SelectedColor','magenta');
        h1.Selected = true;
    
        % Posició dels punts de la línia
        ep = h1.Position;
        % Arrodonim posicions
        ep_rounded = round(ep);
    
        close
    
        if isempty(ep)
            porta_window_drawline = false;
        else
            porta_window_drawline = true;
        end


    catch
        porta_window_drawline = false;

        % Definim variables:
        bwlabel_BW_obj_sumatlinia = false;
        imatge_BW_colors = false;
        zeros_imatge_cotxe_punts_units = false;



    end
    
    if porta_window_drawline
        % DEFINIM LINIA EN IMATGE BINÀRIA
        
        % Imatge de zeros igual que la inicial
        [xd1, xd2, ~] = size(BWobj_image);
        zeros_imatge_cotxe = zeros(xd1, xd2);
        %size(zeros_imatge_cotxe)
        %imshow(zeros_imatge_cotxe)
        
        % Printem punts en imatge de zeros
        for cada_lin = 1:length(ep_rounded)
            %zeros_imatge_cotxe(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
            
            if cada_lin > 1
                % Fem una imatge zeros en blanc que contingui els dos píxels
                zeros_imatge_cotxe_blanc = zeros(xd1, xd2);
                
                % Punt anterior
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin-1,2), ep_rounded(cada_lin-1,1)) = 1;   
                % Punt posterior
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
                
        
                % Creem la línea
                zeros_imatge_cotxe_blanc_linea = bwconvhull(zeros_imatge_cotxe_blanc);
                
                % La sumem a la imatge de zeros principal
                zeros_imatge_cotxe = zeros_imatge_cotxe + zeros_imatge_cotxe_blanc_linea;
            end
        end
        
        % Igualem els vaors
        zeros_imatge_cotxe = zeros_imatge_cotxe>0;
        
        
        % La línia ha de ser gruixuda, sinó un sol píxel pot no separar la imatge.
        zeros_imatge_cotxe_punts_units = bwmorph(zeros_imatge_cotxe, 'diag');
        
        
        % Eixamplem els píxels de la línia
        [total_indx_fin] = eixamplar_indx_BB(find(zeros_imatge_cotxe_punts_units), val_exampl, size(zeros_imatge_cotxe_punts_units));
        zeros_imatge_cotxe_punts_units(total_indx_fin) = 1;
        
        
        % RESTEM LA LÍNIA A LA IMATGE BINARIA INICIAL
        bwlabel_BW_obj_sumatlinia = BWobj_image + zeros_imatge_cotxe_punts_units;
        bwlabel_BW_obj_sumatlinia = bwlabel_BW_obj_sumatlinia > 0;
        %unique(bwlabel_BW_obj_sumatlinia)
        
        [imatge_BW_colors, ~, ~] = BW_objects_to_color(bwlabel_BW_obj_sumatlinia);
        %imshow(imatge_BW_colors)
        
        
        % % Exemple Posterior esqueletonització de la imatge
        % bwlabeled_obj_tot = bwlabel(bwlabel_BW_obj_sumatlinia);
        % bwlabeled_obj_tot_2 = bwlabeled_obj_tot == 2;
        % imshow(bwlabeled_obj_tot_2)
        % 
        % [~, ~, sfMaskBurn_newfunction, ~, ~] = ...
        %     esqueletonitzacio_josep(bwlabeled_obj_tot_2, imageArray, escala_imatge, 1);
        % imshow(sfMaskBurn_newfunction)

    else

        bwlabel_BW_obj_sumatlinia = false;
        imatge_BW_colors = false;
        porta_window_drawline = false;
        zeros_imatge_cotxe_punts_units = false;

    end

catch
    % Si hi ha un fallo, com per exemple que es tanca la finestra del draw,
    % el que es fa és retornar com a 'false' el contador-porta
    % v'porta_window_drawline', de manera que es pugui anunciar fora de la
    % funció que hi ha el fallo, i que s'ha de repetir, o no.
    % Els objectes binaris es retornen sense que hi hagi una modificació d'aquests.
    

    porta_window_drawline = false;

    % Definim variables:
    bwlabel_BW_obj_sumatlinia = false;
    imatge_BW_colors = false;
    zeros_imatge_cotxe_punts_units = false;   


end
% FINAL FUNCIÓ

end
