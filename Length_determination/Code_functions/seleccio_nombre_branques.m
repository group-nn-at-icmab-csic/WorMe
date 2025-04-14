function [llistat_imatges_branques_nou] = seleccio_nombre_branques(llistat_imatges_branques, numero_punts_branques)

    % Selecciona de la cell de diferents imatges binàries, aquelles que presenten un determinat numero màxim de branques.
    % La detecció es fa per mitjà dels "endpoints" de la imatge binària.

    % -- input: llistat_imatges, numero_punts_branques   <- la cell
    % -- output: llistat_imatges_nou  <- es fa un filtre a la primera
    
    % Selecciona de la cell de diferents imatges binàries, aquelles que 
    % presenten un determinat numero màxim de branques.
    % La detecció es fa per mitjà dels "endpoints" de la imatge binària.
    
%% INICI FUNCIÓ

% disp(strcat("SELECCIO BRANQUES IMATGE. Nº BRANQUES:  ", num2str(numero_punts_branques)))

%Selecciona si esqueleton té menys de X punts finals i si la llargada de
%les branques es molt petita.
llistat_imatges_branques_nou = {};
% Per cada imatge de la cell
for cada = 1 : length(llistat_imatges_branques)
    cada_imatge_BW = llistat_imatges_branques{cada};
    BW_skel_cell = bwskel(cada_imatge_BW);  %, (__, 'MinBranchLength', 105)
    [endpoint_i, ~] = find(bwmorph(BW_skel_cell,'endpoints')); %punts finals de la imatge esqueletonitzada
    if numel(endpoint_i) <= numero_punts_branques
        llistat_imatges_branques_nou{length(llistat_imatges_branques_nou)+1} = cada_imatge_BW;
    end

end

length(llistat_imatges_branques_nou);

for every_imatge = 1:length(llistat_imatges_branques_nou)
    every_imatge_BW = llistat_imatges_branques_nou{every_imatge};
    BW_skel_cell_loop = bwskel(every_imatge_BW);  %, (__, 'MinBranchLength', 105)
%     figure
%     imshow(imoverlay(every_imatge_BW, BW_skel_cell_loop, 'r')); 
end


%% FINAL FUNCIÓ


end