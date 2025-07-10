function app_escala_linia_boto_draw(app)

% from app_scale_line App, the Draw line button.

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

    
    
    % Draw line between two points of an image.
    
    punt_1 = [epc(1,:)];
    % e.g.: 37 28
    punt_2 = [epc(2, :)];
    % e.g.: 150 28
    
    % We create a zero image
    [x_s, y_s, ~] = size(imatge_a_draw);
    imatge_ini_zeros = zeros(x_s, y_s);
    size(imatge_ini_zeros);
    
    % We make it logical (binary)
    BW_imatge_ini_zeros = logical(imatge_ini_zeros);
    islogical(BW_imatge_ini_zeros);
    
    % We mark the points
    BW_imatge_ini_zeros(punt_1(2), punt_1(1)) = 1;
    BW_imatge_ini_zeros(punt_2(2), punt_2(1)) = 1;
    
    % Determined x y points
    %[x_punts_det, y_punts_det] = find(BW_imatge_ini_zeros)
    
    
    % bwconvhull
    BW_final_convull = bwconvhull(BW_imatge_ini_zeros);
    %figure; imshow(BW_final_convull)
    
    % We obtain the length from the image of points:
    % horizontal length
    distancia_punts = worm_length(BW_final_convull) -1;
    % We subtract 1 because we assume that the length goes from the
    % midpoint of the first selected pixel to the midpoint of the
    % other selected pixel. Otherwise, the value would go from the
    % start of the initial pixel to the start of the final pixel,
    % meaning that if the length was one pixel, it would have a
    % value of 1, whereas it should really be 0. That is, the
    % distance between two adjacent pixels is not 2, but 1, so the
    % worm_length function would return a value of 2, and we apply
    % the correction of -1.
    
    % We save the value
    app.distancia_pixelsLabel.Text = string(distancia_punts);
    % [Area_Josep] = worm_length(BW_skel)

    imatge_final_punts = imoverlay(imatge_a_draw, BW_final_convull, "r");
    
    % We display image
    app.Image.ImageSource = imatge_final_punts;
    
    % __We describe new action__
    % Define initial message
    app.Label.Text = "Describe the numerical value";
    app.ScalerulevalueButton.Visible = 'on';            
    

    % If both values are defined
    if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
        valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
        valor_unitat = str2double(app.length_unitLabel.Text);
        
        escala_total = valor_distancia_pixels / valor_unitat;

        app.scale_valueLabel.Text = string(escala_total);
        
        % We make the output button visible
        app.DoneButton.Visible = 'on';
          
    end

% END OF FUNCTION

end