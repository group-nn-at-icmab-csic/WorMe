function [BW_object_sing, porta_seleccio_correcte] = select_BW_object_manually(suma_binaries_BW)

% Es selecciona de manera manual un objecte binari d'una imatge binària, i s'aïlla aquest.

% porta_seleccio_correcte : per a veure si s'ha executat correctament.

% % Variable de mostra
% imshow(suma_binaries_BW)
%
%

% INICI FUNCIÓ

try
% __Selecció manual objecte binari__
seleccio_correcte = 1;
while seleccio_correcte
    % Imatge inicial
    s_var = get(0, 'ScreenSize');
%     f_var = imshowpair(I1_croped, ...
%         imoverlay(I1greyAdj_croped .* 1.2, ~I1greyAdj_nouBW_croped, [0 200/255 0]), ...
%         "montage");

    f_var = imshow(suma_binaries_BW);
    set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])
    % Obtenim el punt a mà
    h = drawcrosshair();
    posicio = h.Position;
    posicio = round(posicio);
    
    % Determinem el valor del píxel
    valor_en_pixel = suma_binaries_BW(posicio(2), posicio(1));
    
    if valor_en_pixel > 0
        BW_object_sing = bwselect(suma_binaries_BW, posicio(1), posicio(2));
        
        if ismember(1, unique(BW_object_sing)) % ~(~I1greyAdj_nouBW_croped(posicio(2), posicio(1)))
            seleccio_correcte = 0;
        else
            waitfor(msgbox('Select binary object, please.'));
        end
    else
        waitfor(msgbox('Select binary object, please.'));
    end


end
close

    porta_seleccio_correcte = true;
catch
    BW_object_sing = suma_binaries_BW;
    porta_seleccio_correcte = false;
end
% FINAL FUNCIÓ

end