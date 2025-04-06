function [dades_imatge, dades_imatge_punts, zeros_imatge_cotxe, porta_window_drawline, ep_rounded] = draw_line_length(im_original, escala_imatge)

% Donada una imatge original, es fa una línia en aquesta, i s'obté la mesura.
%
%
% Variables
% ---------
% input:
%   im_original : (opcional) Imatge original a superposar a la binària
%   escala_imatge : escala de la imatge.
%
% output:
%   dades_imatge : llargada de la línia pixel a pixel
%   dades_imatge_punts : llargada de la línia sols posicions determiandes (error Fiji)
%   zeros_imatge_cotxe : imatge esqueletonitzada
%   porta_window_drawline : determinació si s'ha executat o no la funció correctament.
%   ep_rounded : punts de la imatge.
%
% See also
% dividie_BWobj_manual_multiple

% INICI FUNCIÓ

% Dibuixem línia
try
    

    s_var = get(0, 'ScreenSize');
    imshow(im_original)
    set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])



    h1 = drawpolyline('Color', 'Yellow', 'SelectedColor','yellow');
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
    
    % DEFINIM LINIA EN IMATGE BINÀRIA
    
    % Imatge de zeros igual que la inicial
    [xd1, xd2, ~] = size(im_original);
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
    
    % Aquesta és la imatge esqueletonitzada.
    
    % imshow(zeros_imatge_cotxe)
    
    % _Comprovació_ que és una imatge esqueletonitzada única, i que no té amplades:
    BWskel_zeros_imatge_cotxe = bwskel(zeros_imatge_cotxe);
    
    if unique(BWskel_zeros_imatge_cotxe  == zeros_imatge_cotxe) ~= 1
        error("error in draw_line_length: it is not an skel image?")
        porta_window_drawline = false;
    end
    
    
    % ___Obtenció de la llargada numèrica___

    % _Per suma de pixels de la imate esqueletonitzada definida_
    [Area_Josep] = llargada_josep(zeros_imatge_cotxe); % LLargada Josep de la imatge esqueletonitzada
    % Es podria incorporar: llargada_josep_Fiji, però és més exacte la
    % determinacio pels punts definits en el draw, com es fa i s'obté
    % dades_imatge_2

    Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)
    
    dades_imatge = Area_Josep_scaled;

    % _Per suma de la distància entre els punts definits (error Fiji)_
    [Area_Josep2] = ditancia_varis_punts(ep_rounded); % Llargada pels punts definits.    

    Area_Josep_scaled_2 = Area_Josep2 / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)
    
    dades_imatge_punts = Area_Josep_scaled_2;
    

catch
    % Si hi ha un fallo, com per exemple que es tanca la finestra del draw,
    % el que es fa és retornar com a 'false' el contador-porta
    % v'porta_window_drawline', de manera que es pugui anunciar fora de la
    % funció que hi ha el fallo, i que s'ha de repetir, o no.
    % Els objectes binaris es retornen sense que hi hagi una modificació d'aquests.
    
   porta_window_drawline = false; 
   
   dades_imatge = 0;
   dades_imatge_punts = 0;
   zeros_imatge_cotxe = false;
   ep_rounded = [];

end


% FINAL FUNCIÓ


end