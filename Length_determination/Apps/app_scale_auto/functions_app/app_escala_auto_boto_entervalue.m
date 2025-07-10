function app_escala_auto_boto_entervalue(app)

% from app_scale_auto_boto App, enter value button.

% FUNCTION START


    % Dialog box
    prompt = "Determine the scale units value:";
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);

    %word_num = str2double(answer{1});
    word_num = answer{1};

    
    app.length_unitLabel.Text = word_num;
    
    
    % If both values are determined
    if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
        valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
        valor_unitat = str2double(app.length_unitLabel.Text);
        
        escala_total = valor_distancia_pixels / valor_unitat;

        app.scale_valueLabel.Text = string(escala_total);
        
        % Makes visible the exit button
        app.DoneButton.Visible = 'on';


        % __Describe new action__
        % Define initial message
        app.Label.Text = "";

        app.ScalevalueLabel.Visible = 'on';
        app.scale_valueLabel.Visible = 'on';
        app.pxuLabel.Visible = 'on';

    end            


% FUNCTION END

end

