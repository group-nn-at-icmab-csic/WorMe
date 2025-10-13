function app_escala_linia_boto_enter_value(app)

% from app_scale_line App, the Enter Value button.

% START OF FUNCTION

    % Dialog box
    prompt = "Determine the scale units value:";
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);

    %word_num = str2double(answer{1});
    word_num = answer{1};


    app.length_unitLabel.Text = word_num;


    % If both values are defined
    if ~isempty(app.distancia_pixelsLabel.Text) && ~isempty(app.length_unitLabel.Text)
        valor_distancia_pixels = str2double(app.distancia_pixelsLabel.Text);
        valor_unitat = str2double(app.length_unitLabel.Text);
        
        escala_total = valor_distancia_pixels / valor_unitat;

        app.scale_valueLabel.Text = string(escala_total);
        
        % We make the output button visible
        app.DoneButton.Visible = 'on';


        % __We describe new action__
        % Define initial message
        app.Label.Text = "";

        app.ScalevalueLabel.Visible = 'on';
        app.scale_valueLabel.Visible = 'on';
        app.pxuLabel.Visible = 'on';                


    end            


% END OF FUNCTION


end