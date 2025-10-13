function app_interf_UIFigureSizeChanged(app)

% When the App's size is changed (expanded or contracted).
%
%
% See also
% app_selection_pannel

% START OF THE FUNCTION   
        
    position = app.UIFigure.Position;
    
    % To prevent crashing at startup:
    if app.StartupFcnContTextArea == "StartupFcnCont"
        % To prevent crashing at the beginning
        
        app.StartupFcnContTextArea = "";
    else
        
        
        % ____RE-SCALE THE IMAGE____
        
        % _Define initial figure size_
        pos_fig = double(split(string(app.posFigTextArea), ";"))';
    
        pause(1) % Pause necessary to open window, and get good measurement
        
        % _Define current figure size_
        pos_fig2 = app.UIFigure.Position;
    
        
        % _Re-scale buttons_
        % Read initial positions
        button_text = app.posButtonsTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uibutton');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
    
            % If we want buttons not to widen:
            pos_ini_but = but_values(n_but, :);
            %pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];  % Without changing size of the figure.
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_boto_rescale(3), pos_boto_rescale(4)];

            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
        
        
        
        % _Re-scale State buttons_
        % Read initial positions
        button_text = app.posStateButtonsTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uistatebutton');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
    
            % If we want buttons not to widen:
            pos_ini_but = but_values(n_but, :);
            % pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];  % Without changing size of the figure.
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_boto_rescale(3), pos_boto_rescale(4)];            

            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end                
        
    
        
        % _Re-scale listbox_
        % Read initial positions
        listbox_text = app.posListboxTextArea;
        listbox_values = app_resize_lectura_str(listbox_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uilistbox');
        [row_n, ~] = size(listbox_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, listbox_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                        
        
        
        % _Re-scale label_
        % Read initial positions
        button_text = app.posLabelTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uilabel');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                        
        
        % _Re-scale images_
        % Read initial positions
        button_text = app.posImatgesTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uiimage');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                                
        
    
    
        
        % _Re-scale hyperlink_
        % Read initial positions
        button_text = app.posHyperlinkTextArea;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uihyperlink');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
        
       
        %_Re-scale font size_
        fact_fontsize = str2double(app.sizeFontTextArea);
        new_font_size = sqrt(pos_fig2(3) * pos_fig2(4)) * fact_fontsize;
        
        % Font size, for each hyperlink
        h_determin_button = findobj(app.UIFigure,'Type','uihyperlink');
        for n_but = 1:length(h_determin_button)
            % Get the object:
           boto = h_determin_button(n_but);
           %boto.Position
           boto.FontSize = new_font_size;            
        end
        
        % Font size, ONLY ONE LABEL (app.CitationLabel)
        h_determin_button = app.CitationLabel; %findobj(app.UIFigure,'Type','uilabel');
        for n_but = 1:length(h_determin_button)
            % Get the object:
           boto = h_determin_button(n_but);
           %boto.Position
           boto.FontSize = new_font_size;            
        end         
        
        
        % _Re-scale listbox_
        % Read initial positions
        listbox_text = app.posSpinner;
        listbox_values = app_resize_lectura_str(listbox_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uispinner');
        [row_n, ~] = size(listbox_values);
        % For each button 
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, listbox_values(n_but, :), pos_fig2);
    
            % If we want buttons not to widen:
            pos_ini_but = listbox_values(n_but, :);
            %pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_ini_but(3), pos_ini_but(4)];  % Without changing size of the figure.
            pos_boto_rescale = [pos_boto_rescale(1), pos_boto_rescale(2), pos_boto_rescale(3), pos_boto_rescale(4)];            
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end                   
        
        
        
    
        
        % _Re-scale Graphic_
        % Read initial positions
        button_text = app.posUIAxes;
        but_values = app_resize_lectura_str(button_text);
        
        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','axes');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end
                    


    
        % _Re-scale Edit Field_
        % Read initial positions
        button_text = app.posEditfield;      % posEditfield
        but_values = app_resize_lectura_str(button_text);
        

        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uinumericeditfield');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end



    
        % _Re-scale Check Box_
        % Read initial positions
        button_text = app.posCheckBox;      % posEditfield
        but_values = app_resize_lectura_str(button_text);
        

        % Positions of the buttons
        h_determin_button = findobj(app.UIFigure,'Type','uicheckbox');
        [row_n, ~] = size(but_values);
        % For each button
        for n_but = 1:row_n
            % Rescale the position
            pos_boto_rescale = rescale_values_img_app(pos_fig, but_values(n_but, :), pos_fig2);
            
            % Change button position
           boto = h_determin_button(n_but);
           %boto.Position
           boto.Position = pos_boto_rescale;            
        end        



    end




% FINAL OF THE FUNCTION



end
 