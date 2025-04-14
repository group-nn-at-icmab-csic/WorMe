function [imatge_rotada, mean_rowcol, sd_rowcol, n_rowcol] = rotar_imatge(BW_amplada, escala_imatge, crop_or_not, marge_error)
    
    % Donada una imatge binària, la qual és una part del C. elegans, es rota fins que la hortizontalitat d'aquesta és mínima, de manera que es pugui fer servir a posteriori per a obtenir l'amplada d'aquesta.
    
        % inputs: BW_amplada (opcional), escala_imatge, marge_error (opcional)
    % outputs: imatge_rotada, mean_rowcol, sd_rowcol, n_rowcol
        
    % Comentaris:
    % Es rota la imatge de manera que ens quedem amb la imatge que té un menor
    % nombre de columnes horitzontals. Això significa que la imatge és
    % encaixada al máxim possible. 
    
    % Variables Josep ara
    % Nota: aquest programa prové del: distancia_mitja

    %% INICI CODI
    
%   % A DES-COMENTAR:
%     if nargin <4
%         marge_error = 0.05
%     end
    

    if crop_or_not == "crop"
        BW_amplada_crop_rot = imcrop(BW_amplada);
    else
        BW_amplada_crop_rot = BW_amplada;
    end
    
    if string(escala_imatge) == "chose"
        [escala_imatge] = escala_determinar(BW_amplada);
    end

    
    % Imatge inicial
    imshow(BW_amplada_crop_rot)
    
    
    % Agreguem zeros a la primera imatge i obtenim mesures per a definir
    % les posteriors igual que aquesta, per al video.
    frame_primera_marges = ficar_marges(BW_amplada_crop_rot);
    [rows_ficar, cols_ficar, ~] = size(frame_primera_marges);

    % Definim dimensións máximes del primer frame. Nota tots els frames
    % següents han de ser uniformes i no majors que el primer. Al ser
    % igualats la posició amb el primer, el primer ha de tenir la mesura
    % máxima. La mesura máxima es igual a un cuadrat amb costats iguals a
    % la diagonal del rectangle inicia; més d'aixo no pot mesurar la
    % rotació d'una imatge rectangular.
    col_rows_ficar = ceil(sqrt(rows_ficar^2 + cols_ficar^2)); 
    rows_ficar_j = col_rows_ficar - rows_ficar; 
    cols_ficar_j = col_rows_ficar - cols_ficar; 
    frame_imatge_primera = agregar_zeros(frame_primera_marges, [rows_ficar_j, cols_ficar_j]);
    imshow(frame_imatge_primera)
    [row_ini, col_ini, ~] = size(frame_imatge_primera);
    
    % Pulim les vores
    SE = strel("disk", 4);
    BW_amplada_crop_rot = imopen(BW_amplada_crop_rot, SE);
    imshow(BW_amplada_crop_rot)
    
    % Imatge inicial : BW_amplada_crop_rot
    
    cell_video = {frame_imatge_primera}; %<- %%% proba
    
    len_grau_bo = 9999999;
    for graus = 1:180
        imatge_rotada = imrotate(BW_amplada_crop_rot, graus);
        
        % Obtenim nombre columnes i files
        [rows, cols] = size(imatge_rotada);
        llargada_BW = length(rows);
        
        % Sum de les columnes o files
        %suma_rowcol = sum(imatge_rotada, 1); %<- sum of each colum (si es
        %volgués fer així)
        suma_rowcol = sum(imatge_rotada, 2); %<- sum of each row
        
        % Treiem el numero de zeros, i mirem quina es aquesta llargada:
        suma_col_nonzero = nonzeros(suma_rowcol);
        length_suma_col_nonzero = length(suma_col_nonzero);
        
        if length_suma_col_nonzero < len_grau_bo
            len_grau_bo = length_suma_col_nonzero;
            grau_bo = graus;
            figure
            %imshow(imatge_rotada)

            % - - > ficar_marges.m < - - | Fiquem marges a la imatge
            imatge_output = ficar_marges(imatge_rotada);  %<- ficar_marges.m
            
            [size_rows, size_cols, ~] = size(imatge_rotada);
            rows_a_ficar = row_ini - size_rows;
            cols_a_ficar = col_ini - size_cols;
            frame_imatge_output = agregar_zeros(imatge_output, [rows_a_ficar, cols_a_ficar]);
            cell_video{length(cell_video)+1} = frame_imatge_output;
            % Nota: es podria fer video (alomillor no cal)
        end
    end
    
    % Creació video de la rotació
    % A partir de la cell amb les imatges uniformades (cell_video), fem
    % un video.
    % proba_video(cell_video) %<---funció---: proba_video.m

    % Amb el millor angle (grau_bo), girem la imatge inicial
    imatge_rotada = imrotate(BW_amplada_crop_rot, grau_bo);
    imshow(imatge_rotada)
    
    % - - > funció ficar_marges.m < - -  (graficar)
    % [dades_imatge] = ficar_marges(BW_verticalized_marges)
    ficar_marges(imatge_rotada); % <- graficar imatge    
    
    
    % Ara tenim la imatge girada al máxim d'ajustat.
    
    % el que hem de fer és descartar les franjes de la imatge que no ens interessen. Per a 
    % % fer-ho, considerem la suma de les són
    % considerades 'outliners'
    
    % _ Suma columnes imatge 'horitzontalitzada' _
    suma_rowcol = sum(imatge_rotada, 1); %<- sum of each column
    
    % _ Descartem zeros imatge _
    imatge_rotada = imatge_rotada(:, ~suma_rowcol == 0 );
    imshow(imatge_rotada)
    suma_rowcol = sum(imatge_rotada, 1); %<- sum of each column
    

    
    % -Control-
    llargada_escurs1 = length(suma_rowcol);
    
    % _ Descartem per moda numèrica _
    
    % sd_rowcol = std(suma_rowcol)
    % mean_rowcol = mean(suma_rowcol)
    mode_rowcol = mode(suma_rowcol)
    
    
    imatge_rotada = imatge_rotada(:, ...
        suma_rowcol >  mode_rowcol + mode_rowcol*marge_error | ...
        suma_rowcol >  mode_rowcol - mode_rowcol*marge_error );
    
    % _ Imatge final _ 
    imshow(imatge_rotada)
    suma_rowcol = sum(imatge_rotada, 1); %<- sum of each column

    
    % _Escalat_
    suma_rowcol = suma_rowcol * escala_imatge; % [unitats / pixel]
    
    % -Control-
    llargada_escurs2 = length(suma_rowcol);
    disp("Reducció llargada (percentatge)")
    ((llargada_escurs1 - llargada_escurs2) / llargada_escurs1) * 100;
    
    % Estadística
    mean_rowcol = mean(suma_rowcol)
    sd_rowcol = std(suma_rowcol)
    n_rowcol = length(suma_rowcol)
    
    % Grafiquem valors numèrics de l'amplada
    plot(1:length(suma_rowcol), suma_rowcol)
    ylim([mean_rowcol - sd_rowcol*4 ; mean_rowcol + sd_rowcol*4])
    xlim([-10 ; length(suma_rowcol)+10])

    % Ficar text imatge original
    imatge_rotada_text = ficar_text_imatge(imatge_rotada, "Mean: ", round(mean_rowcol, 1), "rescale");
    imshow(imatge_rotada_text)


    % FINAL CODI

end