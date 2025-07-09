function app_escala_auto_boto_selectbar(app)

% From app_escala_auto app, button of select barline.

% START OF FUNCTION

            if isempty(app.Image3.ImageSource)
                imatge_a_draw = app.Image2.ImageSource;
            else
                imatge_a_draw = app.Image3.ImageSource;
            end
            
            % _Seleccionem la barra d'escala_
            % Grafiquem max screen
            imshow(imatge_a_draw)
            s = get(0, 'ScreenSize');
            set(gcf,'Units', 'pixels', 'Position',[0 0 s(3) s(4)])
            % Seleccionem el píxel
            h_drawcross = drawcrosshair();
            position = h_drawcross.Position;
            %color  = h_drawcross.Color;
            %fields(h_drawcross)
            close

            % Obtenim la posició i el color:
            position_round = round(position);

            img_croped_gray = im2gray(imatge_a_draw);
            color_point = img_croped_gray(position_round(2), position_round(1));
            
            n_corr_neg = 15;
            n_corr_pos = 15;
            
            if (double(color_point) - n_corr_neg)  <  0
                n_corr_neg = 0;
                n_corr_pos = 15;
            elseif (double(color_point) + n_corr_pos)  > 255
                n_corr_neg = 15;
                n_corr_pos = 0;
            end
            
            % Apliquem el binaritzat pel color:
            img_croped_BW = (img_croped_gray <= (color_point + n_corr_pos) ) & (img_croped_gray >= (color_point - n_corr_neg) ) ;
            %imshow(img_croped_BW)
            
            % _Selecció de l'objecte_
            BW_obj_escala = bwselect(img_croped_BW, position_round(1), position_round(2));
            %showpair = imshowpair(imatge_a_draw, imoverlay(imatge_a_draw, BW_obj_escala, "r"), "montage");
            %imshow(showpair.CData, 'InitialMagnification', 'fit')
            
            % BW_obj_skel = bwskel(BW_obj_escala);
            % imshow(imoverlay(BW_obj_escala, BW_obj_skel, "r"))
            
            BW_obj_skel = bwmorph(BW_obj_escala,'thin','inf');  %<- BO
            %imshow(imoverlay(BW_obj_escala, BW_obj_skel, "r"))
            
            % % Proba skel 2
            % BW_obj_skel_2 = bwskel(BW_obj_escala);  %<- BO
            % imshow(imoverlay(BW_obj_escala, BW_obj_skel_2, "r"))
            % imshowpair(imoverlay(BW_obj_escala, BW_obj_skel, "r"), imoverlay(BW_obj_escala, BW_obj_skel_2, "r"), "montage")


            % _Obtenim la distància_
            
            [var_y,var_x] = find(bwmorph(BW_obj_skel,'endpoints'));
            % dalt esquerra, baix esquerra, dalt dreta, baix dreta
            % Perque? perque ocorre com els índex, que va de dalt a baix i d'esquerra a
            % dreta.
            [indx_endpoints] = find(bwmorph(BW_obj_skel,'endpoints'));
            
            
            % Si té 4 endpoints
            if length(find(bwmorph(BW_obj_skel,'endpoints'))) == 4
                var_y_new = [var_y(1), var_y(3)];
                var_x_new = [var_x(1), var_x(3)];
                
                
                % %graficar:
                % BW_graph = false(size(BW_obj_skel)); BW_graph(var_y(1), var_x(1)) = true;
                % imshow(imoverlay(BW_obj_skel, BW_graph, "r"))
                % BW_graph = false(size(BW_obj_skel)); BW_graph(var_y(2), var_x(2)) = true;
                % imshow(imoverlay(BW_obj_skel, BW_graph, "r"))
                % BW_graph = false(size(BW_obj_skel)); BW_graph(var_y(3), var_x(3)) = true;
                % imshow(imoverlay(BW_obj_skel, BW_graph, "r"))
                % BW_graph = false(size(BW_obj_skel)); BW_graph(var_y(4), var_x(4)) = true;
                % imshow(imoverlay(BW_obj_skel, BW_graph, "r"))
            
                
            % Si té 2 endpoints    
            elseif length(find(bwmorph(BW_obj_skel,'endpoints'))) == 2
                % ÇÇÇ mirar que passa
                var_y_new = var_y;
                var_x_new = var_x;
            end
            
            % % Graficar own
            % imshow(imatge_a_draw)
            % hold on
            % plot(var_x_new, var_y_new, 'r-', 'LineWidth', 1);
            % hold off
            
            
            % Obtenim distància de X:
            result_prov = var_x_new(2) - var_x_new(1);
            % Si volguéssim saber la distància de tots els pixels sumariem 1, però no ho sumem perquè 
            % la distància va des de l'inici del pixel 1, fins al inici del pixel final. Això vol dir que la distancia del
            % pixel final no es compta, el que es igual a que si la distancia fos del punt mig del pixel inicial al punt mig del pixel final.
            llargada_metro = result_prov;
            
            % Guardem el valor
            app.distancia_pixelsLabel.Text = string(llargada_metro);
            
            % Antic:
            %result_prov = var_s - var_s(1);
            % result_dist = result_prov(result_prov~=0);
            % llargada_metro = unique(result_dist); % <- llargada imatge metro
            
            % Grafiquem
            BW_endpoints_linia = false(size(img_croped_gray));
            BW_endpoints_linia(var_y_new, var_x_new) = true;
            BW_endpoints_linia = bwconvhull(BW_endpoints_linia);
            
            % Imatge mostrar final
            %imshow(imoverlay(imatge_a_draw, BW_endpoints_linia, "r"))
            
            imatge_final_punts = imoverlay(imatge_a_draw, BW_endpoints_linia, "r");
            
            
            % Ficar text pixels
            %[imatge_final_punts_amb_text] = put_txt_to_img(imatge_final_punts, "Horizontal Pixel distance: ", llargada_metro, "rescale");
            app.Image.ImageSource = imatge_final_punts;
            % imshow(imatge_final_punts, 'Parent', app.UIAxes);
            
            
            % Si están els dos valors determinats
            if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
                valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
                valor_unitat = str2double(app.length_unitLabel.Text);
                
                escala_total = valor_distancia_pixels / valor_unitat;

                app.scale_valueLabel.Text = string(escala_total);
                
                % Fem visible botó sortida
                app.DoneButton.Visible = 'on';
            end



            % __Describim nova acció__
            % Definim missatge inicial
            app.Label.Text = "Describe the numerical value";
            app.ScalerulevalueButton.Visible = 'on';

% END OF FUNCTION

end