function app_escala_linia_boto_done(app)

% from app_scale_line App, the Done button.

% START OF FUNCTION

    % We save the value
    distancia_valor = app.scale_valueLabel.Text;

    % Create text
    % we define folder and file
    carpeta_out = app.path_carpeta_outLabel.Text;            
    arxiu_text_output = strcat(carpeta_out, "\escale_line.txt");
    escala_write = ["escala", distancia_valor];
    write_text_array(arxiu_text_output, escala_write, ";")

    % Read text
    %[array_text, string_total] = read_text_delimiters(arxiu_text_output, ";");

    close all force

% END OF FUNCTION

end