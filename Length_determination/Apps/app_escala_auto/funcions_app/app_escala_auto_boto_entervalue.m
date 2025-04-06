function app_escala_auto_boto_entervalue(app)

% From app_escala_auto_boto App, enter value button.

% FUNCTION START


    %Quadre diàleg
    prompt = "Determine the scale units value:";
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);

    %word_num = str2double(answer{1});
    word_num = answer{1};

    
    app.length_unitLabel.Text = word_num;
    
    
    % Si están els dos valors determinats
    if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
        valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
        valor_unitat = str2double(app.length_unitLabel.Text);
        
        escala_total = valor_distancia_pixels / valor_unitat;

        app.scale_valueLabel.Text = string(escala_total);
        
        % Fem visible botó sortida
        app.DoneButton.Visible = 'on';


        % __Describim nova acció__
        % Definim missatge inicial
        app.Label.Text = "";

        app.ScalevalueLabel.Visible = 'on';
        app.scale_valueLabel.Visible = 'on';
        app.pxuLabel.Visible = 'on';

    end            


% FUNCTION END

end

