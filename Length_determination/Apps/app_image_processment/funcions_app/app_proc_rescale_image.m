function app_proc_rescale_image(app)

% Re-scale the image
%
%
% See also
% app_image_processment



% START OF THE FUNCTION

% __Posicions figura i imatges__
    % S'obtenen les posicions inicials, i es guarden
    pos_fig = app.UIFigure.Position;
    pos_img =  app.Image.Position;
    
    % Posicions imatge 2 i 3
    pos_img_3_1 = app.Image3.Position;     
    
    % Posicio imatge rellotge arena
    pos_rellotge = app.Image2.Position;
                
    
    % __Posicions objectes__

    % Posicions dels objectes en Panel Left
    %h_determin = findobj(app.LeftPanel,'Type','uibutton');
    h_determin = findall(app.LeftPanel);
    array_positions_buttons = [];
    for cada = 1:length(h_determin)
       boto = h_determin(cada); % es defineix el botó
       % guardem les posicions
       if isempty(array_positions_buttons); array_positions_buttons = [boto.Position];
       else array_positions_buttons = [array_positions_buttons; boto.Position]; end
    end
    
    % Posicions dels objectes en Panel Mig
    h_determin_button = findobj(app.CenterPanel,'Type','uibutton');
    array_positions_buttons_centered = [];
    for cada = 1:length(h_determin_button)
       boto_centered = h_determin_button(cada); % es defineix el botó
       % guardem les posicions
       if isempty(array_positions_buttons_centered); array_positions_buttons_centered = [boto_centered.Position];
       else array_positions_buttons_centered = [array_positions_buttons_centered; boto_centered.Position]; end
    end
    

    % Posicions botons estat del mig
    % Posicions dels objectes en Panel Mig
    h_determin_buttonstate = findobj(app.CenterPanel,'Type','uistatebutton');
    array_positions_buttonsstate_centered = [];
    for cada = 1:length(h_determin_buttonstate)
       boto_centered = h_determin_buttonstate(cada); % es defineix el botó
       % guardem les posicions
       if isempty(array_positions_buttonsstate_centered); array_positions_buttonsstate_centered = [boto_centered.Position];
       else array_positions_buttonsstate_centered = [array_positions_buttonsstate_centered; boto_centered.Position]; end
    end            

    
    % _Estat finestra i contadors_
    % S'obté l'estat de la figura, en string.
    string_wind = string(app.UIFigure.WindowState);
    
    % Definició dels contadors d'entrada/sortida
    has_maximized = false;
    has_normaled = false;
    
    % _Entrada del loop_
    while_cond = true;
    while while_cond %app.close_stateLabel.Text ~= "close" % Del Callback UIFigureCloseRequest
        pause(0.001) % Pausa necessaria
        
        % Definim estat finestra
        string_wind = string(app.UIFigure.WindowState);
        
        % Si està maximitzada
        if string_wind == 'maximized' && ~has_maximized
            pause(1) % Pausa necessaria obrir finestra, i obtenir mesura bona
            
            % Per la imatge present:
            
            % Definim mesura figura inicial
            pos_fig2 = app.UIFigure.Position;

            % Definim nova escala per la funció
            % rescale_values_img_app
            pos_img2 = rescale_values_img_app(pos_fig, pos_img, pos_fig2);
            
            % Modificació AUTOREFLOW:
            % Volem que s'ajusti no al complert de la imatge, sino
            % al complert del quadre, donat que amb autoreflow el
            % quadre és variant, els tres varien de posicionsde
            % manera que la estètica de les posicions no es igual
            % que la inicial. Per això, ajustant la imatge al AMPLE
            % de les posicions del cuadre central, s'obtindrà la
            % imatge d'aquesta quan es faci l'escalat:
            pos_centrp = app.CenterPanel.Position;
            pos_img2(3) = pos_centrp(3);
            app.Image.Position = round(pos_img2);
            drawnow()
            
                                
            
            % Imatges 3_1 i 3_2
            % Definim la posicio en base a la central de la app, és
            % a dir, la mitat de la llargada, que serà el que es
            % sumarà o restarà a la posició x.
            pos_img_3_1_2 = rescale_values_img_app(pos_fig, pos_img_3_1, pos_fig2);
            llargada_centre = pos_fig2(3)/2;
            pos_img_3_1_2(1) = llargada_centre - pos_img_3_1_2(3)*2;

            
            app.Image3.Position = round(pos_img_3_1_2);

            
            drawnow()
             
            % Imatge rellotge arena
            pos_rellotge_max = pos_rellotge; pos_rellotge_max(1) = pos_fig2(3)/2; pos_rellotge_max(2) = pos_fig2(4)/2; 
            app.Image2.Position = pos_rellotge_max;

            
            % Modificacio botons pim pam
             array_positions_buttons_new = [];
             [n_botons, ~] = size(array_positions_buttons);
             for cada_boto = 1:n_botons
                pos_boto_old = array_positions_buttons(cada_boto,:); pos_boto_new = pos_boto_old;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2); pos_boto_new(4) = pos_boto_rescale(4);

                % Guardem en array
                if isempty(array_positions_buttons_new); array_positions_buttons_new = [pos_boto_new];
                else array_positions_buttons_new = [array_positions_buttons_new; pos_boto_new]; end
             end

            % Cambiem la posició dels botóns
            % en base al array definit
            for cada = 1:length(h_determin)
               boto = h_determin(cada);
               boto.Position = array_positions_buttons_new(cada, :);
            end

            
            % Modificacio botons Panell central
             array_positions_buttons_new_central = [];
             [n_botons_central, ~] = size(array_positions_buttons_centered);
             for cada_boto = 1:n_botons_central
                pos_boto_old_central = array_positions_buttons_centered(cada_boto,:); pos_boto_new = pos_boto_old_central;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2); pos_boto_new(4) = pos_boto_rescale(4);
                %pos_boto_new = pos_boto_rescale;

                % Guardem en array
                if isempty(array_positions_buttons_new_central); array_positions_buttons_new_central = [pos_boto_new];
                else array_positions_buttons_new_central = [array_positions_buttons_new_central; pos_boto_new]; end
             end
            % Cambiem la posició dels botóns
            % en base al array definit
            for cada = 1:length(h_determin_button)
               boto = h_determin_button(cada);
               boto.Position = array_positions_buttons_new_central(cada, :);
            end
            


            
            % Modificacio botons State Panell central
             array_positions_buttons_new_central_state = [];
             [n_botons_central, ~] = size(array_positions_buttonsstate_centered);
             for cada_boto = 1:n_botons_central
                pos_boto_old_central = array_positions_buttonsstate_centered(cada_boto,:); pos_boto_new = pos_boto_old_central;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2); pos_boto_new(4) = pos_boto_rescale(4);
                %pos_boto_new = pos_boto_rescale;

                % Guardem en array
                if isempty(array_positions_buttons_new_central_state); array_positions_buttons_new_central_state = [pos_boto_new];
                else array_positions_buttons_new_central_state = [array_positions_buttons_new_central_state; pos_boto_new]; end
             end
            % Cambiem la posició dels botóns
            % en base al array definit
            for cada = 1:length(h_determin_buttonstate)
               boto = h_determin_buttonstate(cada);
               boto.Position = array_positions_buttons_new_central_state(cada, :);
            end


            
            % Re-definim contadors
            has_maximized = true;
            has_normaled = false;
            
        % Si està normal
        elseif string_wind == 'normal' && ~has_normaled && has_maximized
            pause(1) % Pausa necessaria tancar finestra, i obtenir mesura bona
                        %  çç editable a fins que no varii la llargada cada 0.1s.
                      
            % Per la imatge present:
            % Re-definim les mesures de la imatge segons les inicials.
            app.Image.Position = pos_img;
            drawnow()
            app.Image3.Position = pos_img_3_1;

            app.Image2.Position = pos_rellotge;

            % Cambiem els botóns
            % en base al array definit
            for cada = 1:length(h_determin)
               boto = h_determin(cada);
               boto.Position = array_positions_buttons(cada, :);
            end
            
            % Cambiem botons Centrals
            for cada = 1:length(h_determin_button)
               boto = h_determin_button(cada);
               boto.Position = array_positions_buttons_centered(cada, :);
            end
            
            % Re-definim contadors
            has_normaled = true;
            has_maximized = false;
        end
        %disp(string(app.UIFigure.WindowState))
        %disp("Figure")
        %app.UIFigure.Position
        %disp("image")
        %app.Image.Position
        
        %disp("Centerpanel")
        %app.CenterPanel.Position
        
        % Tancament del loop:
        if isequal(app.vapp_tancament_loop, "tancar")
           while_cond = false; 
        end
        
    end


% END OF THE FUNCTION


end

