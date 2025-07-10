function app_interf_definicio_mean_width(app, S_textscan_table)

% Definició del valor del filtre d'amplada mitja

% INICI FUNCIÓ

            
% Definim la taula filtrada per les imatges seleccionades:
S_textscan_table_yesfilt = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);

% __Filtre amplada mitja__            
% El valor de filtre, es basarà en el valor final que serà el
% factor aplicat a la mitja dels totals d'amplades.

% Obtenim els valors de totes les amplades
width_total_values = appf_split_strindex(S_textscan_table_yesfilt.WidthValues);
% Fem la mitja d'aquests valors
width_total_mean = mean(width_total_values);


% Apliquem el factor de percentatge definit en la GUI
width_val_filtr = (app.SpinnerWidthMean.Value/100) * width_total_mean;

% Definim en el textarea. El valor d'aquest servirà per a aplicar el filtre.
app.MinWidthRefTextArea.Value = string(width_val_filtr);


% FINAL FUNCIÓ


end