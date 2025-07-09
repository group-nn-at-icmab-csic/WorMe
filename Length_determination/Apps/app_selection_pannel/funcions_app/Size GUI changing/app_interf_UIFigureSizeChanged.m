function app_interf_UIFigureSizeChanged(app)

% When the App's size is changed (expanded or contracted).
%
%
% See also
% app_selection_pannel


% START OF THE FUNCTION   
        
    position = app.UIFigure.Position;
    
    % If per a que no peti al inici:
    if app.StartupFcnContTextArea == "StartupFcnCont"
        % Per a fer que no peti al principi
        
        app.StartupFcnContTextArea = "";
    else
        
        
        % ____RE- ESCALAR LA IMATGE____
        
        % ÇÇÇ Possible determinació del temps de maximitzar o
        % minimitzar la figura, en funció al temps que transcorri
        % entre el que canvia la posició al maximitzar la figura.
        % seria emprar pause(0.001) aprox.
        
        % _Definim mesura figura inicial_
        pos_fig = double(split(string(app.posFigTextArea), ";"))';
    
        pause(1) % Pausa necessaria obrir finestra, i obtenir mesura bona
        
        % _Definim mesura figura actual_
        pos_fig2 = app.UIFigure.Position;
    
        
        % _Re- escalar botóns_
        % Lectura posicions inicials
        button_text = app.posButtonsTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uibutton');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
    
            % Si volem que no s'eixamplin els botóns:
            pos_ini_but = but_values(n_but, :);
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
        
        
        
        % _Re- escalar State botóns_
        % Lectura posicions inicials
        button_text = app.posStateButtonsTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uistatebutton');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
    
            % Si volem que no s'eixamplin els botóns:
            pos_ini_but = but_values(n_but, :);
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end                
        
    
        
        % _Re- escalar listbox_
        % Lectura posicions inicials
        listbox_text = app.posListboxTextArea;
        listbox_values = app_resize_lectura_str(listbox_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uilistbox');
        [row_n, ~] = size(listbox_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, listbox_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                        
        
        
        
        % _Re- escalar label_
        % Lectura posicions inicials
        button_text = app.posLabelTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uilabel');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                        
        
        % _Re- escalar imatges_
        % Lectura posicions inicials
        button_text = app.posImatgesTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uiimage');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                                
        
    
    
        
        % _Re- escalar hiperlink_
        % Lectura posicions inicials
        button_text = app.posHyperlinkTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uihyperlink');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
        
       
        %_Re- escalar font size_
        fact_fontsize = str2double(app.sizeFontTextArea);
        new_font_size = sqrt(pos_fig2(3) * pos_fig2(4)) * fact_fontsize;
        
        % Tamany de les fonts, per cada hyperlink
        h_determin_button = findobj(app.UIFigure,'Type','uihyperlink');
        for n_but = 1:length(h_determin_button)
            % Obtenim el objecte:
           boto = h_determin_button(n_but);
           %boto.Position
           boto.FontSize = new_font_size;            
        end
        
        % Tamany de les fonts, NOMÈS UN LABEL (app.CitationLabel)
        h_determin_button = app.CitationLabel; %findobj(app.UIFigure,'Type','uilabel');
        for n_but = 1:length(h_determin_button)
            % Obtenim el objecte:
           boto = h_determin_button(n_but);
           %boto.Position
           boto.FontSize = new_font_size;            
        end         
        
        
        % _Re- escalar listbox_
        % Lectura posicions inicials
        listbox_text = app.posSpinner;
        listbox_values = app_resize_lectura_str(listbox_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uispinner');
        [row_n, ~] = size(listbox_values);
        % Per cada botó 
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, listbox_values(n_but, :), pos_fig2);
    
            % Si volem que no s'eixamplin els botóns:
            pos_ini_but = listbox_values(n_but, :);
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end                   
        
        
    
        
        % _Re- escalar Grafic_
        % Lectura posicions inicials
        button_text = app.posUIAxes;
        but_values = app_resize_lectura_str(button_text);
        
        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','axes');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                    


    
        % _Re- escalar Edit Field_
        % Lectura posicions inicials
        button_text = app.posEditfield;      % posEditfield
        but_values = app_resize_lectura_str(button_text);
        

        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uinumericeditfield');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end



    
        % _Re- escalar Check Box_
        % Lectura posicions inicials
        button_text = app.posCheckBox;      % posEditfield
        but_values = app_resize_lectura_str(button_text);
        

        % Posicions dels botóns
        h_determin_button = findobj(app.UIFigure,'Type','uicheckbox');
        [row_n, ~] = size(but_values);
        % Per cada botó
        for n_but = 1:row_n
            % Rescalem la posicio
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Cambiem posicio boto
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end        






                      
                       
        
    end




% FINAL OF THE FUNCTION


end
 