function [bwlabel_BW_obj_sumline, image_BW_colors, door_window_drawline, defined_line] = dividie_BWobj_manual_multiple(BWobj_image, im_original)

% Given a singular binary image, manually define a line along which the binary image intersects.
% Cropped binary image (bwlabel_BW_obj_sumline) is returned, like this
% as the cropped color image (image_BW_colors), and the line (defined_line).
% If a second color (3D) image is defined, it is overlaid
% (f'imoverlay) on the image when selecting the line.
%
% Image can have more than one binary object, but must be binary.
% This will be trimmed.
%
%
%
% Variables
% ---------
% input:
% BWobj_image : Binary image with a single binary object
% im_original : (optional) Original image to overlay on the binary
%
% output:
% bwlabel_BW_obj_sumline : BW image with the line subtracted.
% door_window_drawline : Returns whether or not the function was successfully executed.
% image_BW_colors : Colorized BW image
% defined_line : Defined line.
%
%
% See also
% BW_objects_to_color
% print_RGB_indx_brush




% (ESP)
% -----
% Dada una imagen binaria singular, se define de forma manual una línea con la que se corta la imagen binaria.
% Se devuelve la imagen binaria recortada (bwlabel_BW_obj_sumline), así
% como la imagen en color recortada (image_BW_colors), y la línea (defined_line).
% Este último procedimiento utiliza la función f'BW_objects_to_color'.
% Si se define una segunda imagen en color (3D), se superpone
% (f'imoverlay) en la imagen a la hora de seleccionar la línea.
%
% La imagen puede tener más de un objeto binario, pero debe ser binaria.
% Ésta se recortará.


% (CAT)
% -----
% Donada una imatge binària singular, es defineix de manera manual una línia amb la qual es talla la imatge binària.
% Es retorna la imatge binaria retallada (bwlabel_BW_obj_sumline), així
% com la imatge en color retallada (image_BW_colors), i la línia (defined_line).
% Aquest últim procediment empra la funció f'BW_objects_to_color'.
% Si es defineix una segona imatge en color (3D), es superposa
% (f'imoverlay) a la imatge a l'hora de seleccionar la línia.
%
% La imatge pot tenir més d'un objecte binari, però ha de ser binària.
% Aquesta es retallarà.



% START FUNCTION

% We draw the line
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
    
        % Position of the line points
        ep = h1.Position;
        % We round positions
        ep_rounded = round(ep);
    
        close
    
        if isempty(ep)
            door_window_drawline = false;
        else
            door_window_drawline = true;
        end


    catch
        door_window_drawline = false;

        % Variable definition
        bwlabel_BW_obj_sumline = false;
        image_BW_colors = false;
        defined_line = false;



    end
    
    if door_window_drawline
        % DEFINITION OF THE LINE IN THE BINARY IMAGE
        
        % Zeros image, as the original
        [xd1, xd2, ~] = size(BWobj_image);
        zeros_imatge_cotxe = zeros(xd1, xd2);
        %size(zeros_imatge_cotxe)
        %imshow(zeros_imatge_cotxe)
        
        % Draw the points in the zero image
        for cada_lin = 1:length(ep_rounded)
            %zeros_imatge_cotxe(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
            
            if cada_lin > 1
                % We make a blank zeros image that contains the two pixels
                zeros_imatge_cotxe_blanc = zeros(xd1, xd2);
                
                % Anterior point
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin-1,2), ep_rounded(cada_lin-1,1)) = 1;   
                % Posterior point
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
                
        
                % Draw the line
                zeros_imatge_cotxe_blanc_linea = bwconvhull(zeros_imatge_cotxe_blanc);
                
                % Sum the image to the main zeros image
                zeros_imatge_cotxe = zeros_imatge_cotxe + zeros_imatge_cotxe_blanc_linea;
            end
        end
        
        % Match the values
        zeros_imatge_cotxe = zeros_imatge_cotxe>0;
        
        % The line must be thick, otherwise a single pixel may not separate the image.
        defined_line = bwmorph(zeros_imatge_cotxe, 'diag');
        
        % WE SUBTRACT THE LINE TO THE INITIAL BINARY IMAGE
        bwlabel_BW_obj_sumline = BWobj_image - defined_line;
        bwlabel_BW_obj_sumline(bwlabel_BW_obj_sumline == -1) = 0;
        %unique(bwlabel_BW_obj_sumline)
        
        [image_BW_colors, ~, ~] = BW_objects_to_color(bwlabel_BW_obj_sumline);
        %imshow(image_BW_colors)


    else

        bwlabel_BW_obj_sumline = false;
        image_BW_colors = false;
        door_window_drawline = false;
        defined_line = false;

    end

catch

    % If there is a failure, such as closing the draw window,
     % what is done is to return the port-counter as 'false'
     % v'door_window_drawline', so that it can be advertised outside the
     % function that there is a fault, and that it must be repeated, or not.
     % Binary objects are returned without modification.

     % (CAT)
    % Si hi ha un fallo, com per exemple que es tanca la finestra del draw,
    % el que es fa és retornar com a 'false' el contador-porta
    % v'door_window_drawline', de manera que es pugui anunciar fora de la
    % funció que hi ha el fallo, i que s'ha de repetir, o no.
    % Els objectes binaris es retornen sense que hi hagi una modificació d'aquests.
    
    door_window_drawline = false;

    % Define variables:
    bwlabel_BW_obj_sumline = false;
    image_BW_colors = false;
    defined_line = false;   


end
% END FUNCTION



end
