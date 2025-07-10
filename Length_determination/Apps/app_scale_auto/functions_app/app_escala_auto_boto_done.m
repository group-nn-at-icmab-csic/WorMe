function app_escala_auto_boto_done(app)

% App app_escala_auto, button Done.

% START FUNCTION

    % Save the value
    distancia_valor = app.scale_valueLabel.Text;

    % Create text
    % define folder and file
    carpeta_out = app.path_carpeta_outLabel.Text;

    % Save the scale:
    arxiu_text_output = strcat(carpeta_out, "\escale_line.txt");
    escala_write = ["escala", distancia_valor];
    write_text_array(arxiu_text_output, escala_write, ";")

    % Read text
    %[array_text, string_total] = read_text_delimiters(arxiu_text_output, ";");

    close all force


% END FUNCTION

end