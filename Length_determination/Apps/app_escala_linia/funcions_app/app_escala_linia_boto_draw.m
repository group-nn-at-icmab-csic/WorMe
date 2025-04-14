function app_escala_linia_boto_draw(app)

% From app_escala_linia App, the Draw line button.

% START OF FUNCTION

    if isempty(app.Image3.ImageSource)
        imatge_a_draw = app.Image2.ImageSource;
    else
        imatge_a_draw = app.Image3.ImageSource;
    end
    imshow(imatge_a_draw)
    s = get(0, 'ScreenSize');
    set(gcf,'Units', 'pixels', 'Position',[0 0 s(3) s(4)])
    h1 = drawline('SelectedColor','yellow');
    h1.Selected = true;
    h1.wait
    ep = h1.Position;
    close
    
    epc = ceil(ep);

    % VELL
    % % llargada horitzontal
    % distancia_horitzontal = epc(2,1) - epc(1,1);
    % % Guardem el valor
    % app.distancia_pixelsLabel.Text = string(distancia_horitzontal);

    % Exemple
    % ep = [36.7469   27.8300 149.8187   27.8300]
    % % y1 x1 y2 x2
    
    
    % Draw line entre dos punts d'una imatge.
    
    punt_1 = [epc(1,:)];
    % ex: 37 28
    punt_2 = [epc(2, :)];
    % ex: 150 28
    
    % Fem imatge de zeros
    [x_s, y_s, ~] = size(imatge_a_draw);
    imatge_ini_zeros = zeros(x_s, y_s);
    size(imatge_ini_zeros);
    
    % La fem llògica (binària)
    BW_imatge_ini_zeros = logical(imatge_ini_zeros);
    islogical(BW_imatge_ini_zeros);
    
    %Marquem els punts
    BW_imatge_ini_zeros(punt_1(2), punt_1(1)) = 1;
    BW_imatge_ini_zeros(punt_2(2), punt_2(1)) = 1;
    
    % Punts x y determinats
    %[x_punts_det, y_punts_det] = find(BW_imatge_ini_zeros)
    
    
    %bwconvhull
    BW_final_convull = bwconvhull(BW_imatge_ini_zeros);
    %figure; imshow(BW_final_convull)
    
    % Obtenim la llargada a partir de la imatge de punts:
    % llargada horitzontal
    distancia_punts = llargada_josep(BW_final_convull) -1;
    % Restem 1 perque suposem que la llargada és del punt mig del
    % pixel seleccionat al punt mig del altre pixel seleccionat.
    % Sinó, el valor seria entre el punt inicial del pixel al punt
    % inicial, és a dir, que si la llargada fos d'un pixel seria de
    % 1, mentre que realment hauria de tenir valor de 0.
    % És a dir, la distància entre dos pixels junts no és 2, sinó
    % 1, per aixo la funció llargada_josep donaria valor de 2, i se
    % li aplica la correcció de -1.
    
    % Guardem el valor
    app.distancia_pixelsLabel.Text = string(distancia_punts);
    % [Area_Josep] = llargada_josep(BW_skel) ÑÑÑÑÑ

    imatge_final_punts = imoverlay(imatge_a_draw, BW_final_convull, "r");
    
    % Grafiquem imatge
    app.Image.ImageSource = imatge_final_punts;
    
    % __Describim nova acció__
    % Definim missatge inicial
    app.Label.Text = "Describe the numerical value";
    app.ScalerulevalueButton.Visible = 'on';            
    

    % Si están els dos valors determinats
    if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
        valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
        valor_unitat = str2double(app.length_unitLabel.Text);
        
        escala_total = valor_distancia_pixels / valor_unitat;

        app.scale_valueLabel.Text = string(escala_total);
        
        % Fem visible botó sortida
        app.DoneButton.Visible = 'on';
          
    end

% END OF FUNCTION

end