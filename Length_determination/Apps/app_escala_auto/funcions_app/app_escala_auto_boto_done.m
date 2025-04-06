function app_escala_auto_boto_done(app)

% App app_escala_auto, button Done.

% START FUNCTION

    % Guardem el valor
    distancia_valor = app.scale_valueLabel.Text;

    % Crear text
    % definim carpeta i arxiu
    carpeta_out = app.path_carpeta_outLabel.Text;

    % Guardar l'escala:
    arxiu_text_output = strcat(carpeta_out, "\escale_line.txt");
    escala_write = ["escala", distancia_valor];
    write_text_josep(arxiu_text_output, escala_write, ";")

    % Llegir text
    %[array_text, string_total] = llegir_text_delimitadors(arxiu_text_output, ";");

    close all force


% END FUNCTION

end